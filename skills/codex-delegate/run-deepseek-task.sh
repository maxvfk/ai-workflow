#!/usr/bin/env bash
# Run one Codex task on DeepSeek through the `deepseek` Codex profile (`codex exec -p deepseek`).
# Normally called by run-codex-task.sh --provider deepseek; can also be run directly.
#
# Usage:
#   run-deepseek-task.sh <workdir> <prompt-file> [--write] [--model <model>] [--effort <low|high|max>]
#
# - Read-only sandbox unless --write (then workspace-write).
# - Models: deepseek-flash (profile default; cheap, text+image), deepseek-v4-pro (stronger, text only).
# - Effort: low | high | max. DeepSeek maps minimal->low and medium/xhigh->high server-side.
# - Key: DEEPSEEK_API_KEY. If the variable is not in this process (the Claude app was started before
#   it was set), it is read from the Windows user environment. It is never printed.
# - Summary: duration, session id, token usage and an estimated cost in USD. DeepSeek has no
#   Codex rate_limits; it bills a prepaid balance.

set -uo pipefail

if [ $# -lt 2 ]; then
  sed -n '2,14p' "$0" >&2
  exit 2
fi

WORKDIR=${1//\\//}
PROMPT=${2//\\//}
shift 2

SANDBOX=read-only
MODEL=
EFFORT=
while [ $# -gt 0 ]; do
  case "$1" in
    --write) SANDBOX=workspace-write ;;
    --model)  [ $# -ge 2 ] || { echo "codex-delegate: --model needs a value" >&2; exit 2; }; MODEL=$2; shift ;;
    --effort) [ $# -ge 2 ] || { echo "codex-delegate: --effort needs a value" >&2; exit 2; }; EFFORT=$2; shift ;;
    --resume-last|--resume|--fresh|--background|--keep-runtime)
      echo "codex-delegate: $1 is not supported with --provider deepseek" >&2; exit 2 ;;
    *) echo "codex-delegate: unknown option for deepseek: $1" >&2; exit 2 ;;
  esac
  shift
done

if command -v cygpath >/dev/null 2>&1; then
  WORKDIR=$(cygpath -m "$WORKDIR")
  PROMPT=$(cygpath -m "$PROMPT")
fi
[ -d "$WORKDIR" ] || { echo "codex-delegate: workdir not found: $WORKDIR" >&2; exit 2; }
[ -f "$PROMPT" ] || { echo "codex-delegate: prompt file not found: $PROMPT" >&2; exit 2; }

CODEX_HOME_DIR=${CODEX_HOME:-$HOME/.codex}
if [ ! -f "$CODEX_HOME_DIR/deepseek.config.toml" ]; then
  echo "codex-delegate: no deepseek profile ($CODEX_HOME_DIR/deepseek.config.toml); run setup-deepseek-profile.sh" >&2
  exit 2
fi
command -v codex >/dev/null 2>&1 || { echo "codex-delegate: codex CLI not on PATH" >&2; exit 2; }

if [ -z "${DEEPSEEK_API_KEY:-}" ] && command -v powershell.exe >/dev/null 2>&1; then
  DEEPSEEK_API_KEY=$(powershell.exe -NoProfile -Command \
    "[Environment]::GetEnvironmentVariable('DEEPSEEK_API_KEY','User')" 2>/dev/null | tr -d '\r\n')
fi
if [ -z "${DEEPSEEK_API_KEY:-}" ]; then
  echo "codex-delegate: DEEPSEEK_API_KEY is not set (process or Windows user environment)" >&2
  exit 2
fi
export DEEPSEEK_API_KEY

LAST=$(mktemp "${TMPDIR:-/tmp}/codex-deepseek-last.XXXXXX")
trap 'rm -f "$LAST"' EXIT

CMD=(codex exec -p deepseek --skip-git-repo-check -s "$SANDBOX" -C "$WORKDIR" -o "$LAST")
[ -n "$MODEL" ] && CMD+=(-m "$MODEL")
[ -n "$EFFORT" ] && CMD+=(-c "model_reasoning_effort=$EFFORT")

echo "codex-delegate: provider=deepseek workdir=$WORKDIR prompt=$PROMPT sandbox=$SANDBOX model=${MODEL:-<profile default>} effort=${EFFORT:-<profile default>}"

START_EPOCH=$(date +%s)
START_UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)
OUT=$(mktemp "${TMPDIR:-/tmp}/codex-deepseek-out.XXXXXX")
trap 'rm -f "$LAST" "$OUT"' EXIT

"${CMD[@]}" - < "$PROMPT" 2>&1 | grep -v -e 'DEP0190' -e 'trace-deprecation' | tee "$OUT"
RC=${PIPESTATUS[0]}
END_EPOCH=$(date +%s)

echo
echo "codex-delegate: ---- final answer ----"
if [ -s "$LAST" ]; then cat "$LAST"; echo; else echo "codex-delegate: (no final message)"; fi

echo "codex-delegate: ---- summary ----"
echo "codex-delegate: Duration: $((END_EPOCH - START_EPOCH))s"
SID=$(grep -m1 -oE 'session id: [0-9a-f-]{36}' "$OUT" | awk '{print $3}')
RUN_MODEL=$(grep -m1 -oE '^model: [A-Za-z0-9._-]+' "$OUT" | awk '{print $2}')
echo "codex-delegate: session=${SID:-unknown} model=${RUN_MODEL:-unknown} exit=$RC"
if [ -n "$SID" ]; then
  F=$(grep -rl "$SID" "$CODEX_HOME_DIR/sessions" 2>/dev/null | head -1)
  if [ -n "$F" ]; then
    echo "codex-delegate: session file=$F"
    USAGE=$(grep -o '"total_token_usage":{[^}]*}' "$F" | tail -1)
    echo "codex-delegate: $USAGE"
    # Prices in USD per 1M tokens, from https://api-docs.deepseek.com/quick_start/pricing
    # (read 2026-11-12). Peak: 01-04 and 06-10 UTC, Mon-Fri; off-peak is half. Chinese public
    # holidays (off-peak) are not modelled, so the estimate can be high on those days.
    USAGE="$USAGE" RUN_MODEL="${RUN_MODEL:-deepseek-flash}" START_UTC="$START_UTC" node -e '
      const u = JSON.parse("{" + process.env.USAGE + "}").total_token_usage;
      const peak = { "deepseek-flash": [0.006, 0.3, 1.2], "deepseek-v4-pro": [0.044, 1.32, 3.96] };
      const m = process.env.RUN_MODEL;
      const p = peak[m] || peak["deepseek-flash"];
      const t = new Date(process.env.START_UTC), h = t.getUTCHours(), d = t.getUTCDay();
      const isPeak = d >= 1 && d <= 5 && ((h >= 1 && h < 4) || (h >= 6 && h < 10));
      const k = isPeak ? 1 : 0.5;
      const hit = u.cached_input_tokens || 0, miss = u.input_tokens - hit, out = u.output_tokens;
      const usd = k * (hit * p[0] + miss * p[1] + out * p[2]) / 1e6;
      console.log(`codex-delegate: cost ~$${usd.toFixed(4)} (${m}, ${isPeak ? "peak" : "off-peak"}; in ${u.input_tokens} = hit ${hit} + miss ${miss}, out ${out})` +
        (peak[m] ? "" : " [unknown model, flash prices used]"));
    ' 2>/dev/null || echo "codex-delegate: cost estimate unavailable"
  fi
fi
exit "$RC"

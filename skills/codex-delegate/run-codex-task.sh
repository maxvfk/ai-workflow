#!/usr/bin/env bash
# Run one Codex task through the openai-codex Claude Code plugin, safely on Windows/Git Bash.
#
# Usage:
#   run-codex-task.sh <workdir> <prompt-file> [--write] [--model <model>] [--effort <level>] [--resume-last]
#                     [--keep-runtime]
#
# - <workdir>: directory Codex works in (usually the repo root). Backslashes are normalized.
# - <prompt-file>: file with the full task text. Never pass the task text on the command line.
# - Read-only unless --write is given explicitly.
# - After the run, the plugin's broker for <workdir> (app-server-broker.mjs + codex app-server) is
#   shut down; the plugin itself would leave it running until reboot. --keep-runtime skips that.
#
# Run it from the MAIN Claude Code session with the Bash tool's run_in_background, so the
# harness notifies on completion. Exit code is Codex's exit code.

set -uo pipefail

if [ $# -lt 2 ]; then
  sed -n '2,16p' "$0" >&2
  exit 2
fi

COMPANION=$(ls -d "$HOME"/.claude/plugins/cache/openai-codex/codex/*/scripts/codex-companion.mjs 2>/dev/null | sort -V | tail -1)
if [ -z "$COMPANION" ]; then
  echo "codex-delegate: openai-codex plugin is not installed (no codex-companion.mjs found)" >&2
  exit 2
fi

WORKDIR=${1//\\//}
PROMPT=${2//\\//}
shift 2

# Our own option; everything else goes to the plugin unchanged.
KEEP_RUNTIME=0
ARGS=()
for a in "$@"; do
  if [ "$a" = "--keep-runtime" ]; then KEEP_RUNTIME=1; else ARGS+=("$a"); fi
done

# Use Windows-form paths (C:/...): with MSYS_NO_PATHCONV set below, Git Bash no longer translates
# /c/... paths, and Node would read /c/Users as C:\c\Users.
if command -v cygpath >/dev/null 2>&1; then
  COMPANION=$(cygpath -m "$COMPANION")
  WORKDIR=$(cygpath -m "$WORKDIR")
  PROMPT=$(cygpath -m "$PROMPT")
fi

[ -d "$WORKDIR" ] || { echo "codex-delegate: workdir not found: $WORKDIR" >&2; exit 2; }
[ -f "$PROMPT" ] || { echo "codex-delegate: prompt file not found: $PROMPT" >&2; exit 2; }

# Stop Git Bash from rewriting slash-arguments into paths (breaks taskkill /PID inside the plugin).
export MSYS_NO_PATHCONV=1
export MSYS2_ARG_CONV_EXCL='*'

echo "codex-delegate: companion=$COMPANION"
echo "codex-delegate: workdir=$WORKDIR prompt=$PROMPT extra=[${ARGS[*]}] keep-runtime=$KEEP_RUNTIME"

node "$COMPANION" task --cwd "$WORKDIR" --prompt-file "$PROMPT" "${ARGS[@]}" 2>&1 \
  | grep -v -e 'DEP0190' -e 'trace-deprecation'
RC=${PIPESTATUS[0]}

# Summary for the usage readout. The session ID is not reliably in the task output, so take it
# from the plugin's status for this exact workdir (latest job first) and read that session file.
echo
echo "codex-delegate: ---- summary ----"
STATUS=$(node "$COMPANION" status --cwd "$WORKDIR" 2>&1 | grep -v -e 'DEP0190' -e 'trace-deprecation')
echo "$STATUS" | grep -m1 -E 'Duration|Elapsed' | sed 's/^ */codex-delegate: /'
SID=$(echo "$STATUS" | grep -o '[0-9a-f]\{8\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{12\}' | head -1)
echo "codex-delegate: session=${SID:-unknown} exit=$RC"
if [ -n "$SID" ]; then
  F=$(grep -rl "$SID" "$HOME/.codex/sessions" 2>/dev/null | head -1)
  if [ -n "$F" ]; then
    echo "codex-delegate: session file=$F"
    grep -o '"total_token_usage":{[^}]*}' "$F" | tail -1 | sed 's/^/codex-delegate: /'
    grep -o '"primary":{[^}]*}' "$F" | tail -1 | sed 's/^/codex-delegate: 5h window /'
    grep -o '"secondary":{[^}]*}' "$F" | tail -1 | sed 's/^/codex-delegate: weekly /'
  fi
fi

# Shut down the broker for this workdir. The plugin stops brokers only from its Claude SessionEnd
# hook, which looks up broker.json by the Claude session's own cwd, so a broker started for a
# separate workdir is never stopped: it keeps the workdir busy and the Codex thread "open in
# another app". Run the same hook for our workdir. Unset the env vars the hook falls back to:
# CODEX_COMPANION_SESSION_ID would make it delete this Claude session's jobs from the job history
# (status/result would break), and the APP_SERVER_* ones may point at the Claude session's own
# broker when broker.json is missing. Without them it only stops this workdir's broker and clears
# its broker.json.
HOOK="$(dirname "$COMPANION")/session-lifecycle-hook.mjs"
if [ "$KEEP_RUNTIME" = 1 ]; then
  echo "codex-delegate: runtime kept (--keep-runtime); broker for $WORKDIR is still running"
elif [ ! -f "$HOOK" ]; then
  echo "codex-delegate: WARNING: $HOOK not found; broker for $WORKDIR may still be running" >&2
else
  TO=()
  command -v timeout >/dev/null 2>&1 && TO=(timeout 60)
  HOOK_OUT=$(printf '{"hook_event_name":"SessionEnd","cwd":"%s"}' "$WORKDIR" \
    | env -u CODEX_COMPANION_SESSION_ID -u CODEX_COMPANION_APP_SERVER_ENDPOINT \
          -u CODEX_COMPANION_APP_SERVER_PID_FILE -u CODEX_COMPANION_APP_SERVER_LOG_FILE \
          "${TO[@]}" node "$HOOK" SessionEnd 2>&1)
  HOOK_RC=$?
  HOOK_OUT=$(printf '%s\n' "$HOOK_OUT" | grep -v -e 'DEP0190' -e 'trace-deprecation' -e '^$')
  [ -n "$HOOK_OUT" ] && printf '%s\n' "$HOOK_OUT" | sed 's/^/codex-delegate: runtime: /'
  if [ "$HOOK_RC" -eq 0 ]; then
    echo "codex-delegate: runtime cleanup done for $WORKDIR"
  else
    echo "codex-delegate: WARNING: broker shutdown failed (exit $HOOK_RC); stop it by hand (SKILL.md, Monitoring)" >&2
  fi
fi
exit "$RC"

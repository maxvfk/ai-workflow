#!/usr/bin/env bash
# Run one Codex task through the openai-codex Claude Code plugin, safely on Windows/Git Bash.
#
# Usage:
#   run-codex-task.sh <workdir> <prompt-file> [--write] [--model <model>] [--effort <level>] [--resume-last]
#
# - <workdir>: directory Codex works in (usually the repo root). Backslashes are normalized.
# - <prompt-file>: file with the full task text. Never pass the task text on the command line.
# - Read-only unless --write is given explicitly.
#
# Run it from the MAIN Claude Code session with the Bash tool's run_in_background, so the
# harness notifies on completion. Exit code is Codex's exit code.

set -uo pipefail

if [ $# -lt 2 ]; then
  sed -n '2,13p' "$0" >&2
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
echo "codex-delegate: workdir=$WORKDIR prompt=$PROMPT extra=[$*]"

node "$COMPANION" task --cwd "$WORKDIR" --prompt-file "$PROMPT" "$@" 2>&1 \
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
exit "$RC"

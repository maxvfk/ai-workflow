#!/usr/bin/env bash
# Create the `deepseek` Codex CLI profile without touching ~/.codex/config.toml.
#
# Usage:
#   setup-deepseek-profile.sh [--force] [--script <local copy of codex-deepseek-setup-en.ps1>]
#
# Writes two files into $CODEX_HOME (default ~/.codex):
#   deepseek.config.toml  - profile layered on top of config.toml by `codex -p deepseek`
#   deepseek-models.json  - model catalog for deepseek-flash and deepseek-v4-pro
#
# The catalog is taken from DeepSeek's official Codex setup script, which is downloaded as TEXT
# and parsed; the script is never executed. DeepSeek's script itself is not used because it
# rewrites config.toml (DeepSeek becomes the default, ChatGPT delegation and the Codex app break)
# and stores the API key in plain text there. Here the key comes from DEEPSEEK_API_KEY.
#
# Needs Codex CLI >= 0.164 (profile files, DeepSeek catalog), node, curl.

set -euo pipefail

SCRIPT_URL=https://cdn.deepseek.com/api-docs/codex-deepseek-setup-en.ps1
FORCE=0
LOCAL_SCRIPT=
while [ $# -gt 0 ]; do
  case "$1" in
    --force) FORCE=1 ;;
    --script) LOCAL_SCRIPT=$2; shift ;;
    *) sed -n '2,16p' "$0" >&2; exit 2 ;;
  esac
  shift
done

CODEX_HOME_DIR=${CODEX_HOME:-$HOME/.codex}
PROFILE="$CODEX_HOME_DIR/deepseek.config.toml"
CATALOG="$CODEX_HOME_DIR/deepseek-models.json"
[ -d "$CODEX_HOME_DIR" ] || { echo "setup-deepseek: $CODEX_HOME_DIR not found; install and log in to Codex first" >&2; exit 2; }
if [ "$FORCE" = 0 ]; then
  for f in "$PROFILE" "$CATALOG"; do
    [ -e "$f" ] && { echo "setup-deepseek: $f exists; use --force to overwrite" >&2; exit 2; }
  done
fi

TMP=$(mktemp -d "${TMPDIR:-/tmp}/deepseek-setup.XXXXXX")
trap 'rm -rf "$TMP"' EXIT
if [ -n "$LOCAL_SCRIPT" ]; then
  cp "$LOCAL_SCRIPT" "$TMP/setup.ps1.txt"
else
  curl -fsSL "$SCRIPT_URL" -o "$TMP/setup.ps1.txt"
fi

CATALOG_WIN=$CATALOG
command -v cygpath >/dev/null 2>&1 && CATALOG_WIN=$(cygpath -m "$CATALOG")
SRC_WIN="$TMP/setup.ps1.txt"
command -v cygpath >/dev/null 2>&1 && SRC_WIN=$(cygpath -m "$SRC_WIN")

# Extract the PowerShell here-string `$ModelsJson = @' ... '@` and check it is the expected catalog.
node - "$SRC_WIN" "$TMP/models.json" <<'JS'
const fs = require("fs");
const [src, dst] = process.argv.slice(2);
const s = fs.readFileSync(src, "utf8").replace(/\r/g, "");
const open = "$ModelsJson = @'\n", close = "\n'@";
const a = s.indexOf(open);
if (a < 0) throw new Error("catalog not found in DeepSeek's script (format changed?)");
const b = s.indexOf(close, a + open.length);
const j = JSON.parse(s.slice(a + open.length, b));
const slugs = j.models.map(m => m.slug).sort().join(",");
if (slugs !== "deepseek-flash,deepseek-v4-pro") throw new Error("unexpected models: " + slugs);
const ver = (s.match(/\$SCRIPT_VERSION\s*=\s*'([^']+)'/) || [])[1] || "unknown";
fs.writeFileSync(dst, JSON.stringify(j, null, 2) + "\n");
for (const m of j.models)
  console.log(`setup-deepseek: ${m.slug} ctx=${m.context_window} effort=${m.supported_reasoning_levels.map(l => l.effort).join("/")} min_codex=${m.minimal_client_version}`);
console.log("setup-deepseek: source script version " + ver);
JS

cp "$TMP/models.json" "$CATALOG"
cat > "$PROFILE" <<EOF
# DeepSeek profile for Codex CLI. Use: codex exec -p deepseek ...
# Layered on top of config.toml; the base config (ChatGPT login, default model) is untouched.
# The API key is read from the DEEPSEEK_API_KEY environment variable, never stored here.
# Written by ai-workflow skills/codex-delegate/setup-deepseek-profile.sh; catalog from
# DeepSeek's official Codex setup script.
# Models: deepseek-flash (cheap, text+image) | deepseek-v4-pro (stronger, text only).
# Reasoning effort: low | high | max.

model = "deepseek-flash"
model_provider = "deepseek"
model_reasoning_effort = "high"
model_catalog_json = "$CATALOG_WIN"
suppress_unstable_features_warning = true

[model_providers.deepseek]
name = "DeepSeek"
base_url = "https://api.deepseek.com/"
wire_api = "responses"
env_key = "DEEPSEEK_API_KEY"
EOF

echo "setup-deepseek: wrote $PROFILE"
echo "setup-deepseek: wrote $CATALOG"
echo "setup-deepseek: next: set DEEPSEEK_API_KEY as a user environment variable (not on a command line),"
echo "setup-deepseek:       then test: bash run-codex-task.sh <workdir> <prompt-file> --provider deepseek --effort low"

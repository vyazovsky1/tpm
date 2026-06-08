#!/usr/bin/env bash
# Scaffolds a new AITPM program folder.
# Usage: bash init.sh <program-name> <target-path> [--yes] [stream ...]
#   --yes    skip confirmation when target path already exists
#   stream   one or more initial stream names (default: "general")
#
# A program folder has NO /program folder. All state lives under
# streams/<stream>/, copied from the framework's per-stream template.

set -euo pipefail

FRAMEWORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../" && pwd)"
STREAM_TEMPLATE_DIR="$FRAMEWORK_DIR/program/streams/_template"
ROOT_TEMPLATE_DIR="$FRAMEWORK_DIR/program/templates"

# render <template-file> <dest-file>
# Copies a template, substituting {{TOKEN}} placeholders. Uses '|' as the sed
# delimiter so values containing '/' (e.g. framework paths) need no escaping.
render() {
  sed -e "s|{{PROGRAM_NAME}}|$PROGRAM_NAME|g" \
      -e "s|{{FRAMEWORK_DIR}}|$FRAMEWORK_DIR|g" \
      -e "s|{{STREAMS}}|${STREAMS[*]}|g" \
      "$1" > "$2"
}

PROGRAM_NAME="${1:-}"
TARGET_PATH="${2:-}"

if [[ -z "$PROGRAM_NAME" || -z "$TARGET_PATH" ]]; then
  echo "Usage: bash init.sh <program-name> <target-path> [--yes] [stream ...]"
  exit 1
fi
shift 2

YES_FLAG=""
if [[ "${1:-}" == "--yes" ]]; then
  YES_FLAG="--yes"
  shift
fi

# Remaining args are stream names; default to a single "general" stream.
STREAMS=("$@")
if [[ ${#STREAMS[@]} -eq 0 ]]; then
  STREAMS=("general")
fi

TARGET_PATH="${TARGET_PATH/#\~/$HOME}"

if [[ -d "$TARGET_PATH" && "$YES_FLAG" != "--yes" ]]; then
  echo "WARNING: $TARGET_PATH ALREADY EXISTS."
  exit 2
fi

echo ""
echo "=== AITPM — New Program: $PROGRAM_NAME ==="
echo "Framework : $FRAMEWORK_DIR"
echo "Target    : $TARGET_PATH"
echo "Streams   : ${STREAMS[*]}"
echo ""

echo "Creating directory structure..."
mkdir -p "$TARGET_PATH"/{streams,.data}

echo "Creating streams from template..."
for stream in "${STREAMS[@]}"; do
  dest="$TARGET_PATH/streams/$stream"
  if [[ -d "$dest" ]]; then
    echo "  - $stream (exists, skipped)"
    continue
  fi
  cp -r "$STREAM_TEMPLATE_DIR" "$dest"
  # Substitute the {{STREAM}} placeholder with the actual stream name.
  find "$dest" -name '*.md' -exec sed -i "s|{{STREAM}}|$stream|g" {} +
  echo "  - $stream"
done

echo "Creating integration cache..."
render "$ROOT_TEMPLATE_DIR/data-README.md" "$TARGET_PATH/.data/README.md"

echo "Generating integrations.md..."
render "$ROOT_TEMPLATE_DIR/integrations.md" "$TARGET_PATH/integrations.md"

echo "Generating CLAUDE.md..."
render "$ROOT_TEMPLATE_DIR/CLAUDE.md" "$TARGET_PATH/CLAUDE.md"

cp "$ROOT_TEMPLATE_DIR/gitignore" "$TARGET_PATH/.gitignore"

echo ""
echo "✓ Program folder created at: $TARGET_PATH"
echo ""
echo "Next steps:"
echo "  1. cd $TARGET_PATH"
echo "  2. Open with TPM plugin: claude --plugin-dir $FRAMEWORK_DIR ."
echo "  3. Run /tpm:kickoff to start the program"
echo "  4. Configure sources in ./integrations.md (fetched data caches to ./.data/<source>/)"
echo ""

printf '{"status": "created", "program": "%s", "path": "%s", "streams": "%s"}\n' \
  "$PROGRAM_NAME" "$TARGET_PATH" "${STREAMS[*]}"

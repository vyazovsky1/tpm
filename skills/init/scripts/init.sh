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
TEMPLATE_DIR="$FRAMEWORK_DIR/program/streams/_template"

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
mkdir -p "$TARGET_PATH"/{streams,data/{emails,docs,meetings,chat}}

echo "Creating streams from template..."
for stream in "${STREAMS[@]}"; do
  dest="$TARGET_PATH/streams/$stream"
  if [[ -d "$dest" ]]; then
    echo "  - $stream (exists, skipped)"
    continue
  fi
  cp -r "$TEMPLATE_DIR" "$dest"
  # Substitute the <stream-name> placeholder with the actual stream name.
  find "$dest" -name '*.md' -exec sed -i "s/<stream-name>/$stream/g" {} +
  echo "  - $stream"
done

echo "Creating data source directories..."
cat > "$TARGET_PATH/data/README.md" <<EOF
# Local Data Sources

Drop local files here as substitutes for live integrations.

| Directory  | Replaces         | Format                              |
|-----------|------------------|-------------------------------------|
| emails/   | Gmail            | .eml or .txt files                  |
| docs/     | Google Drive     | .md, .txt, .pdf files               |
| meetings/ | Google Calendar  | Meeting notes as .md files          |
| chat/     | Google Chat      | Exported chat logs as .txt or .md   |

Agents will read from these directories when live integrations are not configured.
EOF

echo "Generating CLAUDE.md..."
cat > "$TARGET_PATH/CLAUDE.md" <<EOF
# Program: $PROGRAM_NAME

## Framework
AITPM framework location: $FRAMEWORK_DIR

All agent definitions, process descriptions, and integration specs are in the framework directory above.
This folder contains program-specific state and data only.

## Program State
There is no \`/program\` folder. All live state lives under \`streams/<stream>/\`, one folder per
stream (track / workstream). The set of subfolders under \`streams/\` is the stream registry.
Each stream folder contains: \`context.md\`, \`team.md\`, \`action-items.md\`, \`raid.md\`,
\`decisions.md\`, \`knowledge.md\`, \`meetings.md\`, \`communications.md\`, and \`history/\`.
All files are maintained by agents and require TPM approval before changes are committed.

Current streams: ${STREAMS[*]}

To add a stream later, copy the framework template:
  cp -r $FRAMEWORK_DIR/program/streams/_template streams/<new-stream>

## Data Sources
Local data files are in \`/data\`. Drop exported emails, documents, meeting notes, and chat logs there.
Agents will read from \`/data\` when live integrations are not configured.

## Agent Instructions
When running any agent, always:
1. Read the agent definition from \`$FRAMEWORK_DIR/agents/<agent-name>.md\`
2. Read the relevant process from \`$FRAMEWORK_DIR/processes/<process-name>.md\`
3. Identify the active stream and read its state from \`./streams/<stream>/\`,
   starting with \`context.md\` and \`team.md\`
4. Read data from \`./data/\` as the local data source

## Conventions
- Role names are always capitalized: Engineering, Product, Stakeholders, QA, SRE
- All agent outputs require TPM approval before being written to \`streams/<stream>/\`
- Never commit \`.env\` — credentials stay local

## Launching with TPM Skills
Open this folder with the TPM plugin to get \`/tpm:\` commands:

  claude --plugin-dir $FRAMEWORK_DIR .
EOF

cat > "$TARGET_PATH/.gitignore" <<EOF
.env
.envrc
data/
EOF

echo ""
echo "✓ Program folder created at: $TARGET_PATH"
echo ""
echo "Next steps:"
echo "  1. cd $TARGET_PATH"
echo "  2. Open with TPM plugin: claude --plugin-dir $FRAMEWORK_DIR ."
echo "  3. Run /tpm:kickoff to start the program"
echo "  4. Add inputs to ./data/ (emails, docs, meeting notes)"
echo ""

printf '{"status": "created", "program": "%s", "path": "%s", "streams": "%s"}\n' \
  "$PROGRAM_NAME" "$TARGET_PATH" "${STREAMS[*]}"

#!/usr/bin/env bash
# Scaffolds a new AITPM program folder.
# Usage: bash init.sh <program-name> <target-path> [--yes]
#   --yes  skip confirmation when target path already exists

set -euo pipefail

FRAMEWORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../" && pwd)"

PROGRAM_NAME="${1:-}"
TARGET_PATH="${2:-}"
YES_FLAG="${3:-}"

if [[ -z "$PROGRAM_NAME" || -z "$TARGET_PATH" ]]; then
  echo "Usage: bash init.sh <program-name> <target-path> [--yes]"
  exit 1
fi

TARGET_PATH="${TARGET_PATH/#\~/$HOME}"

if [[ -d "$TARGET_PATH" ]]; then
  if [[ "$YES_FLAG" != "--yes" ]]; then
    echo "WARNING: $TARGET_PATH ALREADY EXISTS."
    exit 2
  fi
fi

echo ""
echo "=== AITPM — New Program: $PROGRAM_NAME ==="
echo "Framework : $FRAMEWORK_DIR"
echo "Target    : $TARGET_PATH"
echo ""

echo "Creating directory structure..."
mkdir -p "$TARGET_PATH"/{program/history/{risks,decisions,dependencies,communications},data/{emails,docs,meetings,chat}}

echo "Copying program state templates..."
cp "$FRAMEWORK_DIR/program/model.md"          "$TARGET_PATH/program/model.md"
cp "$FRAMEWORK_DIR/program/risks.md"          "$TARGET_PATH/program/risks.md"
cp "$FRAMEWORK_DIR/program/dependencies.md"   "$TARGET_PATH/program/dependencies.md"
cp "$FRAMEWORK_DIR/program/stakeholders.md"   "$TARGET_PATH/program/stakeholders.md"
cp "$FRAMEWORK_DIR/program/decisions.md"      "$TARGET_PATH/program/decisions.md"
cp "$FRAMEWORK_DIR/program/communications.md" "$TARGET_PATH/program/communications.md"
cp "$FRAMEWORK_DIR/program/knowledge.md"      "$TARGET_PATH/program/knowledge.md"

touch "$TARGET_PATH/program/history/risks/.gitkeep"
touch "$TARGET_PATH/program/history/decisions/.gitkeep"
touch "$TARGET_PATH/program/history/dependencies/.gitkeep"
touch "$TARGET_PATH/program/history/communications/.gitkeep"

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
Live program state is in \`/program\`. All files are maintained by agents and require TPM approval before changes are committed.

## Data Sources
Local data files are in \`/data\`. Drop exported emails, documents, meeting notes, and chat logs there.
Agents will read from \`/data\` when live integrations are not configured.

## Agent Instructions
When running any agent, always:
1. Read the agent definition from \`$FRAMEWORK_DIR/agents/<agent-name>.md\`
2. Read the relevant process from \`$FRAMEWORK_DIR/processes/<process-name>.md\`
3. Read current program state from \`./program/\`
4. Read data from \`./data/\` as the local data source

## Conventions
- Role names are always capitalized: Engineering, Product, Stakeholders, QA, SRE
- All agent outputs require TPM approval before being written to \`/program\`
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

echo "{\"status\": \"created\", \"program\": \"$PROGRAM_NAME\", \"path\": \"$TARGET_PATH\"}"

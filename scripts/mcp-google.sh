#!/usr/bin/env bash
# Wrapper for Google MCP servers.
# Loads credentials from .env then exec's the MCP server command.
# Usage: mcp-google.sh <mcp-command> [args...]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "Error: .env not found at $ENV_FILE" >&2
  echo "Run: node scripts/google-auth.js" >&2
  exit 1
fi

# Export all vars from .env (skip comments and blank lines)
set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

exec "$@"

#!/usr/bin/env bash
# Scaffolds a new AITPM program folder.
# Usage: bash scripts/new-program.sh <program-name> <target-path>
#
# Example:
#   bash scripts/new-program.sh "payments-platform" ~/programs/payments-platform

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec bash "$SCRIPT_DIR/../skills/init/scripts/init.sh" "$@"

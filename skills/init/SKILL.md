---
name: init
description: Scaffolds a new AITPM program folder. Use when starting a new program that needs the AITPM structure set up. Accepts program name and target path as arguments.
---

# TPM: Init

## Overview

Scaffolds a new program folder from the AITPM framework. Creates the standard directory structure, creates one folder per stream from the per-stream template, generates a `CLAUDE.md` with the framework path baked in, writes a starter `integrations.md` registry, and creates the `.data/` integration cache. The result is a ready-to-use program folder that references this plugin for all agent definitions.

## When to Use

- Starting a new program that needs AITPM structure
- Onboarding an existing folder (e.g. one that already has documents) into the framework

**When NOT to use:** A program folder already fully initialized — running init again on a complete folder adds nothing new.

## Steps

### 1. Collect inputs

If `$ARGUMENTS` is provided, parse it as `<program-name> <target-path> [stream ...]` (space-separated).

If `$ARGUMENTS` is not provided, ask the user for:
1. **Program name** — used as the folder label and in the generated CLAUDE.md
2. **Target path** — absolute path where the program folder should be created
3. **Initial streams** — one or more stream (track / workstream) names. The set of streams is the program's stream registry; more can be added later. Defaults to a single `general` stream if none are given.

### 2. Check if the folder already exists

Run:
```bash
bash ${CLAUDE_PLUGIN_ROOT}/skills/init/scripts/init.sh "<program-name>" "<target-path>" <stream> [stream ...]
```

If the script exits with code 2 and prints `EXISTS`, the folder already exists. Tell the user:
- The folder already exists at `<target-path>`
- Existing files will not be overwritten
- The AITPM structure (program state, `integrations.md`, `.data/` cache, CLAUDE.md) will be added alongside them

Ask the user to confirm before proceeding.

### 3. Run the scaffold

If the folder does not exist (script exited 0), scaffolding is already complete — skip to step 4.

If the user confirmed on an existing folder, re-run with `--yes`:
```bash
bash ${CLAUDE_PLUGIN_ROOT}/skills/init/scripts/init.sh "<program-name>" "<target-path>" --yes <stream> [stream ...]
```

### 4. Report completion

Tell the user:
- Program folder is ready at `<target-path>`
- Then run `/tpm:kickoff` to start the program

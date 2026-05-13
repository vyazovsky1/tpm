---
name: init
description: Scaffolds a new AITPM program folder. Use when starting a new program that needs the AITPM structure set up. Accepts program name and target path as arguments.
---

# TPM: Init

Scaffold a new program folder from the AITPM framework.

## Steps

### 1. Collect inputs

If `$ARGUMENTS` is provided, parse it as `<program-name> <target-path>` (space-separated).

If `$ARGUMENTS` is not provided, ask the user for:
1. **Program name** — used as the folder label and in the generated CLAUDE.md
2. **Target path** — absolute path where the program folder should be created

### 2. Check if the folder already exists

Run:
```bash
bash ${CLAUDE_PLUGIN_ROOT}/skills/init/scripts/init.sh "<program-name>" "<target-path>"
```

If the script exits with code 2 and prints `EXISTS`, the folder already exists. Tell the user:
- The folder already exists at `<target-path>`
- Existing files will not be overwritten
- The AITPM structure (program state, data directories, CLAUDE.md) will be added alongside them

Ask the user to confirm before proceeding.

### 3. Run the scaffold

If the folder does not exist (script exited 0), scaffolding is already complete — skip to step 4.

If the user confirmed on an existing folder, re-run with `--yes`:
```bash
bash ${CLAUDE_PLUGIN_ROOT}/skills/init/scripts/init.sh "<program-name>" "<target-path>" --yes
```

### 4. Report completion

Tell the user:
- Program folder is ready at `<target-path>`
- Then run `/tpm:kickoff` to start the program

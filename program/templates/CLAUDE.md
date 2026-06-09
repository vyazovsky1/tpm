# Program: {{PROGRAM_NAME}}

## Framework
AITPM framework location: {{FRAMEWORK_DIR}}

All agent definitions, process descriptions, and integration specs are in the framework directory above.
This folder contains program-specific state and data only.

## Program State
There is no `/program` folder. All live state lives under `streams/<stream>/`, one folder per
stream (track / workstream). The set of subfolders under `streams/` is the stream registry.
Each stream folder contains: `context.md`, `team.md`, `action-items.md`, `raid.md`,
`decisions.md`, `knowledge.md`, `meetings/` (one summary file per meeting), `communications.md`, and `history/`.
All files are maintained by agents and require TPM approval before changes are committed.

Current streams: {{STREAMS}}

To add a stream later, copy the framework template:
  cp -r {{FRAMEWORK_DIR}}/program/streams/_template streams/<new-stream>

## Integrations & Data
Active integrations are declared in `integrations.md` — each row binds a source (Drive, Gmail,
Confluence, ...) to its scope and the stream it feeds. Fetched data is cached under
`.data/<source>/` (gitignored, regenerable), one subfolder per source. Agents read
`integrations.md` to learn what is connected, read the cache under `.data/<source>/`, and
fetch live when the cache is missing.

## Agent Instructions
When running any agent, always:
1. Read the agent definition from `{{FRAMEWORK_DIR}}/agents/<agent-name>.md`
2. Read the relevant process from `{{FRAMEWORK_DIR}}/processes/<process-name>.md`
3. Identify the active stream and read its state from `./streams/<stream>/`,
   starting with `context.md` and `team.md`
4. Consult `./integrations.md` for active sources, then read cached data under `./.data/<source>/`

## Conventions
- Role names are always capitalized: Engineering, Product, Stakeholders, QA, SRE
- All agent outputs require TPM approval before being written to `streams/<stream>/`
- Never commit `.env` — credentials stay local

## Launching with TPM Skills
Open this folder with the TPM plugin to get `/tpm:` commands:

  claude --plugin-dir {{FRAMEWORK_DIR}} .

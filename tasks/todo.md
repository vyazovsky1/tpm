# MVP Todo

## Task 1 — Knowledge Management ✓
- [x] `processes/knowledge-management.md` — fill all sections including Agent Rules
- [x] `agents/knowledge-agent.md` — add Agent Rules, verify behaviors
- [x] `integrations/confluence.md` — add Standard Queries for knowledge retrieval
- [x] `integrations/google-drive.md` — add Standard Queries for document indexing

## Task 2 — Planning (SDLC stage) ✓
- [x] `framework/planning.md` — complete
- [x] Review AI Capabilities against agent definitions — ensure consistency

## Task 3 — Requirements (SDLC stage) ✓
- [x] `framework/requirements.md` — fill all sections including AI Capabilities with agent column

## Checkpoint
- [ ] Knowledge Agent is self-contained and executable by any AI
- [ ] Process file clearly separates TPM vs. agent responsibilities

## Task 4 — Program Brain MVP ✓
- [x] `agents/program-brain.md` — scoped to MVP agents, 4-step orchestration workflow, health check format, delegation rules
- [x] `agents/requirements-agent.md` — created ✓
- [x] `agents/communications-agent.md` — updated with Stakeholder responsibilities ✓
- [x] `agents/stakeholder-agent.md` — marked out of MVP scope ✓
- [x] `docs/ideas/program-brain.md` — MVP scope updated ✓

## Task 5 — CLAUDE.md ✓
- [x] `CLAUDE.md` — conventions, onboarding, agent and integration authoring guidelines, MVP scope, setup instructions

## Task 6 — TPM Plugin: init skill ✓
- [x] `.claude-plugin/plugin.json` — manifest with name `tpm`
- [x] `skills/init/SKILL.md` — `/tpm:init` skill
- [x] Update `scripts/new-program.sh` — removed `.claude/commands/` generation, added `--plugin-dir` to generated CLAUDE.md

## Task 7 — TPM Plugin: remaining skills (out of MVP scope)
- [ ] `skills/kickoff/SKILL.md` — `/tpm:kickoff`
- [ ] `skills/health/SKILL.md` — `/tpm:health`
- [x] `skills/backlog/SKILL.md` — `/tpm:backlog`
- [ ] `skills/estimate/SKILL.md` — `/tpm:estimate`
- [ ] `skills/knowledge/SKILL.md` — `/tpm:knowledge`

## Task 8 — Stream-scoped program structure (refactor) ✓
Drop the `/program` folder from generated program folders; everything lives under `streams/<stream>/`. See `docs/ideas/stream-model.md`.
- [x] Restructure framework `program/` templates into a per-stream template set (`program/streams/_template/`): `context.md`, `team.md`, `action-items.md`, `raid.md`, `decisions.md`, `knowledge.md`, `meetings/`, `communications.md`, `history/`
- [x] Update all agent files to reference `streams/<stream>/...` instead of `/program/...`
- [x] Update `scripts/new-program.sh` / `init.sh` to scaffold `streams/` (one stream per init arg, `<stream-name>` substitution) + streams init question in `skills/init/SKILL.md`
- [x] Update `CLAUDE.md` to document the streams-only structure
- [~] **Open question:** `context.md` shipped as a light fixed template (Overview / Scope / Milestones / Standing Instructions / Key Contacts). Confirm this is the desired shape or revise.

## Task 8b — Integration registry + cache redesign ✓
Replaced the flat `data/{emails,docs,meetings,chat}` input dropbox with a registry + cache model.
- [x] `integrations.md` at program root — markdown registry binding each source (named for its framework spec / MCP server) to scope + stream; committed, no secrets; hand- or script-editable
- [x] `/.data/<source>/` — integration cache, one subfolder per source; gitignored, regenerable
- [x] `init.sh` — create `.data/`, emit starter `integrations.md`, `.gitignore` → `.data/`, updated generated CLAUDE.md + completion hints
- [x] Framework `CLAUDE.md` — document registry + cache; source-name consistency rule in "Adding a New Integration"
- [x] `skills/backlog/SKILL.md`, `skills/init/SKILL.md`, `docs/ideas/stream-model.md` — replace `./data/...` reads with `integrations.md` + `.data/<source>/`

## Task 8c — Extract scaffold content into templates ✓
No hardcoded template content in scripts. All scaffold content lives as real files; `init.sh` only copies + substitutes.
- [x] `program/templates/` — program-root scaffold files: `CLAUDE.md`, `integrations.md`, `gitignore`, `data-README.md`
- [x] `{{TOKEN}}` mustache placeholders (`{{PROGRAM_NAME}}`, `{{FRAMEWORK_DIR}}`, `{{STREAMS}}`); harmonized stream template `<stream-name>` → `{{STREAM}}`
- [x] `init.sh` — `render()` helper (sed, `|` delimiter); replaced all four heredocs with `render`/`cp` from `program/templates/`
- [x] Framework `CLAUDE.md` — "Scaffold Templates" section + Directory Structure updated; verified byte-identical scaffolder output

## Task 9 — Meetings Agent ✓
Stream-scoped agent: ingest notes → summary + action items → follow-up agenda. Built on Task 8.
- [x] `agents/meetings-agent.md`
- [x] `integrations/meeting-notes.md` — platform-agnostic notes abstraction (drive/confluence/pasted); tool captured at init, stored in program `CLAUDE.md`, optional per-stream override in `context.md`
- [x] `/tpm:meeting-summary <stream>` and `/tpm:meeting-prep <stream>` as skills (`skills/meeting-summary/`, `skills/meeting-prep/`) — the framework's command mechanism is plugin skills, not `scripts/new-program.sh`
- [x] `skills/meeting-summary/summary-template.md` — common summary template (one format for all streams); summaries are one file per meeting under `streams/<stream>/meetings/`, **Notes source** = resource URL from integration metadata
- [x] `skills/meeting-prep/agenda-template.md` — common agenda template: per-teammate (open items + updates since last call, "as available" from connected sources) → issues/blockers/dependencies → new for discussion. Code/Jira contributions populate once phase-2 integrations land
- [x] `agents/program-brain.md` — delegation row for Meetings Agent
- [x] `agents/communications-agent.md` — action items shared store with Meetings Agent (no fork)
- [x] `processes/communication-management.md` — filled to convention + Meeting Management section
- [x] `.claude-plugin/plugin.json` — register `meetings-agent`
- [x] `program/templates/integrations.md` — `meeting-notes` registry row; `CLAUDE.md` MVP scope updated
- [ ] Phase 2 (later): team-pulse digest + `integrations/gitlab.md`

## Backlog (later)
- [ ] Clean "add a stream later" mechanism: `scripts/add-stream.sh` + `/tpm:add-stream <name>` (copy template, substitute `<stream-name>`, refuse if exists). Today you must copy `_template` manually or re-run init (which clobbers CLAUDE.md).

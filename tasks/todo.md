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

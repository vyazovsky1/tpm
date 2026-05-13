# MVP Plan — Program Brain

## Spec Reference
`docs/ideas/program-brain.md` — MVP Scope section

## MVP Scope
- **Framework:** Planning (complete)
- **Processes:** Dependency Management, Knowledge Management, Reporting
- **Agents:** Dependency Agent, Knowledge Agent, Reporting Agent, Program Brain (MVP-scoped)
- **Integrations:** Jira, GitHub, Confluence, Google Drive, SonarQube

---

## Dependency Graph

```
integrations/          ← no dependencies, foundational
    jira.md
    github.md
    confluence.md
    google-drive.md
    sonarqube.md

processes/             ← no dependencies, defines the discipline
    dependency-management.md
    knowledge-management.md
    reporting.md

agents/                ← depends on processes + integrations
    dependency-agent.md
    knowledge-agent.md
    reporting-agent.md

agents/program-brain   ← depends on all agents above
```

Each agent is a vertical slice: process → integration queries → agent rules form one complete, testable unit of capability.

---

## Tasks

### Task 1 — Knowledge Management vertical slice
**Files:** `processes/knowledge-management.md` + `agents/knowledge-agent.md` + Standard Queries in `integrations/confluence.md`, `integrations/google-drive.md`

**What to write:**
- `knowledge-management.md`: Goals, Inputs & Triggers, TPM Responsibilities, Outputs, Agent Rules, AI Capabilities
- `knowledge-agent.md`: Add Agent Rules; verify behaviors
- Integration Standard Queries for Confluence and Google Drive knowledge retrieval

**Acceptance criteria:**
- [ ] Process file distinguishes what goes in Confluence vs. `/program/knowledge.md`
- [ ] Agent Rules cover: capturing decisions, indexing artifacts, surfacing gaps, archiving to history
- [ ] An AI reading only these files can produce a weekly knowledge digest end-to-end

---

### Task 2 — Planning SDLC stage review
**File:** `framework/planning.md` (complete — review only)

**What to verify:**
- AI Capabilities table is consistent with agent definitions
- Outputs align with `/program` state files

**Acceptance criteria:**
- [ ] All AI Capabilities reference agents that exist in `/agents`
- [ ] All Outputs map to a file in `/program`

---

### Task 3 — Reporting vertical slice
**Files:** `processes/reporting.md` + `agents/reporting-agent.md` + Standard Queries in `integrations/jira.md`, `integrations/github.md`, `integrations/sonarqube.md`, `integrations/google-drive.md`

**What to write:**
- `reporting.md`: Goals, Inputs & Triggers, TPM Responsibilities, Outputs, Agent Rules, AI Capabilities
- `reporting-agent.md`: Add Agent Rules; verify behaviors and report templates
- Standard Queries for all four integrations focused on reporting metrics

**Acceptance criteria:**
- [ ] Process file defines report types, cadence, and distribution
- [ ] Agent Rules specify exactly how to aggregate data, calculate RAG status, and format reports
- [ ] Standard Queries are complete enough to pull velocity, CI/CD health, and quality metrics
- [ ] An AI reading only these files can generate a weekly status report end-to-end

---

### Task 4 — Dependency Management vertical slice
**Files:** `processes/dependency-management.md` + `agents/dependency-agent.md` + Standard Queries in `integrations/jira.md`, `integrations/github.md`, `integrations/confluence.md`

**What to write:**
- `dependency-management.md`: Goals, Inputs & Triggers, TPM Responsibilities, Outputs, Agent Rules, AI Capabilities
- `dependency-agent.md`: Add Agent Rules section referencing the process; verify behaviors are complete
- Integration Standard Queries: queries agents use to fetch dependency-relevant data from Jira, GitHub, Confluence

**Acceptance criteria:**
- [ ] Process file defines what the TPM owns vs. what the agent owns
- [ ] Agent Rules specify triggers, data fetch steps, output format, and what requires TPM approval
- [ ] Standard Queries in integrations are concrete enough for any AI to execute
- [ ] An AI reading only these three files can perform a dependency health check end-to-end

---

### Checkpoint — Vertical slice review
Before proceeding to Task 5, verify:
- [ ] All three agents are self-contained — an AI with only the agent file + integration files can perform the task
- [ ] Process files clearly separate TPM responsibilities from agent responsibilities
- [ ] No circular references or missing integration coverage

---

### Task 5 — Program Brain MVP wiring
**File:** `agents/program-brain.md`

**What to write:**
- Scope data sources to MVP integrations only
- Define orchestration rules: how the Brain delegates to the three MVP agents
- Define daily health check behavior for MVP scope
- Add Agent Rules for surfacing top items to TPM

**Acceptance criteria:**
- [ ] Brain references only MVP agents and integrations
- [ ] Orchestration rules are explicit — Brain knows when to delegate vs. synthesize directly
- [ ] Daily health check produces a concrete output format
- [ ] TPM approval flow is clearly defined for each type of Brain output

---

### Task 6 — CLAUDE.md
**File:** `CLAUDE.md` (new)

**What to write:**
- Framework conventions (role capitalization, template structure)
- How to fork and initialize a new program
- Agent authoring guidelines (what makes a complete agent file)
- Integration authoring guidelines

**Acceptance criteria:**
- [ ] A new TPM forking this repo can onboard without asking questions
- [ ] Conventions match what's already in the existing files

---

## Definition of MVP Done
- All three vertical slices pass their acceptance criteria
- Program Brain can orchestrate all three agents with clear rules
- Any AI (Claude, Gemini, Codex) can read an agent file and execute its task without additional context
- CLAUDE.md gives a new TPM everything they need to fork and start

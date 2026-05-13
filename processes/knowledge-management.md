# Knowledge Management

## Goals
- Ensure program knowledge is captured and structured according to the standard program taxonomy.
- Detect documents referenced in communications but missing from the knowledge repository and drive their creation.
- Assign clear ownership for knowledge creation and maintenance per taxonomy section.
- Preserve program context across team changes and SDLC stage transitions.

## Knowledge Taxonomy

```
Program
├── 1. Program Overview          (Owner: TPM)
│   ├── Charter
│   ├── Objectives & Success Metrics
│   ├── Stakeholder Map & RACI
│   └── Glossary
├── 2. Planning                  (Owner: TPM)
│   ├── Roadmap
│   ├── Milestone Plan
│   ├── Dependency Map
│   └── Capacity Plan
├── 3. Requirements              (Owner: Product)
│   ├── PRD / Product Vision
│   ├── Functional Requirements
│   ├── Non-Functional Requirements
│   └── Acceptance Criteria
├── 4. Architecture & Design     (Owner: Engineering / Architecture Lead)
│   ├── Architecture Overview
│   ├── Architecture Decision Records (ADRs)
│   ├── Technical Design Documents
│   └── Security & Compliance Design
├── 5. Delivery                  (Owner: QA Lead)
│   ├── Release Plans
│   ├── Test Plans & Results
│   └── Deployment Runbooks
├── 6. Risk & Decisions          (Owner: TPM)
│   ├── Risk Register
│   ├── Issue Log
│   └── Decision Log
├── 7. Reporting                 (Owner: TPM)
│   ├── Status Reports
│   └── Steering Committee Decks
├── 8. Operations                (Owner: SRE / Ops)
│   ├── Runbooks
│   ├── Incident Reports & Postmortems
│   └── SLA / SLO Definitions
└── Per Project                  (Owner: respective Engineering Lead)
    ├── Project Overview
    ├── Technical Documentation
    ├── ADRs
    └── Test Results
```

Each project in the program has its own repository and a corresponding Per Project section in the taxonomy. A shared common part shared across projects is documented under Architecture & Design.

## Inputs & Triggers
- New communication (email, chat, meeting notes) referencing a document
- New project repository added to the program
- SDLC stage transition
- TPM request for knowledge health check
- Scheduled: taxonomy compliance check (cadence defined per program)

## TPM Responsibilities
- Own and maintain program-level taxonomy sections: Program Overview, Planning, Risk & Decisions, Reporting.
- Define and communicate the taxonomy and ownership map to the program team at kickoff.
- Review knowledge health reports and assign gap action items to the responsible team manager.
- Escalate unresolved gaps that are blocking program execution.

## Team Manager Responsibilities
- Own their domain sections in the taxonomy (see Owner column above).
- Ensure documents are created, reviewed, and published within their domain.
- Respond to knowledge gap action items within the agreed SLA.
- Ensure Per Project sections exist and are maintained for each project repo they own.

## Outputs
- Knowledge health report — taxonomy compliance status with gap owners
- Gap action items assigned to responsible team managers
- Confluence taxonomy structure initialized for new programs and new projects

## Agent Rules
See `agents/knowledge-agent.md` for the full agent definition.

1. **Program init** — when a program is started, create the standard taxonomy folder structure in the Confluence program space. Create a Per Project section for each known project repository.
2. **New project onboarding** — when a new project repo is added to the program, create a corresponding Per Project section in Confluence and notify the responsible Engineering Lead.
3. **Communication scanning** — scan Gmail and Google Chat for document references: phrases like "the spec", "the runbook", "the design doc", "the ADR for X", "the test plan", "per the charter". For each reference, check whether a matching document exists in the taxonomy. If missing, create an action item assigned to the responsible team manager (based on taxonomy ownership) and track until resolved.
4. **Taxonomy compliance check** — on schedule, scan the Confluence program space against the taxonomy template. For each expected section, check whether at least one published document exists. Report compliance status and gaps to TPM with responsible owner per section.
5. **Gap tracking** — maintain a list of open knowledge gaps with owner, due date, and status. Flag overdue gaps to TPM for escalation.
6. **Never create documents** on behalf of a team — the agent creates action items and tracks resolution; the responsible team publishes the content.
7. **TPM approval required** only for program-level sections (1, 2, 6, 7) and escalations to Stakeholders.

## AI Capabilities

| Area | Agent | AI Role | How AI Helps |
|------|-------|---------|--------------|
| Taxonomy initialization | Knowledge Agent | Automate | Creates standard Confluence structure for new programs and projects |
| Taxonomy compliance | Knowledge Agent | Automate | Scans Confluence against taxonomy template and reports compliance status |
| Gap detection | Knowledge Agent | Augment | Identifies missing documents per taxonomy section with responsible owner |
| Gap escalation | Knowledge Agent | Assist | Flags overdue gaps to TPM with context and recommended escalation path |
| Communication scanning | Knowledge Agent | Automate | Detects document references in emails and chats; checks existence in taxonomy |
| Gap action items in Jira | Knowledge Agent | Automate | Creates and assigns Jira action items to team managers for missing documents — out of MVP scope |

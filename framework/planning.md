# Planning / Initiation

## Goals
- Ensure the project is feasible, scoped, and prioritized against business and technical constraints.
- Align Stakeholders on outcomes, timelines, and success metrics.
- Identify major risks, dependencies, and constraints early.
- Establish high-level expectations for quality, security, compliance, and licensing.

## Inputs
- Business case or Project proposal
- Product vision or opportunity brief
- Org roadmap and priorities
- Budget and resource availability
- Known constraints (timeline, budget, assumptions, compliance, platform)

## TPM Tasks
- Partner with Product and Engineering to define scope, epics, and MVP boundaries.
- Facilitate high-level sizing of epics (t-shirt / order-of-magnitude) with Engineering to validate feasibility against timeline and budget constraints.
- Build capacity plan: map team availability, headcount, and velocity assumptions to the milestone timeline.
- Identify and align key Stakeholders; establish RACI.
- Map high-level dependencies and key delivery milestones (quarters / PIs / sprints).
- Run risk and dependency workshops; capture owners and mitigation strategies.
- Drive agreement on initial NFR bar (performance, availability, security, data/privacy, license compliance) and where it will be enforced in the SDLC.

## Outputs

| Output | Stored In |
|--------|-----------|
| Project charter | Confluence: 1. Program Overview / Charter |
| Project kickoff slide deck | Google Drive + Confluence: 1. Program Overview |
| Scope definition (Epics, MVP boundaries, out-of-scope) | `/program/model.md` |
| High-level sizing (t-shirt / order-of-magnitude per epic) | `/program/model.md` + Confluence: 2. Planning |
| Capacity plan (team availability vs. milestone timeline) | `/program/model.md` + Confluence: 2. Planning |
| High-level roadmap and milestone plan | `/program/model.md` + Confluence: 2. Planning |
| Stakeholder map and RACI | `/program/stakeholders.md` + Confluence: 1. Program Overview |
| Initial risk register with owners and mitigation strategies | `/program/risks.md` |
| Dependency map | `/program/dependencies.md` + Confluence: 2. Planning |
| NFR baseline | Confluence: 3. Requirements / Non-Functional Requirements |

## Quality Gates
- Executive Sponsor confirmed and engaged.
- Stakeholders aligned on scope, success metrics, and MVP boundaries.
- Initial risk register reviewed with owners assigned.
- High-level milestone plan accepted by Stakeholders.
- NFR baseline defined and agreed.
- Go / no-go decision documented.

## Risks & Watch Items
- Scope not clearly bounded — creep begins immediately without explicit boundaries.
- Key Stakeholders not engaged early — late misalignment causes expensive rework.
- Cross-team dependencies not surfaced — surprise blockers emerge mid-execution.
- Timeline set under pressure without feasibility validation.
- NFRs deferred to later stages — retrofitting security, performance, or compliance is costly.
- Resource availability assumed but not confirmed.

## AI Capabilities

| Area | Agent | AI Role | How AI Helps |
|------|-------|---------|--------------|
| Confluence taxonomy init | Knowledge Agent | Automate | Creates standard taxonomy folder structure in Confluence at program kickoff |
| Project charter | Program Brain | Automate | Generates charter draft from project proposal and standard templates |
| Stakeholder map | Stakeholder Agent | Assist | Suggests missing Stakeholders based on scope, domain, and org structure — out of MVP scope |
| Stakeholder alignment | Stakeholder Agent | Augment | Surfaces misalignments across Stakeholder inputs and highlights open decisions — out of MVP scope |
| Risk register | Risk Agent | Automate | Pre-populates risks from project type, domain, and historical patterns — out of MVP scope |
| Risk scoring | Risk Agent | Augment | Scores risks by likelihood and impact; flags top items for TPM review — out of MVP scope |
| Dependency map | Dependency Agent | Assist | Drafts dependency map from known team and system landscape — out of MVP scope |
| High-level sizing | Program Brain | Assist | Suggests t-shirt size per epic based on scope description and historical data |
| Capacity plan | Program Brain | Automate | Generates capacity plan from team headcount, availability, and velocity assumptions |
| Timeline feasibility | Program Brain | Augment | Flags unrealistic milestones based on sizing results and capacity plan |
| NFR baseline | — | — | Out of MVP scope — no agent assigned yet |

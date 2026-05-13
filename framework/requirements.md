# Requirements / Analysis

## Goals
- Capture clear, testable functional and non-functional requirements.
- Align all Stakeholders on scope boundaries and success criteria.
- Establish cross-team contracts — APIs, SLAs, data contracts, RTO/RPO.
- Define measurable NFR thresholds and enforce them as quality gates in CI/CD.
- Produce detailed estimates per epic/feature to refine the milestone plan.

## Inputs
- Project charter and scope definition (from Planning)
- High-level sizing and capacity plan (from Planning)
- High-level roadmap and milestone plan (from Planning)
- NFR baseline (from Planning)
- Stakeholder map and RACI (from Planning)
- Product vision or opportunity brief
- Business user interviews and research findings
- Requirements workshops and meetings notes
- Architecture constraints and platform guidelines

## TPM Tasks
- Facilitate requirements workshops with Product, Engineering, Security, Compliance, and Legal as needed.
- Ensure all requirements are testable and have explicit acceptance criteria.
- Drive detailed estimation of epics and features with Engineering; use results to refine the milestone plan.
- Document cross-team contracts: API specs, SLAs, data contracts, RTO/RPO targets.
- Define NFR thresholds (performance, availability, security, code quality, license compliance) and specify where they are enforced in CI/CD.
- Establish change control — any scope addition must go through impact assessment before acceptance.
- Track requirements coverage and flag gaps before moving to Design.

## Outputs

| Output | Stored In |
|--------|-----------|
| PRD | Confluence: 3. Requirements / Functional Requirements |
| Functional requirements with acceptance criteria | Confluence: 3. Requirements / Functional Requirements + Jira (linked to epics) |
| Non-Functional Requirements with measurable thresholds | Confluence: 3. Requirements / Non-Functional Requirements |
| Cross-team contracts (API specs, SLAs, data contracts) | Confluence: 3. Requirements / Acceptance Criteria |
| Detailed estimation per epic / feature | Jira (story points) |
| Refined milestone plan | `/program/model.md` + Confluence: 2. Planning |
| Requirements traceability matrix | Confluence: 3. Requirements |

## Quality Gates
- All epics have documented acceptance criteria in Jira.
- NFRs are measurable, agreed by Engineering, Security, and Product, and mapped to CI/CD gates.
- Cross-team contracts are defined and signed off by owning teams.
- Detailed estimates completed and milestone plan refined and re-accepted by Stakeholders.
- Change control process is established and communicated.
- Requirements baseline approved — scope is frozen for Design.

## Risks & Watch Items
- Requirements not testable — delivery cannot be verified at QA.
- Scope creep through small additions that accumulate without impact assessment.
- NFRs defined too loosely — quality gates cannot be enforced objectively.
- Cross-team contracts undefined — integration failures discovered late in Testing.
- Estimation done under pressure without Engineering input — milestone plan remains unreliable.
- Requirements churn without change control — Design and Engineering start on moving targets.

## AI Capabilities

| Area | Agent | AI Role | How AI Helps |
|------|-------|---------|--------------|
| Requirements review | Program Brain | Augment | Reviews requirements for testability, completeness, and ambiguity; flags issues for TPM |
| Acceptance criteria drafting | Program Brain | Assist | Drafts acceptance criteria from requirement descriptions for Engineering review |
| Scope creep detection | Program Brain | Augment | Compares incoming requirements against baseline scope; flags additions for impact assessment |
| Detailed estimation support | Program Brain | Assist | Suggests story point ranges based on requirement complexity and historical velocity data |
| Cross-team contract tracking | Dependency Agent | Assist | Tracks API and SLA contract status across teams; flags unsigned or missing contracts — out of MVP scope |
| Backlog item drafting | Program Brain | Automate | Drafts Jira epics and stories with acceptance criteria from interview notes, meeting notes, and workshop outputs — presented for Product and TPM review before creating in Jira |
| Requirements gap detection | Knowledge Agent | Augment | Flags requirements referenced in communications but not yet documented in Confluence |
| NFR threshold definition | — | — | Out of MVP scope — no agent assigned yet |
| Requirements traceability | — | — | Out of MVP scope — no agent assigned yet |

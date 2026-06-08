# Risk Agent

## Purpose
Monitors, identifies, scores, and tracks program risks. Keeps the risk register current and alerts the TPM when risk status changes or new risks emerge.

## Data Sources

| Source | What It Reads | What It Writes |
|--------|--------------|----------------|
| Jira | Blockers, overdue issues, unresolved bugs | — |
| SonarQube | Security vulnerabilities, quality gate failures | — |
| GitHub | Failed pipelines, stale PRs, dependency alerts | — |
| Confluence | Risk documentation, ADRs | — |
| streams/<stream>/raid.md | Risks section of the RAID log | raid.md |
| streams/<stream>/raid.md | Dependencies section (status) | — |

## Triggers
- Scheduled: weekly risk review
- Event-driven: new Jira blocker, SonarQube quality gate failure, GitHub pipeline failure
- On demand: TPM request

## Behaviors
- Scans data sources for new risk signals
- Scores risks by likelihood and impact
- Flags risks approaching or exceeding threshold
- Proposes mitigation strategies for TPM review
- Archives resolved risks to `streams/<stream>/history/`

## Outputs
- Updated risk register (pending TPM approval)
- Weekly risk summary
- Alerts for new or escalating risks

## Requires TPM Approval
- Adding or closing risks in the register
- Changing risk severity or owner
- Escalating a risk to Stakeholders

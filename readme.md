# Objective

Build Technical Program Management framework to level-up program management practicies through automating data collection, review cycles, risk and dependency analysis, reporting by set of AI agents.

AITPM framework makes sure no essentials missed and provide the recommendations for a TPM descisions.
It provides program teams with the structured set of the requirements, documents, standards, data, capabilities to accomplish their goals.

Business Value 
Deliver reliably more programs, more predictably, at lower risk and cost by ensuring every program runs according to plan, identifying and resolving deviations early, and always having a reliable visibility into program health to make confident business decisions.

# Installation

This repo is a Claude Code plugin **and** its own plugin marketplace. Installing it pulls the agents, skills, and MCP server configuration directly from GitHub — no local clone or path setup required.

## Install the plugin

Inside Claude Code:

```
/plugin marketplace add vyazovsky1/tpm
/plugin install tpm@tpm
```

- `/plugin marketplace add vyazovsky1/tpm` — clones this GitHub repo and registers its marketplace. **This is where the GitHub link is supplied**; everything after refers to the registered marketplace by name.
- `/plugin install tpm@tpm` — installs the plugin. The syntax is `<plugin>@<marketplace>`; both the plugin (`.claude-plugin/plugin.json`) and the marketplace (`.claude-plugin/marketplace.json`) are named `tpm`.

To update later: `/plugin marketplace update tpm`.

## One-time Google authentication (per machine)

The Gmail, Drive, and Calendar MCP servers need Google OAuth credentials, stored in a `.env` that is **not** part of the plugin (it is gitignored). Set it up once per laptop:

1. Create a Google Cloud project and an OAuth 2.0 client (Desktop app type).
2. Enable the Gmail API, Drive API, and Calendar API.
3. Run the auth helper, which opens a browser and writes the refresh token:
   ```bash
   node scripts/google-auth.js
   ```

The MCP servers (configured in `.mcp.json`) launch via `scripts/mcp-google.sh`, which loads `.env` automatically. Paths use `${CLAUDE_PLUGIN_ROOT}`, so they resolve wherever the plugin is installed. **Requires bash** (WSL on Windows) for the launcher script.

## Setting up a program

Each program gets its own folder that references this framework:

```bash
bash scripts/new-program.sh <program-name> <target-path>
cd <target-path>
claude .
# then run /tpm-kickoff inside Claude Code
```

# Current Capabilities 

| SDLC Stage | Goals | TPM Tasks |
|-----------|-------|-----------|
| [Planning / Initiation](planning.md) | - Ensure the project is feasible, scoped, and prioritized vs. business and tech constraints.<br>- Align stakeholders on outcomes, timelines, and success metrics.<br>- Identify major risks, dependencies, and constraints early.<br>- Establish high-level expectations for quality, security, compliance, and licensing. | - Partner with product and engineering to define scope, epics, and MVP boundaries.<br>- Map high-level dependencies, capacity, and key delivery milestones (quarters/PIs/sprints).<br>- Run risk and dependency workshops; capture owners and mitigation strategies.<br>- Drive agreement on initial NFR bar (performance, availability, security, data/privacy, license compliance) and where it will be enforced in the SDLC. |
| [Requirements / Analysis](requirements.md) | - Capture clear, testable functional and non-functional requirements.<br>- Align all stakeholders on scope boundaries and success criteria.<br>- Reduce ambiguity and prevent scope creep.<br>- Define concrete quality, security, and compliance gates as part of NFRs. | - Facilitate workshops to refine requirements and NFRs with product, engineering, security, compliance, legal as needed.<br>- Document acceptance criteria and cross-team contracts (APIs, SLAs, data contracts, RTO/RPO).<br>- Explicitly define NFR checks: code-quality thresholds, security posture (e.g., SAST/SCA requirements), license policy (allowed/denied license types).<br>- Ensure requirements/SRS capture where and how these checks appear in CI/CD and release processes. |
| [Design / Architecture](design.md) | - Ensure the solution is scalable, maintainable, secure, and cost-aware.<br>- Align implementation with architecture, platform, and security standards.<br>- Decouple work to minimize late-cycle rework and cross-team blocking.<br>- Embed quality, security, and compliance into the design (defense in depth). | - Coordinate design/architecture reviews with tech leads, security, infra, and data teams.<br>- Capture key design decisions (ADRs), trade-offs, and risk areas, including security and data-protection design choices.<br>- Ensure logging, monitoring, and observability for quality and security events are part of the design.<br>- Confirm that design supports required checks (static analysis, dependency scanning, secret scanning, license scanning, runtime security) via chosen tooling and pipelines. |
| [Implementation / Development](implementation.md) | - Deliver increments predictably while maintaining code quality, security, and tech health.<br>- Surface blockers, risks, and scope changes early.<br>- Keep the team aligned to roadmap, capacity, and milestones.<br>- Catch code-quality, security, and license issues as early as possible (“shift left”). | - Facilitate backlog refinement, sprint planning, and cross-team coordination.<br>- Ensure static code analysis, linters, and formatting tools are integrated and required on every PR/commit.<br>- Ensure SAST, secrets scanning, and SCA/license scanning run in CI and enforce agreed quality gates for merges (e.g., no new critical issues, no disallowed licenses).<br>- Track scan results and code-quality metrics; coordinate triage of issues and allocation of capacity to remediate them.<br>- Monitor delivery health (velocity, burndown, defect trends) and escalate systemic risks or scope changes. |
| [Testing / QA](testing.md) | - Validate that features meet functional and non-functional requirements.<br>- Reduce regressions and production defects through strong test coverage.<br>- Ensure release candidates meet quality, security, and compliance thresholds.<br>- Treat critical scan and test failures as release-blocking. | - Coordinate test planning across unit, integration, E2E, performance, security, and compatibility testing.<br>- Ensure quality gates include test coverage, defect severity thresholds, and results of security and license scans for the release branch.<br>- Drive triage and prioritization of defects and scan findings; track resolution to meet release criteria.<br>- Align QA, product, and security on “release-ready” definition and sign-off process. |
| [Deployment / Release](deployment.md) | - Deploy changes safely with clear rollback options and monitoring.<br>- Minimize user impact during rollouts and cutovers.<br>- Ensure all release gates (quality, security, licenses, compliance) are satisfied before go-live.<br>- Provide clear visibility to stakeholders during and after release. | - Own the release plan: rollout strategy (canary, phased, feature flags), timing, roles, and rollback strategy.<br>- Verify that all required checks (tests, SAST/SCA, penetration test where applicable, license compliance, approvals) have passed before deployment.<br>- Coordinate with SRE/infra for environment readiness, monitoring, alerting, and access control.<br>- Run release “war room” or coordination channels; track status, incidents, and communications to stakeholders and customers.|

| [Maintenance / Operations](operations.md) | - Preserve system health, reliability, security, and performance over time.<br>- Manage incidents, vulnerabilities, tech debt, and operational toil systematically.<br>- Ensure ongoing compliance with security, privacy, and license obligations.<br>- Feed learnings and metrics back into planning and process improvements. | - Set up and maintain incident management processes (on-call, SLAs, postmortems) and track follow-up actions.<br>- Coordinate patching, upgrades, vulnerability management, and periodic rescans (code, dependencies, licenses, infrastructure).<br>- Track operational metrics (availability, latency, error rates), security metrics (vuln backlog, mean-time-to-remediate), and cost metrics and ensure they inform backlogs and planning.<br>- Facilitate retrospectives and continuous-improvement initiatives to refine SDLC, quality, and security practices across stages. |

# Processes
Timeline Management
Knowledge Management
Risk Management
Dependency Management
Communication Management
Stakeholder Management
Reporting

TODO:
Actions

Product
/dor
/dod
/roadmap

Release
/release

Operations
/mom Meeting minutes

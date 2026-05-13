# Program Brain — AI-First TPM Framework

## Problem Statement
How might we give TPMs a continuously aware, always-on program intelligence layer — so every program runs according to plan, deviations are caught early, and the TPM stays in control of every decision?

## Recommended Direction

A central AI agent — the Program Brain — acts as the TPM's Chief of Staff. It holds the full program model, monitors data sources continuously, surfaces deviations and risks, and prepares options for the TPM to decide on.

The TPM retains full decision power. The Brain drafts, monitors, and executes — the TPM approves, directs, and owns outcomes.

The framework is delivered as a repo of prompts and agent definitions — forked once per program, works with any major AI (Claude, Gemini, Codex).

## Key Assumptions to Validate
- [ ] TPMs will maintain `/program` state consistently — agents depend on it being current
- [ ] Skills and agent definitions are portable enough to run across Claude, Gemini, and Codex without rewriting
- [ ] TPMs will trust AI-generated drafts enough to shift from writing to reviewing

## Scope
- Framework: all 7 SDLC stage files with Goals, Tasks, Outputs, Quality Gates, AI Capabilities
- Processes: Risk, Dependency, Stakeholder, Communications, Knowledge, Reporting
- Agents: Program Brain + one agent per process
- Integrations: Jira, GitHub, SonarQube, Google Workspace (Gmail, Chat, Calendar, Drive), Confluence
- Program state: `/program` folder maintained by agents, approved by TPM, with `/history`

## MVP Scope
- Framework: SDLC stages: Planning, Requirements
- Processes: Knowledge Management
- Agents: Program Brain, Knowledge Agent, Requirements Agent, Communications Agent (includes Stakeholder management)
- Integrations: Confluence, Google Drive, Gmail, Google Chat

## Not Doing (and Why)
- **No UI** — any AI chat tool is the front end; the repo is the interface
- **No automated decisions** — TPM approves everything consequential
- **No shared multi-program instance** — one repo fork per program keeps state clean and isolated
- **No custom skill per program** — `/program` context makes generic skills program-specific

## Open Questions
- What is the onboarding flow for a new program? (likely a `/kickoff` skill)
- How does the Brain hand off context between sessions?
- How are `/history` snapshots triggered — by time, by stage gate, or by TPM command?

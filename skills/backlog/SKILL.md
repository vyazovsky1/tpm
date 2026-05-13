---
name: backlog
description: Drafts a product backlog as the Requirements Agent. Use when requirements inputs are available and a backlog needs to be created or updated. Reads program scope and all data inputs, then produces epics and stories with acceptance criteria and sizing.
---

# TPM: Backlog

Act as the Requirements Agent. Read the agent definition, then execute the backlog drafting workflow.

## Step 1 — Load context (read in this order, no discovery)

1. `${CLAUDE_PLUGIN_ROOT}/agents/requirements-agent.md` — agent rules and behaviors
2. `./program/model.md` — current scope, sizing, milestones
3. `./data/docs/` — all files (specs, architecture docs, briefs)
4. `./data/meetings/` — all files (workshop notes, interview notes)
5. `./data/emails/` — all files (requirements threads, decisions)
6. `./data/chat/` — all files (informal decisions, blockers)

If a directory is empty or missing, skip it without comment.

If `$ARGUMENTS` is provided, treat it as a focus area and limit the backlog to that epic or feature only.

## Step 2 — Draft the backlog

For each epic in scope (from `model.md`):
- Draft stories with: title, description, acceptance criteria, t-shirt size (XS/S/M/L/XL), dependencies
- Group stories under their parent epic
- Flag any epic with fewer than 2 stories as under-specified
- Flag any story without clear acceptance criteria as incomplete

Format output as a structured table per epic:

| Story | Description | Acceptance Criteria | Size | Dependencies | Status |
|-------|-------------|---------------------|------|--------------|--------|

## Step 3 — Surface gaps

- List requirements found in emails or chat that are not yet reflected in any epic
- List epics from `model.md` that have no supporting input documents
- Flag NFRs (performance, security, availability) if none are defined

## Step 4 — Present for review

State clearly:
- Total epics covered
- Total stories drafted
- Number of flagged items (under-specified epics, incomplete stories, gaps)

Do not create any files or update `./program/model.md` without explicit TPM approval.

---
name: backlog
description: Drafts a product backlog as the Requirements Agent. Use when requirements inputs are available and a backlog needs to be created or updated. Reads program scope and all data inputs, then produces epics and stories with acceptance criteria and sizing.
---

# TPM: Backlog

## Overview

Transform raw program inputs — specs, architecture docs, interview notes, emails, chat logs — into a structured backlog of epics and stories with acceptance criteria and sizing. The backlog is the bridge between program scope and delivery. A good backlog makes estimation reliable, design purposeful, and Engineering unblocked.

This skill acts as the Requirements Agent. It reads the agent definition, applies its rules, and produces output for TPM and Product review. Nothing is written or published without explicit approval.

## When to Use

- Requirements inputs exist in `./data/` and a backlog needs to be drafted or updated
- A new epic or feature has been added to scope and needs to be broken down
- The backlog exists but gaps have been flagged and need to be filled

**When NOT to use:** No inputs available in `./data/` — seed the data directories first. Single-story clarifications that don't require reading all inputs.

## Process

### Step 1 — Load context (read in this order, no discovery)

1. `${CLAUDE_PLUGIN_ROOT}/agents/requirements-agent.md` — agent rules and behaviors
2. `./streams/<stream>/context.md` — current scope, sizing, milestones
3. `./data/docs/` — all files (specs, architecture docs, briefs)
4. `./data/meetings/` — all files (workshop notes, interview notes)
5. `./data/emails/` — all files (requirements threads, decisions)
6. `./data/chat/` — all files (informal decisions, blockers)

If a directory is empty or missing, skip it without comment.

If `$ARGUMENTS` is provided, treat it as a focus area and limit the backlog to that epic or feature only.

### Step 2 — Draft the backlog

For each epic in scope (from `context.md`):
- Draft stories with: title, description, acceptance criteria, t-shirt size (XS/S/M/L/XL), dependencies
- Group stories under their parent epic
- Flag any epic with fewer than 2 stories as under-specified
- Flag any story without a clear pass/fail acceptance criterion as incomplete

Format output as a structured table per epic:

| Story | Description | Acceptance Criteria | Size | Dependencies | Flags |
|-------|-------------|---------------------|------|--------------|-------|

### Step 3 — Surface gaps

- Requirements found in emails or chat not yet reflected in any epic
- Epics from `context.md` with no supporting input documents
- NFRs (performance, security, availability) — flag if none are defined

### Step 4 — Present for review

State clearly:
- Total epics covered, total stories drafted
- Number of flagged items (under-specified epics, incomplete stories, undocumented requirements, missing NFRs)

Do not create any files or update `./streams/<stream>/context.md` without explicit TPM approval.

## Red Flags

- Drafting stories without reading `context.md` first — scope drift guaranteed
- Acceptance criteria that say "works correctly" or "as expected" — not testable
- An epic with a single story — almost always under-specified
- No NFRs in the entire backlog — a program without non-functional requirements will fail in testing
- Marking gaps as resolved without a corresponding document in `./data/`

## Verification

Before presenting the backlog for review, confirm:

- [ ] Every story has at least one acceptance criterion with a clear pass/fail condition
- [ ] Every epic maps to a scope item in `context.md`
- [ ] All input directories were checked (or skipped with reason)
- [ ] Gap section is present, even if empty
- [ ] NFRs are addressed or explicitly flagged as missing
- [ ] No files were created or modified without TPM approval

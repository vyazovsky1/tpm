---
name: meeting-prep
description: Prepares a follow-up meeting agenda for a stream as the Meetings Agent. Use before a meeting to assemble a per-teammate agenda (open items + updates since last call), then issues/blockers/dependencies, then new items for discussion from comm channels. Produces a document; no stream state is changed without TPM approval.
---

# TPM: Meeting Prep

## Overview

Assemble a follow-up agenda for an upcoming meeting from a stream's live state. This skill acts as the Meetings Agent: it reads the agent definition, applies its rules, and produces a follow-up agenda **document** for TPM review. The agenda is the active artifact until the next `/tpm:meeting-summary` retires it to `history/`.

`$ARGUMENTS` is the **stream name**. It is required — this skill always operates inside one stream.

## When to Use

- A meeting is coming up and the TPM needs an agenda grounded in what's actually open
- A recurring meeting's next occurrence needs its agenda regenerated, carrying forward still-open items
- The TPM wants a per-teammate view (open items + what each person did since the last call) plus issues/blockers and new discussion items

**When NOT to use:** No stream named in `$ARGUMENTS`. Summarizing a meeting that already happened — use `/tpm:meeting-summary` instead.

## Process

### Step 1 — Load context (read in this order, no discovery)

1. `${CLAUDE_PLUGIN_ROOT}/agents/meetings-agent.md` — agent rules and behaviors
2. `${CLAUDE_PLUGIN_ROOT}/skills/meeting-prep/agenda-template.md` — the common agenda format
3. `./streams/<stream>/context.md` — scope and standing instructions
4. `./streams/<stream>/team.md` — the roster (one agenda block per person)
5. Most recent summary in `./streams/<stream>/meetings/` — its date is the **last-call window** for "updates since last call"
6. `./streams/<stream>/action-items.md` — Active items (Open / In Progress / Blocked / Proposed-Closed)
7. `./streams/<stream>/raid.md` — open Issues and Dependencies; Assumptions/Risks needing discussion
8. `./streams/<stream>/communications.md` — unanswered threads, new discussion items
9. `./integrations.md` + `./.data/<source>/` — connected sources for per-teammate updates "as available": chat and email today; commits/MRs (GitLab/GitHub) and Jira once those phase-2 integrations are connected. Skip any source not configured.

### Step 2 — Assemble the agenda

Fill the common template (`agenda-template.md`) in this order:

1. **Per Teammate** — one block per person in `team.md`:
   - **Open items** — their Open / In Progress / Blocked items from `action-items.md`
   - **Updates since last call** — what they did since the last summary's date, gathered from every *connected* source: emails and chats they authored, and where configured, their commits/MRs and Jira moves. Include only channels that are connected; omit the rest without comment.
2. **Issues / Blockers / Dependencies** — open Issues and Dependencies from `raid.md`, plus blockers surfaced in `communications.md`.
3. **New for Discussion** — new items raised across comm channels since the last call.
4. **To Confirm Closed** — items marked `Proposed-Closed` in `action-items.md`.

Every item names an owner (resolve against `team.md` or flag). For a recurring meeting, regenerate fresh: still-open items reappear, items closed since the last occurrence drop off.

### Step 3 — Present for review

State clearly:
- Stream and target meeting
- Counts: teammates covered, open items, issues/blockers/dependencies, new discussion items, items proposed for closure confirmation
- Which update channels were available vs. skipped (e.g. "code + Jira not connected — chat/email only")
- Whether this is a recurring-meeting regeneration and what dropped off

On approval, copy the template to `./streams/<stream>/meetings/<YYYY-MM-DD>-agenda.md` and fill it in (or publish to the notes tool if the TPM directs). The previous agenda is retired to `history/` by `/tpm:meeting-summary`, not here. Do not write or publish without TPM approval.

## Red Flags

- Building the agenda without reading `context.md` first — standing instructions get missed
- Pulling in closed or already-archived items as if open
- Listing items with no owner — resolve against `team.md` or flag
- Claiming a teammate has "no updates" when the cause is an unconnected source — say which channels were unavailable instead
- Inventing code/Jira activity when those integrations aren't connected — those fields stay empty until phase 2
- Publishing the agenda to the notes tool without approval

## Verification

Before presenting for review, confirm:

- [ ] A stream was named in `$ARGUMENTS` and its `context.md` was read
- [ ] There is one Per-Teammate block per person in `team.md`
- [ ] The last-call window came from the most recent summary in `meetings/`
- [ ] Per-teammate updates drew only on connected sources; unavailable channels were named, not faked
- [ ] Issues/Blockers/Dependencies and New-for-Discussion sections are present, each item with an owner
- [ ] For recurring meetings, items dropped since the last occurrence are accounted for
- [ ] The agenda is a document for review — nothing was published without TPM approval

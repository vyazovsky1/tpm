---
name: meeting-summary
description: Summarizes new meeting notes for a stream as the Meetings Agent. Use after a meeting to draft a summary, extract action items with owners, and propose closures for items resolved by later meetings. Reads notes via the meeting-notes integration; all writes require TPM approval.
---

# TPM: Meeting Summary

## Overview

Turn a stream's new meeting notes into a structured summary and a set of tracked action items. This skill acts as the Meetings Agent: it reads the agent definition, applies its rules, and produces output for TPM review. Nothing is written to stream state or published until the TPM approves.

`$ARGUMENTS` is the **stream name**. It is required — this skill always operates inside one stream.

## When to Use

- A meeting just happened and its notes are available via the stream's `meeting-notes` source (or pasted)
- New notes have appeared in the stream's notes folder/space since the last run
- A recurring meeting occurred and its follow-up agenda needs to be retired

**When NOT to use:** No stream named in `$ARGUMENTS`. No new notes and nothing to reconcile. Preparing for an upcoming meeting — use `/tpm:meeting-prep` instead.

## Process

### Step 1 — Load context (read in this order, no discovery)

1. `${CLAUDE_PLUGIN_ROOT}/agents/meetings-agent.md` — agent rules and behaviors
2. `./streams/<stream>/context.md` — scope, standing instructions, any per-stream note-tool override
3. `./streams/<stream>/team.md` — roster and RACI, for owner resolution
4. `./streams/<stream>/action-items.md` — existing items and their status (for reconciliation)
5. `./integrations.md` — the `meeting-notes` backing source mapped to this stream and where it caches
6. `./.data/<source>/` — read the cache first. If a needed note isn't cached, fetch it live via the source's MCP server (fetched notes are kept under `.data/<source>/`). If the source is `pasted`, use the notes the TPM provides in-session.

If there are no new notes and nothing to reconcile, say so and stop.

### Step 2 — Draft the summary

For each new meeting note:
- Draft the summary using the common template at `${CLAUDE_PLUGIN_ROOT}/skills/meeting-summary/summary-template.md` — fill every field. Set **Notes source** to the note's resource URL from the integration metadata (Drive web view link / Confluence page URL), never a local cache path.
- Extract action items: action, owner (resolved against `team.md`; `UNASSIGNED` + flag if none), source (this meeting), opened date, due date if stated, status `Open`

The template carries an action-items table; for cross-meeting tracking the full record (with Source) lives in `action-items.md`:

| Action | Owner | Source | Opened | Due | Status |
|--------|-------|--------|--------|-----|--------|

### Step 3 — Reconcile (propose-only)

- Compare extracted items and these notes against existing Active items in `action-items.md`
- Where a later meeting resolved an earlier item, mark that item `Proposed-Closed` and cite the resolving note
- Never close or archive an item here — only propose

### Step 4 — Present for review

State clearly:
- Meeting(s) summarized
- Action items extracted (count), with any `UNASSIGNED` flagged
- Closures proposed (count), each with its resolving note
- The prior follow-up agenda that will move to `history/` on approval

On approval: copy the common template to `./streams/<stream>/meetings/<YYYY-MM-DD>-<type>.md` and fill it in (one file per meeting, never a shared log); append items to `action-items.md`; apply proposed closures (move closed items to `history/`); and move the prior agenda document to `history/`. Do nothing to these files without explicit TPM approval.

## Red Flags

- Summarizing without reading `context.md` and `team.md` first — owners and standing instructions get missed
- Auto-closing an action item — violates the approval rule; reconciliation is propose-only
- Inventing an owner not in `team.md` instead of marking `UNASSIGNED`
- Attributing a note to the stream when attribution is ambiguous — flag it instead
- Writing the summary back to the notes tool without approval

## Verification

Before presenting for review, confirm:

- [ ] A stream was named in `$ARGUMENTS` and its `context.md` + `team.md` were read
- [ ] Every extracted action item has an owner (resolved or `UNASSIGNED`+flagged), a source, and a status
- [ ] Reconciliation produced only `Proposed-Closed` markers, never closures
- [ ] The prior follow-up agenda is identified for retirement to `history/`
- [ ] No files were written and nothing was published without TPM approval

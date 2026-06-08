# Meetings Agent

> Built on the [Stream-Scoped Program Model](stream-model.md). That refactor lands first so `/program/...` paths change exactly once.

## Problem Statement
*How might we let a TPM walk into any meeting with an accurate, self-updating, per-stream view — decisions made, action items still open, questions unanswered — without manually stitching notes, RAID, and email together?*

## Recommended Direction
A dedicated, **stream-scoped** Meetings Agent delivering capabilities 1–3. It always operates inside one stream and loads that stream's `context.md` + `team.md` first, so output inherits the stream's standing instructions and roster. Cross-meeting reconciliation **proposes** `[x]` closures; the TPM approves every write. The **team-pulse contribution digest is phase 2** (built on Reporting Agent; needs a new `integrations/gitlab.md`).

## How it works (per stream)
- **`/meeting-summary <stream>`** — reads new notes via the `meeting-notes` integration → drafts summary + extracts action items (owner resolved from `team.md`) → on approval, appends summary to `meetings.md` and items to `action-items.md`. **Creating the summary also moves the meeting's prior follow-up agenda document into `history/`.**
- **Reconciliation** — scans recent notes/threads for items later notes resolved → *proposes* `[x]` closures in `action-items.md` (never auto-closes) → closed items archive to `history/`.
- **`/meeting-prep <stream>`** — produces a **follow-up agenda document** from three stream sources: open items in `action-items.md`, open Assumptions / Risks-needing-discussion in `raid.md`, and unanswered threads in `communications.md`.

## Agenda lifecycle
`/meeting-prep` → follow-up agenda **document** (active) → meeting happens → `/meeting-summary` writes summary **and moves the agenda to `history/`**.

## Framework changes
**New**
- `agents/meetings-agent.md`
- `integrations/meeting-notes.md` — platform-agnostic abstraction (Drive folder / Confluence space / pasted); notes tool captured at program init, stored in the program's `CLAUDE.md` memory, optional per-stream override in `context.md`

**Modified**
- `agents/program-brain.md` — Delegation Rules row for Meetings Agent; load stream `context.md` when scoped
- `agents/communications-agent.md` — its email/chat action items write into the same stream's `action-items.md` (shared store, no fork)
- `processes/communication-management.md` — add a Meeting Management section
- `scripts/new-program.sh` — `/meeting-prep` + `/meeting-summary` commands; init question for the note-taking tool
- `.claude-plugin/plugin.json` — register `meetings-agent`
- `CLAUDE.md` — add Meetings Agent to MVP scope

## Key Assumptions to Validate
- [ ] Notes are retrievable per-meeting **and attributable to a stream** across whatever tool — the abstraction's load-bearing bet.
- [ ] Cross-meeting action-item matching is good enough to *suggest* closures without eroding TPM trust (propose-only mitigates).

## MVP Scope
**In:** `meeting-notes` integration; `/meeting-summary <stream>` and `/meeting-prep <stream>`; summary + action-item extraction; propose-only reconciliation with `history/` archival; agenda document with retire-to-history lifecycle; agenda from action-items + RAID + comms; all writes TPM-approved.
**Out (phase 2):** team-pulse digest; GitLab integration; Calendar-driven scheduling.

## Not Doing (and why)
- **Team-pulse in v1** — heaviest piece, 4 integrations, overlaps Reporting Agent; sequenced as the standup feature next.
- **Auto-closing action items** — violates the approval rule; fuzzy matching makes it risky. Propose only.
- **Recording / transcribing** — the note-taking tool's job; we consume its output and stay agnostic.
- **Sending invites / editing calendars** — Calendar stays read-only, out of MVP.

## Resolved Decisions
- Follow-up agenda → **a document**, retired to `history/` when the next meeting summary is created.
- (Stream/RAID/action-item ownership rules live in the [Stream-Scoped Program Model](stream-model.md).)

## Open Questions
- Does the follow-up agenda document get written back to the notes tool, or kept in the stream folder?

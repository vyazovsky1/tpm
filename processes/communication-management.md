# Communication Management

## Purpose
Keep program communication accurate, timely, and traceable: no critical message missed or delayed, every Stakeholder appropriately informed, and every commitment made in a meeting or thread captured as a tracked action item. Communication is managed per stream — each stream owns its `communications.md`, `action-items.md`, and `meetings/` directory — with program-wide views aggregated across streams, not stored.

## Model
Communication flows through three channels, all reconciled into stream state:

| Channel | Source | Lands In |
|---------|--------|----------|
| Asynchronous | Gmail, Google Chat | `communications.md`; commitments → `action-items.md` |
| Synchronous | Meetings (via `meeting-notes`) | one summary file per meeting in `meetings/`; commitments → `action-items.md`; decisions → `decisions.md` |
| Outbound | TPM updates, status reports, follow-ups | drafted by agents, sent on TPM approval, logged in `communications.md` |

Action items are a single shared store per stream. Whether a commitment originates in an email, a chat, or a meeting, it is written to the same `action-items.md` — never a per-channel fork. The `Source` column records where it came from.

## TPM Responsibilities
- Approve every outbound communication before it is sent
- Approve every write to `communications.md`, the `meetings/` summaries, `action-items.md`, and `decisions.md`
- Confirm action-item closures the agents propose (closures are never automatic)
- Decide when to escalate a Stakeholder concern or an overdue commitment
- Own the cadence of recurring meetings and the note-taking tool choice

## Team Responsibilities
- Capture meeting notes in the program's note-taking tool so they are retrievable per meeting and attributable to a stream
- Respond to action items assigned to them and signal status changes
- Keep Stakeholder contact and engagement information current in `team.md`

## Agent Rules
1. **Shared action-item store** — Communications Agent and Meetings Agent write action items to the same `streams/<stream>/action-items.md`. Neither forks a separate list.
2. **Propose, don't close** — when a later communication or meeting resolves an item, the agent marks it `Proposed-Closed` and cites the resolving source. Only the TPM confirms closure; closed items move to `history/`.
3. **Attribution before write** — a meeting note or thread must be attributable to one stream before it is summarized or logged. Ambiguous attribution is flagged to the TPM, not guessed.
4. **Approval gate** — no outbound message is sent and no stream file is written without explicit TPM approval.

## Meeting Management
Owned by the Meetings Agent (`agents/meetings-agent.md`), operating per stream.

- **Ingest** — read new meeting notes via the `meeting-notes` integration (Drive folder / Confluence space / pasted), preferring the `.data/<source>/` cache.
- **Summarize** — `/tpm:meeting-summary <stream>` drafts a summary (decisions, discussion, action items), resolves owners against `team.md`, and on approval writes one summary file per meeting under `meetings/` (`YYYY-MM-DD-<type>.md`) plus updates to `action-items.md` and `decisions.md`.
- **Reconcile** — across meetings, propose `[x]` closures for items a later meeting resolved; archive confirmed-closed items to `history/`.
- **Prepare** — `/tpm:meeting-prep <stream>` assembles a follow-up agenda document: per teammate (open items + updates since last call, drawn from whatever sources are connected), then issues/blockers/dependencies, then new items for discussion from comm channels.
- **Agenda lifecycle** — the follow-up agenda is the active document until the next summary run retires it to `history/`.
- **Recurring meetings** — regenerate the agenda each cycle, carrying forward still-open items and dropping ones closed since the last occurrence.
- **Boundaries** — the agent consumes notes; it does not record or transcribe. Calendar is read-only and out of MVP. Per-teammate contribution digests (from backlog/Jira, GitLab/GitHub, email, notes) are phase 2, built on the Reporting Agent and a new `integrations/gitlab.md`.

## AI Capabilities

| Area | AI Role | How AI Helps | Agent |
|------|---------|--------------|-------|
| Inbound monitoring | Watcher | Scans Gmail and Google Chat for messages needing a TPM response; flags unanswered escalations | Communications Agent |
| Outbound drafting | Drafter | Drafts status updates and follow-ups tailored to recipient role and RACI, for TPM approval | Communications Agent |
| Stakeholder tracking | Tracker | Maintains engagement status, last-interaction dates, pending approvals; flags disengagement | Communications Agent |
| Meeting summary | Summarizer | Turns notes into structured summaries with decisions and extracted action items | Meetings Agent |
| Action-item reconciliation | Reconciler | Proposes closures for items resolved by later meetings; archives confirmed-closed items | Meetings Agent |
| Follow-up agenda | Assembler | Builds a per-teammate agenda (open items + updates since last call, as available), plus issues/blockers/dependencies and new discussion items | Meetings Agent |
| Contribution digest | Aggregator | Full multi-source per-teammate digest (backlog, repos, email, notes) as a standalone report — *phase 2*; meeting-prep already does the lite, agenda-embedded version from connected sources | Reporting Agent (out of MVP scope) |

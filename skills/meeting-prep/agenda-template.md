<!--
Common follow-up meeting-agenda template — shared by ALL streams and programs.
The Meetings Agent copies this to streams/<stream>/meetings/<YYYY-MM-DD>-agenda.md, fills it in,
and it stays the active agenda until the next /tpm:meeting-summary retires it to ../history/.
This is the single canonical format; it is not customized per stream.

"As available" = include only the channels actually configured for this stream in integrations.md;
skip the rest without comment. Code contributions (GitLab/GitHub) and Jira are phase-2 sources —
they populate the per-teammate updates once those integrations are connected.
-->
# Follow-up Agenda — <stream> — <meeting date>

## Per Teammate
<!-- One block per person in ../team.md, ordered by role. "Updates since last call" covers the
     window since the most recent summary in this meetings/ folder. -->
### <name> — <role>
- **Open items:** <their Open / In Progress / Blocked items from ../action-items.md>
- **Updates since last call:** <as available — commits / MRs (GitLab/GitHub), Jira moves,
  chat, email, prior meeting notes attributed to this person; omit channels not connected>

## Issues / Blockers / Dependencies
<!-- open Issues and Dependencies from ../raid.md, plus blockers surfaced in ../communications.md -->
- <item> — <owner> — <status / what's needed>

## New for Discussion
<!-- new items raised across comm channels since the last call — as available -->
- <item> — <source / who raised it>

## To Confirm Closed
<!-- items marked Proposed-Closed in ../action-items.md, pending TPM confirmation -->
- <action> — resolved by <note>

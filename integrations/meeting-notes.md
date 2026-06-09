# Meeting Notes

## Purpose
Platform-agnostic abstraction over wherever a program's meeting notes actually live: a Google Drive folder, a Confluence space, or notes pasted directly by the TPM. The Meetings Agent reads notes through this abstraction so the rest of the framework never depends on a specific note-taking tool. The backing source is captured at program init and recorded in the program's `CLAUDE.md`; a stream may override it in `streams/<stream>/context.md`.

This spec defines *how to find a stream's meeting notes*. The concrete fetch is delegated to the backing source's own integration (`google-drive.md` or `confluence.md`); when notes are pasted, there is no query — the TPM provides the text directly.

**Caching:** fetched notes are kept under `.data/<source>/` and read from there before fetching live. The `<DATE_LAST_RUN>` in the queries below is the date of the most recent meeting summary in `streams/<stream>/meetings/`; if there is none, fetch the full window.

**Resource URL:** capture each note's web link from the **search** metadata (Drive web view link / Confluence page URL) and carry it into the summary's **Notes source** — never a local cache path.

## Backing Source
The program records one of:
- **google-drive** — a Drive folder per stream (or one folder with a per-stream label/naming convention)
- **confluence** — a Confluence space, with notes tagged by a per-stream label
- **pasted** — no live source; the TPM pastes notes into the session

The chosen source name is what appears in `integrations.md` and the `.data/<source>/` cache folder.

## Standard Queries

### New meeting notes for a stream (Google Drive backing)
Notes added or modified since the last summary run, within the stream's notes folder.
```
parents in '<STREAM_NOTES_FOLDER_ID>' and modifiedTime > '<DATE_LAST_RUN>' order by modifiedTime desc
```

### New meeting notes for a stream (Confluence backing)
Note pages for the stream, modified since the last summary run.
```
space = <PROGRAM_SPACE_KEY> AND label = "<STREAM_NOTES_LABEL>" AND lastModified >= -<N>d ORDER BY lastModified DESC
```

### Notes for a specific meeting
Locate the single note document for one meeting by date or title.
```
# Drive
parents in '<STREAM_NOTES_FOLDER_ID>' and fullText contains '<MEETING_DATE_OR_TITLE>'
# Confluence
space = <PROGRAM_SPACE_KEY> AND label = "<STREAM_NOTES_LABEL>" AND title ~ "<MEETING_DATE_OR_TITLE>"
```

### Pasted notes
No query. The TPM provides the note text in-session; the agent treats it as a single meeting note attributed to the current stream.

## Field Mapping

| Meeting-Note Field | Framework Concept |
|--------------------|-------------------|
| Meeting date | Meeting log `Date` |
| Meeting title / type | Meeting log `Type` |
| Attendees | Meeting log `Attendees`; owner resolution against `team.md` |
| Decisions section | `decisions.md` entries |
| Action items / "TODO" / "owner: …" lines | `action-items.md` entries (owner, action, due) |
| Open questions / "parking lot" | Follow-up agenda items; unanswered-thread candidates |
| Note URL / web link (from search metadata) | Summary **Notes source** — the actual resource URL, never the local cache path |
| Last modified time | Freshness check vs. last summary run |

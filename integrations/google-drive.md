# Google Drive

## Purpose
Repository for program documents, reports, slide decks, and Stakeholder-facing artifacts. Primary destination for published reports and formal program deliverables.

## Authentication

## Data Available
- Program documents and templates
- Published status reports and presentations
- Stakeholder-shared files and feedback
- Historical artifacts and archived reports
- Meeting decks and decision documents

## Standard Queries

### Recently modified files in program folder
Fetch files modified in the last 7 days within the designated program folder.
```
parents in '<PROGRAM_FOLDER_ID>' and modifiedTime > '<DATE_7_DAYS_AGO>' order by modifiedTime desc
```

### Files by type in program folder
Fetch files of a specific MIME type (e.g., Google Docs, Sheets, Slides, PDFs).
```
parents in '<PROGRAM_FOLDER_ID>' and mimeType = '<MIME_TYPE>'
```

### Search files by keyword
Full-text search within the program folder.
```
parents in '<PROGRAM_FOLDER_ID>' and fullText contains '<KEYWORD>'
```

### Recently shared files
Fetch files shared with the program team in the last 7 days.
```
sharedWithMe = true and modifiedTime > '<DATE_7_DAYS_AGO>' order by modifiedTime desc
```

### Reports folder contents
List all files in the designated reports subfolder.
```
parents in '<REPORTS_FOLDER_ID>' order by modifiedTime desc
```

## Field Mapping

| Google Drive Field | Framework Concept |
|-------------------|------------------|
| File name | Artifact name |
| Web view link | Artifact location |
| MIME type | Artifact type |
| Modified time | Last updated |
| Last modifying user | Updated by |
| Parents | Folder / program context |
| Shared with | Distribution / Stakeholders |

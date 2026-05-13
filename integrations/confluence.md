# Confluence

## Purpose
Knowledge repository for architecture decisions, technical documentation, process definitions, and program knowledge base. Primary destination for formalized program knowledge.

## Authentication

## Data Available
- Architecture Decision Records (ADRs)
- Technical design documents
- Process documentation
- Meeting notes and retrospective outcomes
- Team runbooks and guidelines
- Sprint review summaries

## Standard Queries

### Recently modified pages in program space
Fetch pages modified in the last 7 days within the program Confluence space.
```
space = <PROGRAM_SPACE_KEY> AND lastModified >= -7d ORDER BY lastModified DESC
```

### Pages by label
Fetch pages tagged with a specific label (e.g., ADR, decision, retrospective, runbook).
```
space = <PROGRAM_SPACE_KEY> AND label = "<LABEL>" ORDER BY lastModified DESC
```

### Pages linked to a Jira epic
Fetch Confluence pages that reference a specific Jira epic key.
```
space = <PROGRAM_SPACE_KEY> AND text ~ "<JIRA_EPIC_KEY>"
```

### Search pages by keyword
Full-text search within the program space.
```
space = <PROGRAM_SPACE_KEY> AND text ~ "<KEYWORD>" ORDER BY lastModified DESC
```

### All ADRs
Fetch all Architecture Decision Records in the program space.
```
space = <PROGRAM_SPACE_KEY> AND label = "adr" ORDER BY created DESC
```

### Retrospective notes
Fetch all retrospective pages in the program space.
```
space = <PROGRAM_SPACE_KEY> AND label = "retrospective" ORDER BY created DESC
```

## Field Mapping

| Confluence Field | Framework Concept |
|-----------------|------------------|
| Page title | Artifact name |
| Page URL | Artifact location |
| Labels | Artifact type (adr, decision, retrospective, runbook) |
| Last modified date | Last updated |
| Author | Created by |
| Space key | Program identifier |

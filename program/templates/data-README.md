# .data — integration cache

Temporary, regenerable cache of data fetched from live integrations. One subfolder per
source, named for the integration / MCP server: `.data/<source>/` (e.g. `google-drive/`,
`gmail/`). Agents write fetched files here so they are not re-fetched every run.

This directory is gitignored. Safe to delete — it is repopulated on the next fetch. You
may also drop files here manually as a substitute for a live integration.

Which sources are active and what stream each feeds is defined in `../integrations.md`.

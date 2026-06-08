# Integrations

Active integrations for this program. Each row binds a framework integration spec
(`{{FRAMEWORK_DIR}}/integrations/<source>.md`) to this program's real sources and the stream
it feeds. To enable a source: fill in its scope, set Enabled to `yes`, and assign a stream.

Cached data fetched from a source lives in `.data/<source>/` (gitignored, regenerable).
Secrets are never stored here — they stay in `.env`. This file may be edited by hand or
written by a script.

| Source       | Enabled | Scope / Filter          | Stream    | Cache                  |
|--------------|---------|-------------------------|-----------|------------------------|
| google-drive | no      | {{folder id or name}}   | <stream>  | .data/google-drive/    |
| gmail        | no      | {{label or query}}      | <stream>  | no                     |
| confluence   | no      | {{space key}}           | <stream>  | no                     |
| google-chat  | no      | {{space name}}          | <stream>  | .data/google-chat/     |

## How agents use this
1. Read this file to discover enabled sources and their stream mapping.
2. Read cached data under `.data/<source>/`.
3. If the cache is missing or stale, fetch live via the source's MCP server, then write
   the result into `.data/<source>/`.

Source names match the framework integration specs in `integrations/` and the MCP servers
in the plugin's `.mcp.json`. Add a row for any other source (jira, github, ...).

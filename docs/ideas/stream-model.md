# Stream-Scoped Program Model

## Problem Statement
*How might we structure a program's state so each track of work owns its own knowledge, team, action items, and standing instructions — so every agent operates on the right slice and nothing is artificially flattened into one program-wide blob?*

## Recommended Direction
Generated program folders drop the `/program` folder. Everything lives under `streams/<stream>/`; the set of subfolders under `streams/` *is* the stream registry (no separate registry file). Risks, assumptions, issues, dependencies, and action items are all per-stream. Program-wide state is deferred — likely just a generated combined status report (an output, not stored state).

```
<program-folder>/
  streams/
    checkout/
      context.md        # overview, scope, milestones, standing instructions
      team.md           # members, roles, RACI, stream stakeholders
      action-items.md   # active action items
      raid.md           # RAID log — Risks, Assumptions, Issues, Dependencies
      decisions.md      # decision log
      knowledge.md      # index of artifacts / KB links
      meetings.md       # meeting log
      communications.md # email/chat comms log
      history/          # archived closed items, past meetings, retired agendas
    fraud-detection/ ...
  integrations.md       # integration registry (sources → scope → stream)
  .data/<source>/       # integration cache (gitignored, regenerable)
  .claude/              # commands + config
```

## Resolved Decisions
- **No `/program` folder** — streams only; the folder list is the registry.
- **All RAID + action items are per-stream.**
- **Cross-stream dependency** → duplicated as a D entry in *each* affected stream's `raid.md`, with a reference to the other stream.
- **Action item spanning two streams** → duplicated in each stream's `action-items.md`, each referencing the other stream.
- **Program-wide aggregation deferred** — most likely a generated combined status report later, not stored state.

## Agent behavior change
Every stream-scoped agent loads the relevant `streams/<stream>/context.md` + `team.md` **first**, so its output inherits that stream's standing instructions and roster. Program Brain aggregates *across* streams for health/reporting.

## Framework changes (refactor)
- Restructure the framework's `program/` templates into a per-stream template set: `context.md`, `team.md`, `action-items.md`, `raid.md`, `decisions.md`, `knowledge.md`, `meetings.md`, `communications.md`, `history/`.
- Update **all agent files** to reference `streams/<stream>/...` instead of `/program/...`.
- Update `scripts/new-program.sh` to scaffold `streams/` with one template stream + init questions.
- Update `CLAUDE.md` to document the streams-only structure.

## Key Assumptions to Validate
- [ ] Streams are a stable, enumerable list per program (the flat streams-only model assumes this).
- [ ] Loading per-stream `context.md` measurably sharpens agent output vs. one program-level context.
- [ ] No genuinely program-level state is needed before the combined report (revisit if one appears).

## Open Questions
- Is `context.md` free-form or a light fixed template (overview / scope / standing instructions / key contacts)? — tracked in `tasks/todo.md` Task 8.

## Consumers
- The [Meetings Agent](meetings-agent.md) is built directly on this structure.

# Common Project Infrastructure Rules

**Status:** Working standard  
**Applies to:** All project-infrastructure scenarios.

These rules define the canonical project-memory model. Scenario files add environment-specific storage, access, synchronization, and bootstrap rules.

## 1. Core project-memory files

A substantial project should expose a small set of stable, human-readable files with distinct responsibilities:

- `AGENTS.md` — AI entry point: how an agent should work with the project and which files it should read/update.
- `PROJECT.md` — stable project definition: objective, scope, deliverables, constraints, terminology, success criteria.
- `STATE.md` — current project snapshot: where the project is now.
- `TASKS.md` — task registry: done, active, blocked, next.
- `ASSUMPTIONS.md` — uncertainty register: provisional premises, confidence, impact, and validation state.
- `SOURCES.md` — registry of authoritative source files, datasets, external artifacts, and canonical locations.
- `README.md` — short human entry point; it should not duplicate current project state.

These files should not duplicate one another. Each has one primary responsibility.

## 2. Startup sequence and progressive disclosure

Do not load the whole project into model context by default.

Preferred startup sequence:

1. `AGENTS.md`
2. `PROJECT.md`
3. `STATE.md`
4. `TASKS.md`
5. `ASSUMPTIONS.md` when the task involves estimates, uncertainty, design choices, research, or analysis
6. `SOURCES.md` before locating, retrieving, or editing authoritative artifacts
7. decisions, plans, source documents, code, data, and outputs only as needed for the current task

This keeps startup context small while preserving continuity.

## 3. Current state is not a session log

`STATE.md` is the default handoff snapshot. It describes the **present**, not a chronological diary.

When information stops being current, replace or remove it from `STATE.md`. Historical context belongs in:

- version history when available;
- `docs/decisions/` for significant decisions and rationale;
- `docs/plans/completed/` for completed complex plans;
- optional archived notes/logs when they add real value.

Do not create parallel `HANDOFF.md`, `LATEST_CONTEXT.md`, `CURRENT.md`, or `SESSION_SUMMARY.md` files by default. Add them only for a specific justified workflow.

## 4. Facts, decisions, assumptions, recommendations, and tasks

Agents should distinguish these explicitly:

- **Fact** — supported by project evidence or an authoritative source.
- **Decision** — an explicit project choice.
- **Assumption** — a provisional premise used for analysis or planning.
- **Recommendation** — a proposed course of action that has not necessarily been accepted.
- **Task** — work to be performed.

Do not silently convert one category into another.

## 5. One canonical copy

For every important artifact, identify one canonical copy.

Avoid maintaining multiple competing “latest” copies across folders or services. If another copy exists for transport, conversion, review, local processing, or publication, treat it as temporary or derived and point back to the canonical artifact in `SOURCES.md`.

## 6. Root-file guidance

### `README.md` — human entry point

Keep it short. Include:

- project name;
- one-paragraph purpose;
- basic project structure;
- pointer to `AGENTS.md` for AI-assisted work;
- any essential human setup/opening instructions.

Do not duplicate detailed project state here.

### `AGENTS.md` — AI entry point

Recommended baseline:

```markdown
# Agent instructions

## Startup

Before substantive work, read in this order:

1. `PROJECT.md`
2. `STATE.md`
3. `TASKS.md`
4. `ASSUMPTIONS.md` when the task involves estimates, uncertainty, design choices, research, or analysis
5. `SOURCES.md` before locating, retrieving, or editing authoritative artifacts

Do not treat previous chat history as the authoritative project state.

## Working rules

- Prefer project files over remembered chat context when they conflict.
- Read only what is needed for the current task.
- Preserve canonical source files unless the task explicitly requires changing them.
- Distinguish facts, decisions, assumptions, recommendations, and tasks.
- Use appropriate tools to inspect large or complex files instead of placing their full contents into model context unnecessarily.
- Keep temporary/intermediate files separate from canonical outputs.

## Before finishing substantial work

- Update `STATE.md` if project state changed.
- Update `TASKS.md`.
- Update `ASSUMPTIONS.md` and `SOURCES.md` when relevant.
- Record significant decisions under `docs/decisions/`.
- Leave the project in a state where a new agent can continue without the previous chat.
```

Project-specific rules may be added below this baseline. Do not turn `AGENTS.md` into a full project encyclopedia.

### `PROJECT.md` — stable project definition

Recommended sections:

```markdown
# Project

## Objective

## Scope

### Included

### Excluded

## Deliverables

## Constraints

## Definitions and terminology

## Success criteria
```

This file should change relatively rarely.

### `STATE.md` — current snapshot

Recommended structure:

```markdown
# Current project state

Last updated: YYYY-MM-DD

## Current phase

## Current status

## Completed

## In progress

## Blocked / waiting

## Current canonical outputs

## Key current conclusions

## Immediate next actions
```

Keep it concise enough to read at the start of a session. Link to detailed files instead of embedding large explanations.

### `TASKS.md` — task registry

Use stable task IDs for non-trivial projects.

```markdown
# Tasks

| ID | Status | Priority | Task | Depends on | Output / evidence |
|---|---|---|---|---|---|
| T-001 | active | high | ... | — | ... |
| T-002 | todo | medium | ... | T-001 | ... |
```

Suggested statuses: `todo`, `active`, `blocked`, `done`, `cancelled`.

Do not use `TASKS.md` as a narrative project diary.

### `ASSUMPTIONS.md` — uncertainty register

For engineering, scientific, cost-estimation, research, planning, and analytical projects, this file is strongly recommended.

```markdown
# Assumptions

| ID | Assumption | Status | Confidence | Impact | Validation / evidence |
|---|---|---|---|---|---|
| A-001 | ... | provisional | medium | high | ... |
```

Useful statuses include `provisional`, `accepted`, `validated`, `rejected`, `superseded`, and `needs-validation`.

### `SOURCES.md` — source and artifact registry

Register important authoritative information and artifacts. For each source, record when useful:

- source ID;
- title/name;
- type;
- canonical location/path/URL/ID;
- whether it is canonical;
- origin/provenance;
- purpose;
- modification restrictions;
- relevant version/date.

The scenario file defines how locations should be represented for that storage environment.

## 7. Decisions

Use one decision record per significant decision when future agents may need to understand **why** it was made.

Default location:

```text
docs/decisions/
```

Recommended naming:

```text
0001-select-analysis-method.md
0002-change-test-geometry.md
0003-use-local-project-memory.md
```

Recommended format:

```markdown
# 0001 — Decision title

Status: Accepted
Date: YYYY-MM-DD

## Context

## Decision

## Alternatives considered

## Consequences
```

When a decision changes, normally create a new decision record and mark the old one `Superseded` rather than rewriting history.

## 8. Plans for complex work

For a small task, `TASKS.md` is enough.

For work spanning a long agent run, multiple sessions, or multiple agents, create a plan under:

```text
docs/plans/active/
```

A plan should contain:

- objective;
- inputs;
- expected outputs;
- steps/workstreams;
- dependencies;
- validation criteria;
- open questions.

When complete, move it to:

```text
docs/plans/completed/
```

Reference the active plan from `STATE.md` or `TASKS.md` instead of duplicating it there.

## 9. End-of-session synchronization

Before ending substantial work, the active agent should:

1. Update `STATE.md` if the current project state changed.
2. Update `TASKS.md` for completed, active, blocked, cancelled, or newly discovered work.
3. Update `ASSUMPTIONS.md` if assumptions were added, validated, rejected, superseded, or changed.
4. Update `SOURCES.md` if authoritative artifacts or canonical locations changed.
5. Record a decision in `docs/decisions/` when a significant choice was made and its rationale may matter later.
6. Leave the project in a state where a new agent can continue without reading the previous chat.

## 10. Tool-specific adapters

The canonical project memory must remain tool-agnostic.

If a tool requires a special entry file or workspace instruction, use a thin adapter rather than duplicating project state.

### Claude Code

When useful, create `CLAUDE.md` containing:

```markdown
@AGENTS.md
```

Add Claude-specific instructions only when truly necessary.

### Codex

Use the root `AGENTS.md` directly. Add nested `AGENTS.md` files only when a subdirectory needs materially different rules.

### ChatGPT Work / Cowork / other project agents

Configure workspace/project instructions to read the root `AGENTS.md` before substantial work when the product does not automatically discover it.

Do not maintain separate full copies of project state inside product-specific instructions.

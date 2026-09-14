# Project Infrastructure Standard

**Status:** Working standard  
**Purpose:** Provide a reusable, tool-agnostic project-memory and handoff structure so a new ChatGPT chat/Work session, Codex task, Claude Code session, Cowork project, or another capable agent can recover project context from files instead of relying on previous chat history.

This document defines the common project infrastructure and scenario-specific setup rules. Use the relevant scenario when initializing a new project.

> Core principle: **project state lives in project files, not in chat history.** Chat history may be useful context, but it is not the canonical source of truth.

---

## 1. Common principles

### 1.1 Canonical project memory

A project should expose a small set of stable, human-readable files that answer different questions:

- `PROJECT.md` — What is this project, why does it exist, and what is in/out of scope?
- `STATE.md` — Where is the project **right now**?
- `TASKS.md` — What is done, active, blocked, and next?
- `ASSUMPTIONS.md` — What is assumed, uncertain, provisional, or awaiting validation?
- `SOURCES.md` — Where are authoritative source files, data, external artifacts, and references?
- `AGENTS.md` — How should an AI agent work with this project and which files should it read/update?

These files should not duplicate one another. Each has one primary responsibility.

### 1.2 Current state is not a session log

`STATE.md` is a current snapshot, not a chronological diary.

When information becomes obsolete, replace or remove it from `STATE.md`. Historical context belongs in:

- version history when available;
- `docs/decisions/` for important decisions;
- `docs/plans/completed/` for completed complex plans;
- optional archived notes/logs when they add real value.

### 1.3 Facts, decisions, assumptions, and tasks are different things

Agents should explicitly distinguish:

- **Fact** — supported by project evidence or an authoritative source.
- **Decision** — an explicit choice made for the project.
- **Assumption** — a provisional premise used for analysis or planning.
- **Task** — work that should be performed.

Do not silently turn an assumption into a fact or a proposed action into a decision.

### 1.4 Progressive disclosure

Do not load the whole project into model context by default.

Preferred startup pattern:

`AGENTS.md` → `PROJECT.md` → `STATE.md` → `TASKS.md` → only then open `ASSUMPTIONS.md`, `SOURCES.md`, decisions, plans, source documents, code, data, or outputs as needed for the current task.

This reduces unnecessary context and usage while keeping project continuity.

### 1.5 One canonical copy

For every important artifact, identify one canonical copy. Avoid maintaining multiple competing “latest” files in different folders or services.

If another copy exists for transport, conversion, review, or local processing, treat it as temporary or derived and point back to the canonical artifact in `SOURCES.md`.

### 1.6 End-of-session synchronization

Before ending a substantial work session, the active agent should:

1. Update `STATE.md` if the current project state changed.
2. Update `TASKS.md` for completed, active, blocked, or newly discovered work.
3. Update `ASSUMPTIONS.md` if assumptions were added, validated, rejected, or changed.
4. Update `SOURCES.md` if authoritative files or locations changed.
5. Record a decision in `docs/decisions/` when a significant choice was made and its rationale may matter later.
6. Leave the project in a state where a new agent can continue without reading the previous chat.

Do not create a separate `HANDOFF.md`, `LATEST_CONTEXT.md`, or `SESSION_SUMMARY.md` unless there is a specific reason. `STATE.md` is the default handoff snapshot.

---

# Scenario L1 — Project stored in a local folder

Use this scenario when the project primarily lives in a normal local filesystem folder and the active agent has direct access to that folder.

Examples:

- a project opened in Claude Code or Codex from `D:\Work\Project-X`;
- a local engineering/research folder exposed to ChatGPT desktop/Work or Cowork;
- a project containing documents, spreadsheets, code, calculations, CAD, and data in one local directory tree;
- a project that is not yet managed as a Git repository.

## 2. Goal of the local-folder scenario

The folder itself is the project workspace and canonical project memory.

A new agent should be able to open the root folder, read a small number of Markdown files, understand the project, locate the relevant artifacts, and continue the work safely.

No GitHub, Google Drive, Yandex Disk, MCP, or connector is required for this scenario.

---

## 3. Default project structure

Create this structure unless the project clearly does not need some optional directories:

```text
Project-X/
│
├── README.md
├── AGENTS.md
├── PROJECT.md
├── STATE.md
├── TASKS.md
├── ASSUMPTIONS.md
├── SOURCES.md
│
├── docs/
│   ├── decisions/
│   ├── plans/
│   │   ├── active/
│   │   └── completed/
│   ├── research/
│   └── methodology/
│
├── data/
├── calculations/
├── src/
└── outputs/
```

Directories such as `data/`, `calculations/`, `src/`, and `outputs/` are optional and should reflect the real project rather than being created mechanically when they are unnecessary.

For an engineering/CAD project, additional directories may be appropriate, for example:

```text
cad/
experiments/
references/
reports/
```

Prefer meaningful domain names over forcing every project into a software-development layout.

---

## 4. Root files

### 4.1 `README.md` — human entry point

Keep this short. It should contain:

- project name;
- one-paragraph purpose;
- basic folder overview;
- pointer to `AGENTS.md` for AI-assisted work;
- any essential human setup/opening instructions.

Do not duplicate detailed project state here.

### 4.2 `AGENTS.md` — AI entry point

This is the main agent-facing instruction file.

Default content should include:

```markdown
# Agent instructions

## Startup

Before substantive work, read in this order:

1. `PROJECT.md`
2. `STATE.md`
3. `TASKS.md`
4. `ASSUMPTIONS.md` when the task involves estimates, uncertain facts, design choices, or analysis
5. `SOURCES.md` before locating or editing source artifacts

Do not treat previous chat history as the authoritative project state.

## Working rules

- Prefer project files over remembered chat context when they conflict.
- Read only the files needed for the current task; do not load the whole project without reason.
- Preserve canonical source files unless the task explicitly requires changing them.
- Distinguish facts, decisions, assumptions, recommendations, and tasks.
- For large or complex source files, inspect or process them with appropriate tools rather than placing their full contents into model context unnecessarily.
- Keep temporary/intermediate files separate from canonical outputs.

## Before finishing substantial work

- Update `STATE.md` if project state changed.
- Update `TASKS.md`.
- Update `ASSUMPTIONS.md` and `SOURCES.md` when relevant.
- Record significant decisions under `docs/decisions/`.
- Make sure a new agent can continue without the previous chat.
```

Project-specific instructions should be added below these common rules.

Do not turn `AGENTS.md` into a full project encyclopedia. Its job is to route the agent to the correct sources of truth.

### 4.3 `PROJECT.md` — stable project definition

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

### 4.4 `STATE.md` — current snapshot

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

Rules:

- describe the present, not the full history;
- keep it concise enough to read at the start of a session;
- link or reference detailed files instead of embedding large explanations;
- remove stale state when it stops being current.

### 4.5 `TASKS.md` — task registry

Use stable task IDs when the project is more than trivial.

Recommended format:

```markdown
# Tasks

| ID | Status | Priority | Task | Depends on | Output / evidence |
|---|---|---|---|---|---|
| T-001 | active | high | ... | — | ... |
| T-002 | todo | medium | ... | T-001 | ... |
```

Suggested statuses:

- `todo`
- `active`
- `blocked`
- `done`
- `cancelled`

Do not use `TASKS.md` as a narrative project diary.

### 4.6 `ASSUMPTIONS.md` — uncertainty register

For engineering, scientific, cost-estimation, research, planning, and analytical projects, this file is strongly recommended.

Recommended format:

```markdown
# Assumptions

| ID | Assumption | Status | Confidence | Impact | Validation / evidence |
|---|---|---|---|---|---|
| A-001 | ... | provisional | medium | high | ... |
```

Useful statuses include:

- `provisional`
- `accepted`
- `validated`
- `rejected`
- `superseded`
- `needs-validation`

### 4.7 `SOURCES.md` — source and artifact registry

For a local-folder project, this primarily maps authoritative information to relative project paths.

Example:

```markdown
# Sources and canonical artifacts

## S-001 — Final grant application

Type: authoritative document  
Path: `references/grant_application_final.docx`  
Canonical: yes

Purpose: contractual baseline for reporting.

## S-002 — Main experimental dataset

Type: raw data  
Path: `data/experiment_2026-09.csv`  
Canonical: yes

Do not modify. Derived/cleaned data belongs under `data/processed/`.
```

Prefer relative paths so the whole project folder remains portable between computers.

For each important source, record when useful:

- source ID;
- title/name;
- type;
- relative path;
- whether it is canonical;
- origin/provenance;
- purpose;
- modification restrictions;
- relevant version/date.

---

## 5. Decisions

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

---

## 6. Plans for complex work

For a small task, `TASKS.md` is enough.

For a multi-step task that will span a long agent run, multiple sessions, or multiple agents, create a plan under:

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

The current plan may be referenced from `STATE.md` and `TASKS.md` rather than copied into them.

---

## 7. Working with local files

### 7.1 Direct local access is preferred

When the agent can access the project folder directly, prefer filesystem operations for project files rather than routing the same local file through an external connector or cloud service.

Use targeted operations such as:

- directory listing;
- filename/content search;
- bounded reads;
- appropriate document/spreadsheet/data tools;
- local scripts for data reduction and analysis.

Do not place an entire large dataset or document into LLM context when a tool can extract the required subset, statistics, or structure first.

### 7.2 Temporary and derived files

Avoid mixing temporary files with authoritative artifacts.

Use a temporary workspace or clearly marked directory when substantial intermediate outputs are expected, for example:

```text
.work/
tmp/
outputs/drafts/
```

Do not make temporary files canonical merely because they are newest.

### 7.3 Raw data

Treat raw experimental/source data as immutable by default.

Recommended pattern:

```text
data/raw/
data/processed/
```

Record transformations in code, notebooks, methodology notes, or task evidence where practical.

### 7.4 Large binary or linked files

For CAD, large Office files, images, archives, and other binary artifacts:

- keep them as normal project files when the local project is the canonical location;
- record important ones in `SOURCES.md`;
- avoid unnecessary format conversion;
- preserve linked/dependent file structures;
- use application-native mechanisms such as SolidWorks `Pack and Go` when moving a linked assembly is safer than copying individual files.

---

## 8. Tool-specific adapters

The common project memory must remain tool-agnostic.

If a tool requires a special entry file, create only a thin adapter rather than duplicating project rules.

### Claude Code

When useful, create `CLAUDE.md` containing:

```markdown
@AGENTS.md
```

Add Claude-specific instructions only when truly necessary.

### Codex

Use the root `AGENTS.md` directly. Add nested `AGENTS.md` files only when a subdirectory needs materially different rules.

### ChatGPT Work / Cowork / other project agents

Configure the project/workspace instructions to read the root `AGENTS.md` before substantial work when the product does not automatically discover it.

Do not maintain separate full copies of project state inside product-specific instructions.

---

## 9. Bootstrap procedure for a new local project

When asked to initialize project infrastructure using **Scenario L1**, an agent should:

1. Inspect the existing folder without deleting or moving user files unnecessarily.
2. Identify the project's likely purpose and existing artifact structure.
3. Create the core project-memory files:
   - `README.md`
   - `AGENTS.md`
   - `PROJECT.md`
   - `STATE.md`
   - `TASKS.md`
   - `ASSUMPTIONS.md`
   - `SOURCES.md`
4. Create `docs/decisions/` and `docs/plans/{active,completed}/` when the project is substantial enough to benefit from them.
5. Create additional domain directories only when justified by actual project content.
6. Populate the files from existing project evidence rather than inventing missing facts.
7. Mark unresolved information explicitly as unknown, assumption, or task.
8. Register important existing artifacts in `SOURCES.md` using relative paths.
9. Summarize the actual current state in `STATE.md`.
10. Build an initial `TASKS.md` from clearly supported next actions.
11. Verify that a fresh agent can understand the project by reading the startup sequence without needing the originating chat.

If important context is unavailable, initialize the structure with explicit gaps rather than guessing.

---

## 10. Invocation pattern

For a new local-folder project, the user should be able to give an agent a concise instruction such as:

> Read `PROJECT_INFRASTRUCTURE_STANDARD.md`, apply **Scenario L1 — Project stored in a local folder** to this project, inspect the existing files, create the project-memory infrastructure, and populate it from evidence already present in the folder. Do not invent missing project facts.

For an existing initialized project:

> Read `AGENTS.md`, restore the current project context, and continue task `T-XXX`.

---

## 11. Scenario status

Implemented in this standard:

- **L1 — Project stored in a local folder**

Planned future scenarios:

- GitHub repository as canonical code/text/project-state store, with documents and large artifacts in Google Drive;
- GitHub plus Yandex Disk / local synchronized Yandex folder;
- cloud/remote agent with no direct access to the user's local filesystem;
- hybrid multi-agent project with local workspace materialization and publish-back rules.

Future scenarios should reuse the common project-memory model defined above rather than creating incompatible parallel standards.

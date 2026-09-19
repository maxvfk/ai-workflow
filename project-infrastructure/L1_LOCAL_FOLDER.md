# Scenario L1 — Local Folder

**Status:** Draft  
**Depends on:** [`COMMON.md`](COMMON.md)  
**Standard version:** inherit from [`../PROJECT_INFRASTRUCTURE.md`](../PROJECT_INFRASTRUCTURE.md)

Use this scenario when the project primarily lives in a normal local filesystem folder and the active agent has direct access to it.

`Draft` means L1 is structurally implemented but has not yet completed representative real-project pilots. It should move to `Pilot` only after successful use on one or more real brownfield projects and review of the resulting project runtime.

## Goal

The local folder is the working environment and default canonical location for project memory. A new agent should be able to read the local runtime/project-memory files, understand the existing folder structure, locate relevant artifacts, and continue without previous chat history or external-standard access.

The external project-infrastructure standard is required only for initialization, validation, repair, or migration. **Normal L1 work must remain possible with the local project folder alone.**

## Bootstrap source

Bootstrap access and offline/private-repository handling are defined once in `PROJECT_INFRASTRUCTURE.md`. L1 adds no separate access semantics. After bootstrap, the local installed runtime remains self-contained as described below.

## Self-contained L1 runtime

For ordinary work:

- `AGENTS.md` is the runtime entry point;
- installed root project-memory files are the current project source of truth;
- L1-specific runtime rules are materialized into `AGENTS.md` during bootstrap/migration;
- GitHub and external bootstrap copies are not required;
- the local infrastructure snapshot is for audit, repair, or migration only and is not part of normal startup.

## Brownfield-first rule

Most L1 projects are expected to be **existing user-maintained folders**, not empty folders created for an agent.

Default behavior:

> **Adapt the infrastructure to the existing folder. Do not reorganize the user's files to match a generic template.**

During initialization, do not move, rename, regroup, convert, or otherwise reorganize existing user files/directories unless explicitly requested.

This is especially important for linked Office files, CAD assemblies/dependent parts, scripts using relative paths, established report/experiment/reference structures, and files used by external applications/collaborators.

If the structure is inconvenient, document the issue and propose a reorganization separately rather than performing one silently.

## Project-memory profile and L1 layout

Profile and language selection follow `COMMON.md`; L1 adds only the local layout below.

A simple L1 installation may be only:

```text
Existing-Project/
├── [existing user structure]
├── AGENTS.md
├── STATE.md
├── TASKS.md
└── _ai/
    └── infrastructure/
        ├── MANIFEST.md
        └── standard/
            ├── COMMON.md
            └── L1_LOCAL_FOLDER.md
```

Add `PROJECT.md`, `SOURCES.md`, `ASSUMPTIONS.md`, `README.md`, plans, decisions, research, archives, work areas, or generated-output areas only when they have a real role.

For a substantial brownfield project, a typical structure is:

```text
Existing-Project/
├── [existing user folders and files — keep in place]
│
├── README.md            # optional/preserve if present
├── AGENTS.md
├── PROJECT.md           # when stable scope/constraints need their own file
├── STATE.md
├── TASKS.md
├── ASSUMPTIONS.md       # when uncertainty/validation matters
├── SOURCES.md           # when canonical source tracking matters
│
└── _ai/
    ├── infrastructure/
    │   ├── MANIFEST.md
    │   └── standard/
    │       ├── COMMON.md
    │       └── L1_LOCAL_FOLDER.md
    ├── plans/
    │   ├── active/
    │   └── completed/
    ├── decisions/
    ├── research/
    ├── archive/
    │   └── tasks/
    ├── work/
    └── generated/
```

The root Markdown files are visible entry points. `_ai/` is an agent-owned support namespace, not a destination for relocating user-owned artifacts.

### Why `_ai/` rather than `.ai/`

New L1 installations use `_ai/` so the support namespace remains visibly discoverable in ordinary file managers and in tools that skip hidden directories by default.

Projects installed under older draft versions may already use `.ai/`. **Routine work must continue using the installed path recorded in `AGENTS.md`/`MANIFEST.md`; never rename it silently.** During explicit migration, rename `.ai/` to `_ai/` only when it is clearly infrastructure-owned, the target path does not conflict, dependencies have been checked, and all runtime references can be updated atomically. Otherwise preserve the existing namespace.

### `_ai/` roles

Create only subdirectories actually needed:

- `_ai/infrastructure/` — installed infrastructure metadata and standard snapshot; required by L1 bootstrap;
- `_ai/plans/` — `P-###` plans;
- `_ai/decisions/` — `D-###` decision records;
- `_ai/research/` — intermediate research/evidence syntheses;
- `_ai/archive/tasks/` — archived completed/cancelled task records;
- `_ai/work/` — temporary/disposable work files;
- `_ai/generated/` — generated deliverables not yet reviewed/promoted.

For L1, decision and plan locations are `_ai/decisions/` and `_ai/plans/` for new installations.

## Infrastructure manifest and local snapshot

During bootstrap or explicit migration, create/update:

```text
_ai/infrastructure/MANIFEST.md
_ai/infrastructure/standard/COMMON.md
_ai/infrastructure/standard/L1_LOCAL_FOLDER.md
```

The two files under `standard/` should be exact local copies of the applied common and L1 instructions whenever the bootstrap agent can retrieve them.

`MANIFEST.md` should record, when known:

```markdown
# Project infrastructure manifest

Scenario: L1
Project-memory profile: Minimal | Standard
Project-memory language: ru
Agent namespace: _ai/
Standard source: maxvfk/ai-workflow or local bootstrap bundle
Standard version: <installed version>
Standard lifecycle: <Draft/Pilot/Stable>
Standard commit/ref: <exact commit/ref when known>
Initialized: YYYY-MM-DD
Last infrastructure update: YYYY-MM-DD
Runtime entry point: ../../AGENTS.md
Local standard snapshot: ./standard/
```

Use another language code instead of `ru` only when the project has another explicitly selected/established project-memory language. If version/commit cannot be established, record `unknown` rather than guessing.

### L1 snapshot/authority additions

Use the versioning, migration, preservation, and authority rules from `COMMON.md` and `PROJECT_INFRASTRUCTURE.md`.

L1-specific points:

- ordinary work uses the local canonical `AGENTS.md` plus installed project-memory files;
- the local `_ai/infrastructure/standard/` snapshot is audit/repair/migration evidence, not normal runtime input;
- explicit migration compares the installed manifest/snapshot with the selected target standard before changing infrastructure;
- the snapshot never becomes a second copy of current project state.

## L1 runtime additions to canonical `AGENTS.md`

In addition to the common runtime baseline in `COMMON.md`, L1 must materialize:

- `Scenario: L1`;
- installed agent namespace and infrastructure-manifest path;
- normal work is fully local and does not require the external standard repository;
- preserve the user's existing folder structure; do not move/rename/regroup/convert user-owned files merely to fit infrastructure;
- temporary/intermediate files use the installed L1 work path when needed;
- unreviewed generated deliverables use the installed generated-output path when needed;
- accepted generated artifacts are promoted into the user's normal structure only when their durable location is clear;
- L1 decisions/plans use the installed scenario-defined locations (normally `_ai/decisions/` and `_ai/plans/` for new installs).

If canonical `AGENTS.md` already contains user/project-authored material, maintain these infrastructure additions only inside the mandatory managed block defined by `COMMON.md`.

## Existing-infrastructure detection

Safe reapplication behavior is defined in `COMMON.md`.

For L1, treat the folder as already initialized when evidence such as the following is present:

- scenario/infrastructure metadata in `AGENTS.md`;
- `_ai/infrastructure/MANIFEST.md` or legacy `.ai/infrastructure/MANIFEST.md`;
- an installed standard snapshot;
- populated project-memory files.

Then reconcile/repair/migrate rather than bootstrap from scratch. Preserve the installed namespace (`_ai/` or legacy `.ai/`) unless an explicit migration safely changes it.

## L1 brownfield discovery additions

Use the common bounded-discovery/source-registration process from `COMMON.md`.

For L1 specifically:

- inventory the existing local folder without reorganizing it;
- treat linked Office documents, CAD assemblies/dependencies, scripts with relative paths, and application-specific project bundles as dependency-sensitive;
- prefer application entry points (for example the main assembly/project/workbook) over reading every dependent file;
- use relative local paths for registered artifacts when they are inside the project root.

Do not recursively ingest archives, backups, dependency trees, caches, or generated outputs merely because filesystem access makes that possible.

## Ownership and promotion rules

Treat files as:

1. **User-owned existing artifacts** — preserve paths/names unless explicitly asked to reorganize.
2. **Project-memory files** — root Markdown files maintained collaboratively.
3. **Agent-generated support/output files** — keep under the installed agent namespace until they have a clear long-term role.

A generated file does not become canonical merely because it is newer.

Example for a new installation:

```text
_ai/generated/report_draft.docx
        ↓ reviewed / accepted
Отчеты/Отчет_2026.docx
```

After promotion, the normal user-structure copy is canonical; remove or clearly mark the generated copy as non-canonical.

## Greenfield exception

If the folder is genuinely new or the user explicitly requests a new structure, create only domain-appropriate directories actually useful for the project.

Start with Minimal project-memory profile unless known complexity justifies Standard immediately. Use Russian project memory by default unless the user explicitly selects another language.

## Source locations

For artifacts inside the project, prefer relative paths in `SOURCES.md`.

There is no requirement to rename/move an artifact into a standardized directory merely to register it.

Use absolute paths only when an important dependency necessarily lives outside the project folder and document that dependency.

## L1 task-archive location

Task lifecycle/archiving follows `COMMON.md`. For new L1 installations, older `done`/`cancelled` task records that need durable archival go under:

```text
_ai/archive/tasks/YYYY.md
```

Use the installed legacy namespace when applicable; preserve original `T-###` IDs.

## L1 local-work additions

In addition to `COMMON.md`:

- prefer direct filesystem operations for canonical local artifacts when safe;
- use the installed L1 work/generated paths only when the task actually needs temporary or unreviewed output areas;
- preserve linked/dependent CAD and application structures;
- treat raw source/experimental data as immutable by default unless the project explicitly says otherwise;
- do not load the installed infrastructure snapshot during routine work.

## Git and `.gitignore`

Git is optional in L1. Do not initialize Git merely because L1 is being applied.

If the project is already a Git repository:

- read/preserve existing `.gitignore`;
- ignore `_ai/work/` by default for new installations;
- normally ignore `_ai/generated/` unless drafts are intentionally versioned/reviewed through Git;
- do **not** ignore `_ai/infrastructure/`, `_ai/plans/`, `_ai/decisions/`, `_ai/research/`, or `_ai/archive/` merely because they are agent-owned;
- use a small identifiable managed block when adding ignore rules;
- for legacy `.ai/` installations, use paths matching the installed namespace.

Example:

```gitignore
# project-infrastructure:start
_ai/work/
_ai/generated/
# project-infrastructure:end
```

If generated artifacts are intentionally tracked, omit `_ai/generated/`.

If GitHub later becomes canonical project storage, reassess against a GitHub-based scenario.



## L1 cold-start additions

Apply the common cold-start validation from `COMMON.md` using **local files only**.

In addition to the common checks, a fresh L1 agent must be able to determine:

- the installed agent namespace and infrastructure-manifest location;
- that user-owned structure must not be reorganized implicitly;
- where temporary work and unreviewed generated outputs belong when those areas are installed;
- that ordinary work does not require the external standard repository.

If any of these require hidden bootstrap-chat knowledge, L1 installation is incomplete.

## L1 bootstrap/reconcile additions

Follow the common bootstrap/reconcile flow from `COMMON.md`.

L1-specific additions by classification:

**Already initialized**
- use local `AGENTS.md`, manifest, installed snapshot, and only needed project memory as installed-state evidence;
- preserve the installed `_ai/` or legacy `.ai/` namespace during ordinary work;
- migrate legacy `.ai/` only through the explicit safe namespace-migration rule above.

**Uninitialized brownfield**
- the existing folder itself is the canonical project root;
- create `_ai/infrastructure/` and only the additional `_ai/` subdirectories actually needed;
- preserve all existing user paths and linked/dependent structures;
- if Git already exists, apply L1 `.gitignore` additions non-destructively when relevant.

**Greenfield**
- start with Minimal memory unless known complexity justifies Standard;
- create only useful project/domain directories; do not invent a generic user-file hierarchy;
- apply Git rules only when Git already exists or Git setup is independently requested.

All classifications finish with the L1 cold-start additions above.

## L1 completion-report additions

For L1 infrastructure work, add to the common handoff only what is locally relevant:

- classification: initialized / brownfield / greenfield;
- installed agent namespace and any legacy namespace preserved;
- project-memory/`_ai/` files created or updated;
- existing user structure deliberately preserved;
- structural issues intentionally left unchanged;
- confirmation that ordinary future work is self-contained in the local folder.

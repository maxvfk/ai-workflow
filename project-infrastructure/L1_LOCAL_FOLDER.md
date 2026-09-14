# Scenario L1 — Local Folder

**Status:** Draft  
**Depends on:** [`COMMON.md`](COMMON.md)  
**Standard version:** inherit from [`../PROJECT_INFRASTRUCTURE.md`](../PROJECT_INFRASTRUCTURE.md)

Use this scenario when the project primarily lives in a normal local filesystem folder and the active agent has direct access to it.

`Draft` means L1 is structurally implemented but has not yet completed representative real-project pilots. It should move to `Pilot` only after successful use on one or more real brownfield projects and review of the resulting project runtime.

## Goal

The local folder is the working environment and default canonical location for project memory. A new agent should be able to read the local runtime/project-memory files, understand the existing folder structure, locate relevant artifacts, and continue without previous chat history or external-standard access.

The external project-infrastructure standard is required only for initialization, validation, repair, or migration. **Normal L1 work must remain possible with the local project folder alone.**

## Bootstrap access modes

L1 supports two equivalent bootstrap modes.

### Authorized repository access

If the agent can access the private `maxvfk/ai-workflow` repository, it should start from `PROJECT_INFRASTRUCTURE.md`, then read `COMMON.md` and this scenario.

### Local/offline bootstrap bundle

If the agent cannot access the private repository, the user may provide local copies of:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/L1_LOCAL_FOLDER.md`.

Treat those supplied files as the bootstrap specification. Record whatever version and commit/ref information is available. Do not invent missing provenance.

After successful bootstrap, both access modes produce the same self-contained local runtime.

## Self-contained L1 runtime

For ordinary work:

- `AGENTS.md` is the runtime entry point;
- root project-memory files are the current project source of truth;
- L1-specific runtime rules are materialized into `AGENTS.md` during bootstrap/migration;
- GitHub and the external bootstrap copies are not required;
- the local infrastructure snapshot is for audit, repair, or migration only and is not part of normal startup.

## Brownfield-first rule

Most L1 projects are expected to be **existing user-maintained folders**, not empty folders created for an agent.

Default behavior:

> **Adapt the infrastructure to the existing folder. Do not reorganize the user's files to match a generic template.**

During initialization, do not move, rename, regroup, convert, or otherwise reorganize existing user files/directories unless explicitly requested.

This is especially important for linked Office files, CAD assemblies and dependent parts, scripts using relative paths, established report/experiment/reference structures, and files used by external applications or collaborators.

If the structure is inconvenient, document the issue and propose a reorganization separately rather than performing one silently.

## Recommended brownfield structure

```text
Existing-Project/
├── [existing user folders and files — keep in place]
│
├── README.md
├── AGENTS.md
├── PROJECT.md
├── STATE.md
├── TASKS.md
├── ASSUMPTIONS.md
├── SOURCES.md
│
└── .ai/
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
    ├── work/
    └── generated/
```

The root Markdown files are visible entry points. `.ai/` is an agent-owned support namespace, not a destination for relocating user-owned artifacts.

### `.ai/` roles

- `.ai/infrastructure/` — installed infrastructure metadata and standard snapshot.
- `.ai/plans/` — complex or multi-session plans.
- `.ai/decisions/` — decision records.
- `.ai/research/` — intermediate research notes/evidence syntheses.
- `.ai/work/` — temporary/disposable work files.
- `.ai/generated/` — generated deliverables not yet reviewed/promoted.

For L1, decision and plan locations are `.ai/decisions/` and `.ai/plans/`. Generic common rules must not introduce competing `docs/decisions/` or `docs/plans/` conventions.

## Infrastructure manifest and local snapshot

During bootstrap or explicit migration, create/update:

```text
.ai/infrastructure/MANIFEST.md
.ai/infrastructure/standard/COMMON.md
.ai/infrastructure/standard/L1_LOCAL_FOLDER.md
```

The two files under `standard/` should be exact local copies of the applied common and L1 instructions whenever the bootstrap agent can retrieve them.

`MANIFEST.md` should record, when known:

```markdown
# Project infrastructure manifest

Scenario: L1
Standard source: maxvfk/ai-workflow or local bootstrap bundle
Standard version: <installed version>
Standard lifecycle: <Draft/Pilot/Stable>
Standard commit/ref: <exact commit/ref when known>
Initialized: YYYY-MM-DD
Last infrastructure update: YYYY-MM-DD
Runtime entry point: ../../AGENTS.md
Local standard snapshot: ./standard/
```

If version/commit cannot be established, record `unknown` rather than guessing.

### Version behavior

A project stays on its **installed** infrastructure version until the user explicitly requests validation, repair, or migration/upgrade. Do not silently re-bootstrap or change behavior merely because `main` has changed.

For migration:

1. read the local manifest and installed snapshot;
2. read the explicitly selected target standard;
3. compare installed vs target rules;
4. migrate non-destructively;
5. preserve project-specific rules/state/IDs/user-owned content;
6. only then update manifest and local snapshot.

## Authority rules

For normal work:

1. `AGENTS.md` defines installed runtime behavior.
2. Current project-memory files define current project state.
3. The local standard snapshot is not loaded unless infrastructure work requires it.

For infrastructure repair/migration:

1. local manifest/snapshot describes the previously installed specification;
2. the explicitly selected external/local target standard defines the target specification;
3. user/project-specific content must be preserved unless explicitly migrated.

The snapshot is never a second copy of current project state.

## Required L1 runtime rules in `AGENTS.md`

During bootstrap/migration, `AGENTS.md` must contain a concise infrastructure-managed L1 runtime section with at least:

- `Scenario: L1`;
- installed standard version and commit/ref when known;
- path to `.ai/infrastructure/MANIFEST.md`;
- normal work does not require GitHub or the standard snapshot;
- preserve the user's existing structure unless explicitly asked to reorganize it;
- do not move/rename/regroup/convert user-owned files merely to fit infrastructure;
- temporary/intermediate files belong under `.ai/work/` where practical;
- unreviewed generated deliverables belong under `.ai/generated/`;
- accepted generated artifacts are promoted into the user's normal structure only when their long-term location is clear, with `SOURCES.md`/`STATE.md` updated as appropriate;
- decisions/plans use `.ai/decisions/` and `.ai/plans/`;
- secrets/credentials are never stored in project-memory/infrastructure text files;
- immediately before writing shared project-memory/runtime files, re-read them and reconcile concurrent changes;
- avoid simultaneous modification of the same task/canonical artifact by multiple agents unless explicitly coordinated;
- the project must remain continuable without previous chat history or external-standard access.

When `AGENTS.md` already exists, preserve project-specific/user-authored content and update only a clearly identifiable infrastructure-managed block when practical.

## Existing infrastructure and safe reapplication

Before treating a non-empty folder as first-time brownfield bootstrap, check for:

- scenario/infrastructure metadata in `AGENTS.md`;
- `.ai/infrastructure/MANIFEST.md`;
- an existing local standard snapshot;
- populated project-memory files.

If L1 is already installed, **do not bootstrap from scratch**. Treat the operation as reconcile/repair/migration according to `COMMON.md`.

On reapplication:

- read existing project-memory/instruction files before modifying them;
- preserve user-authored/project-specific content;
- preserve current task/source/assumption IDs and decision history;
- update only missing/obsolete infrastructure-managed rules/metadata;
- refresh the manifest/snapshot only as part of explicit infrastructure work;
- do not reconstruct `STATE.md` or `TASKS.md` unless existing files are unusable and reconstruction is explicitly justified;
- if a safe merge is ambiguous, leave the original intact and put a proposed patch under `.ai/work/`.

Existing `README.md`, `CLAUDE.md`, and other tool-specific files follow the same preservation rule.

## Ownership and promotion rules

Treat files as:

1. **User-owned existing artifacts** — preserve paths/names unless explicitly asked to reorganize.
2. **Project-memory files** — root Markdown files maintained collaboratively.
3. **Agent-generated support/output files** — keep under `.ai/` until they have a clear long-term role.

A generated file does not become canonical merely because it is newer.

Example:

```text
.ai/generated/report_draft.docx
        ↓ reviewed / accepted
Отчеты/Отчет_2026.docx
```

After promotion, the normal user-structure copy is canonical; remove or clearly mark the `.ai/generated/` copy as non-canonical.

## Greenfield exception

If the folder is genuinely new or the user explicitly requests a new structure, create only domain-appropriate directories that are actually useful, for example `data/`, `calculations/`, `src/`, `outputs/`, `cad/`, `experiments/`, `references/`, or `reports/`.

Do not create them mechanically. Keep project-memory files at root and `.ai/` for infrastructure/support material.

## Source locations

For artifacts inside the project, prefer relative paths in `SOURCES.md`.

There is no requirement to rename or move an artifact into a standardized directory merely to register it.

Use absolute paths only when an important dependency necessarily lives outside the project folder and document that dependency.

Do not copy secrets, access tokens, credentials, or unnecessary personal data from source artifacts into `SOURCES.md`.

## Local working rules

- Prefer direct filesystem access when available.
- Use targeted listing/search/bounded reads and appropriate document/data tools instead of loading large files wholesale.
- Do not reorganize user files as part of initialization.
- Use `.ai/work/` for temporary/intermediate agent files where practical.
- Use `.ai/generated/` for unreviewed deliverables.
- Treat raw source/experimental data as immutable by default unless the project says otherwise.
- Register important user artifacts and accepted generated outputs in `SOURCES.md` without requiring relocation.
- Preserve linked/dependent CAD and application structures.
- Do not load `.ai/infrastructure/standard/` during routine work.
- Never use project-memory files as credential storage.

## Concurrent-agent minimum rules

Even in L1, more than one agent may touch the project.

- Before writing `AGENTS.md`, `STATE.md`, `TASKS.md`, `ASSUMPTIONS.md`, `SOURCES.md`, the manifest, or another shared canonical text file, re-read the current version immediately before the write.
- If it changed, reconcile the newer content instead of overwriting it.
- Prefer one active owner per task/canonical artifact at a time.
- Parallel agents should use separate task IDs and `.ai/work/` areas when practical, then deliberately merge results.
- If a conflict cannot be reconciled confidently, preserve both candidate changes under `.ai/work/` and surface the conflict instead of choosing silently.

A later H1 scenario may add stronger coordination/locking rules.

## Git and backup

Git is optional in L1. If enabled, use it where version history is useful for text/code/project-memory, but do not automatically commit large binaries, CAD, generated outputs, or datasets.

If GitHub later becomes canonical project storage, reassess the project against a GitHub-based scenario.

Backup/synchronization is recommended when the local folder is canonical, but backup copies must not become competing canonical copies.

## Bootstrap procedure

First classify the target as:

1. already initialized infrastructure;
2. uninitialized brownfield; or
3. greenfield.

### Already initialized L1

1. Read `AGENTS.md`, local manifest, and only the project-memory needed to understand installed state.
2. Compare installed infrastructure with the explicitly requested target standard.
3. Reconcile/migrate non-destructively.
4. Preserve project-specific instructions and current project state.
5. Refresh infrastructure-managed blocks, manifest, and snapshot only as needed.
6. Verify routine future work remains possible without GitHub.

### Existing project / uninitialized brownfield

1. Read the bootstrap index, `COMMON.md`, and this scenario from either authorized GitHub access or the provided local bundle.
2. Inspect the existing folder and infer its organization without changing it.
3. Identify likely authoritative artifacts and dependency-sensitive structures.
4. Read existing root/instruction files before integrating infrastructure.
5. Create missing project-memory files and safely augment existing ones.
6. Create `.ai/infrastructure/`, its `standard/` snapshot, and only useful additional `.ai/` subdirectories.
7. Save the applied `COMMON.md` and `L1_LOCAL_FOLDER.md`, and create/update `MANIFEST.md` with version/lifecycle/commit/ref when known.
8. Ensure `AGENTS.md` contains the required L1 runtime rules.
9. Populate project memory from existing evidence without inventing missing facts.
10. Register important artifacts using their current relative paths.
11. Do not move/rename files solely to standardize appearance.
12. Summarize current state and supported next actions.
13. Verify a fresh agent with access only to the project folder can continue through `AGENTS.md`.

### New project / greenfield

1. Create only the project-memory files and `.ai/` structure actually needed.
2. Create domain directories only when useful.
3. Preserve any target file that already exists.
4. Record known objectives, constraints, sources, assumptions, and tasks without invention.
5. Install the L1 runtime rules in `AGENTS.md`.
6. Leave the project ready for an offline/local future agent.

## Completion report

After initialization/restructuring/repair/migration, report concisely:

- classification: already initialized / brownfield / greenfield;
- project-memory and `.ai/` files/directories created or updated;
- existing files preserved/merged rather than replaced;
- installed standard version/lifecycle/commit/ref when known;
- main canonical sources;
- reconstructed current state;
- important unknowns/assumptions;
- structural issues noticed but deliberately left unchanged;
- confirmation that normal future work no longer requires GitHub.

## Minimal invocation

With authorized access to the private repository:

> Apply project infrastructure scenario **L1** to this folder using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without repository access, provide the three bootstrap files and use:

> Apply project infrastructure scenario **L1** to this folder using the provided project-infrastructure standard files.

After bootstrap:

> Read `AGENTS.md`, restore the current project context, and continue with my request.

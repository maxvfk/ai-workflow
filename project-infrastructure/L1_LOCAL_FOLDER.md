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

If the agent can access the private `maxvfk/ai-workflow` repository, start from `PROJECT_INFRASTRUCTURE.md`, then read `COMMON.md` and this scenario.

### Local/offline bootstrap bundle

If the agent cannot access the private repository, the user may provide local copies of:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/L1_LOCAL_FOLDER.md`.

Treat those supplied files as the bootstrap specification. Record whatever version/commit/ref information is available. Do not invent missing provenance.

After successful bootstrap, both access modes produce the same self-contained local runtime.

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

## Project-memory profile and language

Use the Minimal/Standard profile rules from `COMMON.md` rather than creating every possible root file automatically.

For new L1 installations, project-memory language defaults to **Russian (`ru`)** unless the user explicitly selects another language.

For an already initialized project:

- preserve its established project-memory language;
- do not translate project-memory files merely because a current deliverable is in another language;
- change the project-memory language only when explicitly requested as an infrastructure/project convention change.

The language of an individual deliverable does not determine the language of the project memory. For example, an English journal manuscript may coexist with Russian `STATE.md`, `TASKS.md`, `PROJECT.md`, and `SOURCES.md`.

Keep infrastructure filenames, record IDs, and controlled status values in their defined English forms even when surrounding prose is Russian.

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

### Version behavior

A project stays on its **installed** infrastructure version until the user explicitly requests validation, repair, or migration/upgrade. Do not silently change behavior because `main` has changed.

For migration:

1. read the local manifest and installed snapshot;
2. read the explicitly selected target standard;
3. compare installed vs target rules;
4. migrate non-destructively;
5. preserve project-specific rules/state/IDs/language/user-owned content unless explicitly changing them;
6. only then update manifest and local snapshot.

## Authority rules

For normal work:

1. `AGENTS.md` defines installed runtime behavior.
2. Current project-memory files define current project state.
3. The local standard snapshot is not loaded unless infrastructure work requires it.

For infrastructure repair/migration:

1. local manifest/snapshot describes the previously installed specification;
2. the explicitly selected external/local target standard defines the target specification;
3. user/project-specific content and installed language must be preserved unless explicitly migrated.

The snapshot is never a second copy of current project state.

## Required L1 runtime rules in `AGENTS.md`

During bootstrap/migration, `AGENTS.md` must contain a concise infrastructure-managed L1 runtime section with at least:

- `Scenario: L1`;
- installed standard version and commit/ref when known;
- installed project-memory profile and actual project-memory files;
- `Project-memory language: ru` (or the explicitly selected/established language code);
- installed agent namespace and path to its infrastructure manifest;
- normal work does not require GitHub or the standard snapshot;
- maintain project-memory prose in the installed project-memory language;
- keep filenames, record IDs, and controlled status values in their defined English forms;
- preserve the user's existing structure unless explicitly asked to reorganize it;
- do not move/rename/regroup/convert user-owned files merely to fit infrastructure;
- temporary/intermediate files belong under the installed agent work path where practical;
- unreviewed generated deliverables belong under the installed generated-output path;
- accepted generated artifacts are promoted into the user's normal structure only when their long-term location is clear, with source/state records updated as appropriate;
- decisions/plans use scenario-defined locations;
- secrets/credentials are never stored in project-memory/infrastructure text files;
- immediately before writing shared project-memory/runtime files, re-read them and reconcile concurrent changes;
- avoid simultaneous modification of the same task/canonical artifact by multiple agents unless coordinated;
- the project must remain continuable without previous chat history or external-standard access.

When `AGENTS.md` already exists, preserve project-specific/user-authored content and update only a clearly identifiable infrastructure-managed block when practical.

## Existing infrastructure and safe reapplication

Before treating a non-empty folder as first-time brownfield bootstrap, check for:

- scenario/infrastructure metadata in `AGENTS.md`;
- `_ai/infrastructure/MANIFEST.md` or legacy `.ai/infrastructure/MANIFEST.md`;
- an existing local standard snapshot;
- populated project-memory files.

If L1 is already installed, **do not bootstrap from scratch**. Treat the operation as reconcile/repair/migration according to `COMMON.md`.

On reapplication:

- read existing project-memory/instruction files before modifying them;
- preserve user-authored/project-specific content;
- preserve current task/source/assumption/decision/plan IDs;
- preserve the established project-memory language unless explicitly changing it;
- update only missing/obsolete infrastructure-managed rules/metadata;
- refresh manifest/snapshot only as part of explicit infrastructure work;
- do not reconstruct `STATE.md` or `TASKS.md` unless existing files are unusable and reconstruction is explicitly justified;
- if a safe merge is ambiguous, leave the original intact and put a proposed patch under the installed agent work path.

Existing `README.md`, `CLAUDE.md`, and other tool-specific files follow the same preservation rule.

## Bounded brownfield inspection

Initialization should discover enough to reconstruct project context without recursively reading the whole folder.

### Stage 1 — inventory, not content ingestion

Start with directory/file metadata:

- inspect the root and normally no more than **2 directory levels** below it;
- extend to depth 3 or a specific deeper branch only when necessary;
- collect useful metadata such as names, types/extensions, approximate sizes, and obvious project/instruction files;
- identify very large directories, archives, dependency trees, caches, generated outputs, backups, and application-specific bundles without opening every contained file;
- skip known cache/dependency/generated directories during the first pass unless clearly relevant.

The depth value is a default discovery bound, not a prohibition on later targeted inspection.

### Stage 2 — identify high-value candidates

Prioritize artifacts likely to establish objective, current state, authority, dependencies, or deliverables, for example:

- existing README/instructions/notes/manifests/reports/specifications/final or approved documents;
- obvious entry-point CAD assemblies/projects, spreadsheets/workbooks, scripts, notebooks, datasets, or current deliverables;
- files explicitly named by the user or referenced by authoritative artifacts;
- dependency-sensitive entry points rather than every dependent file.

### Stage 3 — targeted reads

Open only high-value candidates needed to build reliable project memory. For large/complex files, use bounded extraction, metadata, application-aware tools, summaries, or targeted sections rather than wholesale context ingestion.

### What belongs in `SOURCES.md`

When `SOURCES.md` exists, register an artifact/logical group when at least one is true:

- it is authoritative/canonical;
- it is an important non-reconstructable input/raw dataset;
- provenance/version matters;
- it is a current major deliverable/output;
- modification restrictions matter;
- it is an external dependency/source needed to reproduce/continue work;
- it is a dependency-sensitive application entry point such as a main CAD assembly/project.

Do not register every ordinary file, cache, generated intermediate, or dependency leaf.

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

Do not copy secrets, access tokens, credentials, or unnecessary personal data from source artifacts into `SOURCES.md`.

## Task maintenance and archive

`TASKS.md` is the active working set. Keep `todo`, `active`, and `blocked` tasks plus recently finished items that still aid continuity.

When older `done`/`cancelled` entries make startup noisy, archive them under:

```text
_ai/archive/tasks/YYYY.md
```

(or the installed legacy namespace for older projects).

Preserve the original `T-###` ID, final status, short task description, completion/cancellation date when known, and useful output/evidence reference. Never recycle archived task IDs.

## Local working rules

- Prefer direct filesystem access when available.
- Use bounded discovery/targeted reads rather than recursive content ingestion.
- Do not reorganize user files as part of initialization.
- Use the installed agent work path for temporary/intermediate files where practical.
- Use the installed generated-output path for unreviewed deliverables.
- Maintain project-memory prose in the installed language; do not switch language because a deliverable switches language.
- Treat raw source/experimental data as immutable by default unless the project says otherwise.
- Register important user artifacts and accepted generated outputs in `SOURCES.md` without requiring relocation.
- Preserve linked/dependent CAD and application structures.
- Do not load the installed infrastructure snapshot during routine work.
- Never use project-memory files as credential storage.

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

## Concurrent-agent minimum rules

Even in L1, more than one agent may touch the project.

- Before writing shared canonical/runtime files, re-read the current version immediately before the write.
- If it changed, reconcile newer content instead of overwriting it.
- Prefer one active owner per task/canonical artifact at a time.
- Parallel agents should use separate `T-###` tasks/work areas when practical, then deliberately merge results.
- If a conflict cannot be reconciled confidently, preserve both candidate changes in the non-canonical work area and surface the conflict.

A later H1 scenario may add stronger coordination/locking rules.

## Cold-start validation for L1

After bootstrap, repair, or migration, validate the installation **from local files only**.

Starting from `AGENTS.md` and without using the originating chat, external standard, or bootstrap copies, a fresh agent/check should be able to identify:

- installed scenario/profile/project-memory language/agent namespace;
- current project phase/status;
- active or nearest next `T-###` tasks;
- key canonical sources/outputs when source tracking is installed;
- the rule not to reorganize user-owned files;
- where temporary work and unreviewed generated outputs belong.

When practical, run this with a genuinely fresh agent/session. Otherwise simulate the cold start using only the installed local runtime. If any answer requires hidden bootstrap knowledge, the installation is incomplete.

## Bootstrap procedure

First classify the target as:

1. already initialized infrastructure;
2. uninitialized brownfield; or
3. greenfield.

### Already initialized L1

1. Read `AGENTS.md`, local manifest, and only project-memory needed to understand installed state.
2. Compare installed infrastructure with the explicitly requested target standard.
3. Reconcile/migrate non-destructively.
4. Preserve project-specific instructions, current state, IDs, and established project-memory language unless explicitly changing it.
5. If migrating a legacy `.ai/` namespace, apply the explicit migration rule above; never rename it during routine work.
6. Refresh infrastructure-managed blocks, manifest, and snapshot only as needed.
7. Perform cold-start validation from the installed local runtime.

### Existing project / uninitialized brownfield

1. Read the bootstrap index, `COMMON.md`, and this scenario from authorized GitHub access or the provided local bundle.
2. Perform bounded brownfield inventory before opening large amounts of content.
3. Determine Minimal vs Standard profile from actual complexity.
4. Determine project-memory language: use an already established project-memory language if clearly present; otherwise default to Russian (`ru`) unless the user explicitly requests another language.
5. Identify high-value authoritative artifacts/dependency-sensitive structures using targeted inspection.
6. Read existing root/instruction files before integrating infrastructure.
7. Create only missing project-memory files justified by the selected profile and safely augment existing ones.
8. Create `_ai/infrastructure/` and its `standard/` snapshot; create other `_ai/` subdirectories only when useful.
9. Save the applied `COMMON.md`/`L1_LOCAL_FOLDER.md`, and create/update `MANIFEST.md` with profile, project-memory language, namespace, version/lifecycle/commit/ref when known.
10. Ensure `AGENTS.md` contains required L1 runtime rules, installed language, and actual installed file list.
11. Populate project memory from evidence without inventing missing facts.
12. Register only important sources using current relative paths.
13. If already a Git repository, apply `.gitignore` rules non-destructively when relevant.
14. Do not move/rename files solely to standardize appearance.
15. Summarize current state/supported next actions.
16. Perform cold-start validation from local files only.

### New project / greenfield

1. Start with Minimal profile unless known complexity justifies Standard.
2. Use Russian (`ru`) project memory unless the user explicitly selects another language.
3. Create `_ai/infrastructure/` and only other agent/domain directories actually needed.
4. Preserve any target file that already exists.
5. Record known objectives, constraints, sources, assumptions, and tasks without invention.
6. Install L1 runtime rules, project-memory language, and actual installed-file list in `AGENTS.md`.
7. Apply Git ignore rules only when Git already exists or Git setup is separately requested.
8. Perform cold-start validation.

## Completion report

After initialization/restructuring/repair/migration, report concisely:

- classification: already initialized / brownfield / greenfield;
- selected project-memory profile;
- installed project-memory language;
- installed agent namespace;
- project-memory and `_ai/` files/directories created or updated;
- existing files preserved/merged rather than replaced;
- installed standard version/lifecycle/commit/ref when known;
- main canonical sources when source tracking is installed;
- reconstructed current state;
- important unknowns/assumptions;
- structural issues noticed but deliberately left unchanged;
- cold-start validation result;
- confirmation that normal future work no longer requires GitHub.

## Minimal invocation

With authorized access to the private repository:

> Apply project infrastructure scenario **L1** to this folder using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without repository access, provide the three bootstrap files and use:

> Apply project infrastructure scenario **L1** to this folder using the provided project-infrastructure standard files.

After bootstrap:

> Read `AGENTS.md`, restore the current project context, and continue with my request.

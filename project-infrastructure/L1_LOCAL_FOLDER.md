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

Treat those supplied files as the bootstrap specification. Record whatever version and commit/ref information is available. Do not invent missing provenance.

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

This is especially important for linked Office files, CAD assemblies and dependent parts, scripts using relative paths, established report/experiment/reference structures, and files used by external applications or collaborators.

If the structure is inconvenient, document the issue and propose a reorganization separately rather than performing one silently.

## Project-memory profile selection

Use the Minimal/Standard rules from `COMMON.md` rather than creating every possible root file automatically.

For a simple project, a valid L1 installation may be only:

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

Add `PROJECT.md`, `SOURCES.md`, `ASSUMPTIONS.md`, `README.md`, plans, decisions, research, archives, work areas, or generated-output areas only when they have a real role. Promote the profile later as complexity grows.

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

Projects installed under older draft versions may already use `.ai/`. **Routine work must continue using the installed path recorded in `AGENTS.md`/`MANIFEST.md`; never rename it silently.** During an explicit infrastructure migration, rename `.ai/` to `_ai/` only when it is clearly infrastructure-owned, the target path does not conflict, dependencies have been checked, and the migration can update all runtime references atomically. Otherwise preserve the existing installed namespace and record it in the manifest.

### `_ai/` roles

Create only the subdirectories actually needed:

- `_ai/infrastructure/` — installed infrastructure metadata and standard snapshot; required by L1 bootstrap;
- `_ai/plans/` — complex or multi-session `P-###` plans;
- `_ai/decisions/` — `D-###` decision records;
- `_ai/research/` — intermediate research notes/evidence syntheses;
- `_ai/archive/tasks/` — archived completed/cancelled task records;
- `_ai/work/` — temporary/disposable work files;
- `_ai/generated/` — generated deliverables not yet reviewed/promoted.

For L1, decision and plan locations are `_ai/decisions/` and `_ai/plans/`. Generic common rules must not introduce competing `docs/decisions/` or `docs/plans/` conventions.

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
- installed project-memory profile and actual project-memory files;
- installed agent namespace and path to its infrastructure manifest;
- normal work does not require GitHub or the standard snapshot;
- preserve the user's existing structure unless explicitly asked to reorganize it;
- do not move/rename/regroup/convert user-owned files merely to fit infrastructure;
- temporary/intermediate files belong under the installed agent work path where practical;
- unreviewed generated deliverables belong under the installed generated-output path;
- accepted generated artifacts are promoted into the user's normal structure only when their long-term location is clear, with source/state records updated as appropriate;
- decisions/plans use the scenario-defined `_ai/` locations for new installations;
- secrets/credentials are never stored in project-memory/infrastructure text files;
- immediately before writing shared project-memory/runtime files, re-read them and reconcile concurrent changes;
- avoid simultaneous modification of the same task/canonical artifact by multiple agents unless explicitly coordinated;
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
- update only missing/obsolete infrastructure-managed rules/metadata;
- refresh the manifest/snapshot only as part of explicit infrastructure work;
- do not reconstruct `STATE.md` or `TASKS.md` unless existing files are unusable and reconstruction is explicitly justified;
- if a safe merge is ambiguous, leave the original intact and put a proposed patch under the installed agent work path.

Existing `README.md`, `CLAUDE.md`, and other tool-specific files follow the same preservation rule.

## Bounded brownfield inspection

Initialization should discover enough to reconstruct project context without recursively reading the whole folder.

### Stage 1 — inventory, not content ingestion

Start with directory/file metadata:

- inspect the root and normally no more than **2 directory levels** below it;
- extend to depth 3 or a specific deeper branch only when the initial structure shows that it is necessary;
- collect useful metadata such as names, types/extensions, approximate sizes, and obvious project/instruction files;
- identify very large directories, archives, dependency trees, caches, generated outputs, backups, and application-specific bundles without opening every contained file;
- skip known cache/dependency/generated directories during the first pass unless they are clearly project-relevant.

The depth value is a default discovery bound, not a prohibition on later targeted inspection.

### Stage 2 — identify high-value candidates

Prioritize artifacts likely to establish objective, current state, authority, dependencies, or deliverables, for example:

- existing `README`, instructions, notes, manifests, reports, specifications, final/approved documents;
- obvious entry-point CAD assemblies/projects, spreadsheets/workbooks, scripts, notebooks, datasets, or current deliverables;
- files explicitly named by the user or referenced by other authoritative artifacts;
- dependency-sensitive entry points rather than every dependent file.

### Stage 3 — targeted reads

Open only the high-value candidates needed to build reliable project memory. For large/complex files, use bounded extraction, metadata, application-aware tools, summaries, or targeted sections rather than wholesale context ingestion.

Expand inspection only when evidence is ambiguous or a required fact cannot otherwise be established.

### What belongs in `SOURCES.md`

When `SOURCES.md` exists, register an artifact or logical group when at least one is true:

- it is authoritative/canonical;
- it is an important non-reconstructable input or raw dataset;
- provenance/version matters;
- it is a current major deliverable/output;
- modification restrictions matter;
- it is an external dependency/source needed to reproduce or continue work;
- it is a dependency-sensitive application entry point such as a main CAD assembly/project.

Do **not** register every ordinary file, cache, generated intermediate, or dependency leaf.

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

If the folder is genuinely new or the user explicitly requests a new structure, create only domain-appropriate directories that are actually useful, for example `data/`, `calculations/`, `src/`, `outputs/`, `cad/`, `experiments/`, `references/`, or `reports/`.

Do not create them mechanically. Start with the Minimal project-memory profile unless the known project requirements justify Standard immediately.

## Source locations

For artifacts inside the project, prefer relative paths in `SOURCES.md`.

There is no requirement to rename or move an artifact into a standardized directory merely to register it.

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
- Use bounded discovery and targeted reads rather than recursive content ingestion.
- Do not reorganize user files as part of initialization.
- Use the installed agent work path for temporary/intermediate files where practical.
- Use the installed generated-output path for unreviewed deliverables.
- Treat raw source/experimental data as immutable by default unless the project says otherwise.
- Register important user artifacts and accepted generated outputs in `SOURCES.md` without requiring relocation.
- Preserve linked/dependent CAD and application structures.
- Do not load the installed infrastructure snapshot during routine work.
- Never use project-memory files as credential storage.

## Git and `.gitignore`

Git is optional in L1. Do not initialize Git merely because L1 is being applied.

If the project is already a Git repository:

- read the existing `.gitignore` before changing it;
- preserve existing entries;
- ignore the temporary work area by default (`_ai/work/` for new installations);
- normally ignore `_ai/generated/` unless generated drafts are intentionally versioned/reviewed through Git;
- do **not** ignore `_ai/infrastructure/`, `_ai/plans/`, `_ai/decisions/`, `_ai/research/`, or `_ai/archive/` merely because they are agent-owned; these may contain durable project knowledge;
- use a small identifiable managed block when adding ignore rules to an existing `.gitignore`;
- for legacy `.ai/` installations, use paths matching the installed namespace instead of adding `_ai/` rules blindly.

Example managed block:

```gitignore
# project-infrastructure:start
_ai/work/
_ai/generated/
# project-infrastructure:end
```

If generated artifacts are intentionally tracked, omit `_ai/generated/` from that block.

If GitHub later becomes canonical project storage, reassess the project against a GitHub-based scenario.

Backup/synchronization is recommended when the local folder is canonical, but backup copies must not become competing canonical copies.

## Concurrent-agent minimum rules

Even in L1, more than one agent may touch the project.

- Before writing shared canonical/runtime files, re-read the current version immediately before the write.
- If it changed, reconcile the newer content instead of overwriting it.
- Prefer one active owner per task/canonical artifact at a time.
- Parallel agents should use separate `T-###` tasks and separate work areas when practical, then deliberately merge results.
- If a conflict cannot be reconciled confidently, preserve both candidate changes in the non-canonical work area and surface the conflict instead of choosing silently.

A later H1 scenario may add stronger coordination/locking rules.

## Cold-start validation for L1

After bootstrap, repair, or migration, validate the installation **from local files only**.

Starting from `AGENTS.md` and without using the originating chat, GitHub standard, or bootstrap copies, a fresh agent/check should be able to identify:

- installed scenario/profile/agent namespace;
- current project phase/status;
- active or nearest next `T-###` tasks;
- key canonical sources/outputs when source tracking is installed;
- the rule not to reorganize user-owned files;
- where temporary work and unreviewed generated outputs belong.

When practical, run this with a genuinely fresh agent/session. Otherwise simulate the cold start by following only the installed local runtime. If any answer requires hidden bootstrap knowledge, the installation is incomplete; repair the local runtime or create an explicit task for the gap.

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
5. If migrating a legacy `.ai/` namespace, apply the explicit migration rule above; never rename it during routine work.
6. Refresh infrastructure-managed blocks, manifest, and snapshot only as needed.
7. Perform cold-start validation from the installed local runtime.

### Existing project / uninitialized brownfield

1. Read the bootstrap index, `COMMON.md`, and this scenario from either authorized GitHub access or the provided local bundle.
2. Perform the bounded brownfield inventory before opening large amounts of content.
3. Determine Minimal vs Standard profile from actual project complexity.
4. Identify high-value authoritative artifacts and dependency-sensitive structures using targeted inspection.
5. Read existing root/instruction files before integrating infrastructure.
6. Create only missing project-memory files justified by the selected profile and safely augment existing ones.
7. Create `_ai/infrastructure/` and its `standard/` snapshot; create other `_ai/` subdirectories only when useful.
8. Save the applied `COMMON.md` and `L1_LOCAL_FOLDER.md`, and create/update `MANIFEST.md` with profile, namespace, version/lifecycle/commit/ref when known.
9. Ensure `AGENTS.md` contains the required L1 runtime rules and the actual installed file list.
10. Populate project memory from evidence without inventing missing facts.
11. Register only important sources using current relative paths.
12. If the project is already a Git repository, apply the `.gitignore` rules non-destructively when relevant.
13. Do not move/rename files solely to standardize appearance.
14. Summarize current state and supported next actions.
15. Perform cold-start validation from local files only.

### New project / greenfield

1. Start with Minimal profile unless known complexity justifies Standard.
2. Create `_ai/infrastructure/` and only other agent/domain directories actually needed.
3. Preserve any target file that already exists.
4. Record known objectives, constraints, sources, assumptions, and tasks without invention.
5. Install the L1 runtime rules and actual installed-file list in `AGENTS.md`.
6. Apply Git ignore rules only when Git already exists or Git setup is separately requested.
7. Perform cold-start validation.

## Completion report

After initialization/restructuring/repair/migration, report concisely:

- classification: already initialized / brownfield / greenfield;
- selected project-memory profile;
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

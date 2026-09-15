# Scenario G1 — GitHub + Google Drive

**Status:** Draft  
**Depends on:** [`COMMON.md`](COMMON.md)  
**Standard version:** inherit from [`../PROJECT_INFRASTRUCTURE.md`](../PROJECT_INFRASTRUCTURE.md)

Use this scenario when one logical project is intentionally split between a dedicated GitHub repository and a dedicated Google Drive folder.

GitHub is the default **control/state plane** for project memory, code, scripts, configuration, and durable text knowledge. Google Drive is the default **artifact plane** for Google Docs/Sheets/Slides, Office/PDF files, media, large datasets, and other artifacts better suited to Drive.

Both locations may already contain project material. G1 is therefore brownfield-first on **both sides**.

`Draft` means the scenario is structurally specified but still needs representative real-project pilots before promotion to `Pilot`.

## 1. Core model

A G1 project has two canonical stores with different responsibilities:

```text
                    G1 project
                        │
          ┌─────────────┴─────────────┐
          │                           │
       GitHub                    Google Drive
   control/state plane           artifact plane
          │                           │
 AGENTS / STATE / TASKS          Docs / Sheets / Slides
 PROJECT / SOURCES               PDF / Office / media
 code / scripts / configs        large data / binaries
 decisions / plans                    │
          └─────────────┬─────────────┘
                        │
                execution workspace
              optional and non-canonical
```

The stores are complementary, not mirrored copies.

Do not maintain a second copy of `STATE.md`, `TASKS.md`, or other current project state in Drive. Do not mirror Drive documents into GitHub merely for completeness.

## 2. Default placement policy

For **new** artifacts, prefer:

### GitHub

- project-memory/runtime files defined by `COMMON.md`;
- code, scripts, notebooks when text-friendly and appropriate for Git;
- configuration and small text data;
- plans, decisions, research notes, schemas, prompts, and documentation;
- other artifacts where diff/history through Git is valuable.

### Google Drive

- native Google Docs, Sheets, and Slides;
- DOCX/XLSX/PPTX and similar Office files;
- PDFs, images, audio/video, archives, and large binaries;
- large datasets or exports that are impractical for normal Git use;
- collaborative documents whose canonical editing environment is Google Workspace.

This is a **placement default, not a migration command**. During brownfield bootstrap, preserve existing canonical locations unless the user explicitly requests reorganization. A source that is already canonical in the “other” store may remain there and should simply be registered accurately in `SOURCES.md`.

## 3. Project-memory profile and language

Use the Minimal/Standard profile rules from `COMMON.md`.

For most substantial G1 projects, `Standard` will be appropriate because cross-store provenance matters, and `SOURCES.md` is strongly recommended. A genuinely small project may still use Minimal plus `SOURCES.md` if that is sufficient.

Project-memory language follows `COMMON.md`; for this standard the default is Russian (`ru`). Deliverable language does not change project-memory language by itself.

## 4. Canonical G1 runtime in GitHub

The GitHub repository is the canonical home of the installed runtime and project-memory layer.

Typical repository structure:

```text
repo/
├── AGENTS.md
├── PROJECT.md          # when justified by profile
├── STATE.md
├── TASKS.md
├── ASSUMPTIONS.md      # when relevant
├── SOURCES.md          # strongly recommended for G1
├── README.md           # optional/human-facing
├── src/ ...            # project-specific
└── _ai/
    ├── infrastructure/
    │   ├── MANIFEST.md
    │   └── standard/
    │       ├── COMMON.md
    │       └── G1_GITHUB_GOOGLE_DRIVE.md
    ├── plans/
    ├── decisions/
    ├── research/
    ├── archive/
    ├── work/
    └── generated/
```

Create only the project-memory files and `_ai/` subdirectories that have a real role, following `COMMON.md`.

Normal runtime does **not** require access to the external `ai-workflow` standard repository. It does require access to the project's own GitHub repository or a current local clone of it.

## 5. Infrastructure manifest

Create/update:

```text
_ai/infrastructure/MANIFEST.md
_ai/infrastructure/standard/COMMON.md
_ai/infrastructure/standard/G1_GITHUB_GOOGLE_DRIVE.md
```

Recommended manifest fields:

```markdown
# Project infrastructure manifest

Scenario: G1
Project-memory profile: Minimal | Standard
Project-memory language: ru
Agent namespace: _ai/

GitHub repository: <owner/repo>
GitHub default branch: <branch>

Google Drive root folder ID: <folder-id>
Google Drive root folder URL: <observed URL when available>
Google Drive root folder name: <human-readable name>

Standard source: maxvfk/ai-workflow or local bootstrap bundle
Standard version: <installed version>
Standard lifecycle: <Draft/Pilot/Stable>
Standard commit/ref: <exact commit/ref when known>
Initialized: YYYY-MM-DD
Last infrastructure update: YYYY-MM-DD
Runtime entry point: ../../AGENTS.md
Local standard snapshot: ./standard/
```

Use the Drive **folder ID** as the stable machine reference. Name/path is human context and may change.

Never invent IDs, URLs, branch names, or commit refs.

## 6. `SOURCES.md` as the cross-store registry

`SOURCES.md` is the primary bridge between GitHub project state and Drive artifacts.

Use stable `S-###` IDs from `COMMON.md`.

For a Drive source, record when useful:

```markdown
## S-012 — Расчёт стоимости
Storage: Google Drive
Type: Google Sheet
Drive file ID: <id>
Drive URL: <observed URL when available>
Drive path/name: Расчёты / Стоимость
Canonical: yes
Modification: editable
```

For a GitHub source:

```markdown
## S-013 — Расчётный код
Storage: GitHub
Path: src/cost_model.py
Canonical: yes
Modification: editable
```

Prefer IDs and repository-relative paths as machine-stable locators. Human-readable names/folder context supplement them.

Do not register every ordinary file. Apply the source-selection rules from `COMMON.md` and register important canonical/non-reconstructable inputs, current major outputs, provenance-sensitive artifacts, and dependency entry points.

## 7. Optional Drive-to-GitHub pointer

When useful for human discoverability, the Drive root may contain a small pointer document such as `PROJECT_LINK.md` or a short Google Doc stating that the folder belongs to the G1 project and linking to the GitHub repository/runtime entry point.

This pointer is optional and must **not** duplicate `STATE.md`, `TASKS.md`, or other current project memory. GitHub remains the project-state plane.

Preserve existing Drive organization and sharing permissions when adding such a pointer.

## 8. Brownfield-first bootstrap on both stores

A G1 project is brownfield if either the target GitHub repository or target Drive folder already contains meaningful project material.

Do not classify it as greenfield merely because one side is empty.

### GitHub inspection

Use bounded discovery similar to L1:

- inspect repository root and normally no more than 2 directory levels initially;
- identify existing README/instruction/project-memory files, code entry points, configs, reports, data, and large/binary material;
- read existing files before modifying them;
- preserve repository structure, history, branches, and project-specific instructions.

### Drive inspection

Start with metadata/folder discovery, not bulk download:

- inspect the selected Drive root and normally no more than 2 folder levels initially;
- identify native Google files, Office/PDF artifacts, major datasets, current deliverables, and obvious archives/backups;
- use names, MIME/type, modified time, size when available, and folder context to identify high-value candidates;
- open/fetch only high-value candidates required to reconstruct project context;
- do not recursively download or ingest the full folder by default.

### Preservation rule

During bootstrap do not move, rename, convert, regroup, or duplicate existing GitHub/Drive artifacts merely to make the project match the preferred G1 layout.

If the two stores contain competing apparent “latest” versions, do not guess. Register the ambiguity as an assumption/task and resolve provenance before declaring one canonical.

## 9. Agent execution modes

G1 must work for agents with different capabilities. The execution mode is selected per session/task; it is not part of canonical project state.

### Mode A — connector-native

Use when the agent can access GitHub and Google Drive through connectors/APIs but has no persistent local filesystem or does not need one.

Best for:

- discovery and metadata reads;
- bounded source reads;
- small GitHub text edits;
- native Google Docs/Sheets/Slides operations supported by the connector;
- small addressed updates to Drive files;
- project-memory synchronization.

Do not create a local workspace merely because one is theoretically possible.

### Mode B — local/hybrid workspace

Use when the agent has filesystem access and the task benefits from iterative local work.

Typical setup:

```text
local repo clone/
└── _ai/work/
    ├── drive/
    ├── scratch/
    └── MATERIALIZATION.md
```

The GitHub working tree is a normal clone/checkout. Drive artifacts are materialized only as needed into the non-canonical work area.

### Mode C — ephemeral workspace

A cloud/chat agent may have a temporary execution filesystem even though it has no persistent user-local folder. Treat it the same as a local workspace for processing, except that all contents are disposable.

Nothing in an ephemeral workspace is canonical. Required results must be published back before the task is considered complete.

## 10. Connector vs materialization routing

Default rule:

> **Use connectors for discovery and small addressed operations; materialize only when iterative computation or unsupported tooling makes a workspace materially better.**

Prefer direct connector/native work for roughly one to a few bounded operations.

Prefer materialization when the task requires repeated cycles such as:

```text
read → transform → inspect → modify → validate
```

or requires Python/MATLAB/specialized parsers, multiple interdependent files, heavy table transformation, batch processing, or other local tooling.

Materialize the **smallest sufficient subset**, not the whole Drive folder.

## 11. Materialization tracking

When a persistent/local workspace is used, keep temporary provenance under the installed work area, for example:

```text
_ai/work/MATERIALIZATION.md
```

For each materialized Drive artifact record when useful:

- `S-###` source ID;
- Drive file ID;
- source type/MIME;
- source modified time or revision identifier when available;
- local working path;
- whether the local copy is raw, exported, converted, or derived;
- intended publish target/action.

This mapping is temporary execution metadata and should normally remain uncommitted with `_ai/work/`.

An ephemeral agent may keep equivalent in-session metadata without creating a durable file.

## 12. Native Google Docs/Sheets/Slides

Native Google Workspace files have special rules.

Prefer connector-native reads/edits when supported.

If a native Google file is exported to DOCX/XLSX/PPTX/PDF/CSV or another local format for analysis or processing:

- the export is a **derived working copy**, never automatically canonical;
- preserve the original Drive file ID as the canonical locator unless the user explicitly chooses a new canonical artifact;
- decide the publish-back method before making substantial edits;
- do not silently replace a native Google file with an uploaded binary equivalent;
- when possible, apply validated changes back through the native connector/API rather than changing file type;
- if the task intentionally creates a new imported/native document, verify the created Drive artifact and then update `SOURCES.md`/state deliberately.

For native Sheets, prefer range/table/formula operations for ordinary edits; materialize/export only when complex computation or unsupported operations justify it.

## 13. Stored non-native Drive files

For PDFs, Office files, ZIPs, images, datasets, and other stored non-native files:

- use connector reads for bounded inspection when sufficient;
- materialize/download the raw file for local tooling when needed;
- preserve the Drive file ID and source revision/modified metadata;
- publish an edited result back deliberately, preserving the canonical file identity when the available API/workflow safely supports replacement/versioning;
- otherwise create a new verified artifact and update `SOURCES.md` so the canonical relationship is explicit.

Do not leave an edited local file as the only copy of a completed result.

## 14. Publish-back transaction

For any materialized or locally generated result, use this order:

```text
DISCOVER / GROUND
        ↓
READ or MATERIALIZE
        ↓
WORK
        ↓
VALIDATE LOCALLY
        ↓
RE-CHECK CANONICAL SOURCE
        ↓
PUBLISH TO GITHUB OR DRIVE
        ↓
VERIFY PUBLISHED RESULT
        ↓
UPDATE SOURCES / STATE / TASKS IN GITHUB
```

Do not mark a deliverable complete in `STATE.md`/`TASKS.md` before the canonical write succeeds and is verified.

If publication fails, keep project memory truthful: record the result as local/ephemeral/unpublished or blocked, not completed.

## 15. Concurrency and conflict checks

Apply the optimistic-concurrency rules from `COMMON.md` to both stores.

Before writing GitHub project state, re-read the current target file/branch state and reconcile changes.

Before publishing a materialized Drive artifact, re-check the canonical Drive file's revision/modified metadata when available.

If the source changed after materialization:

- do not blindly overwrite it;
- compare/reconcile when safe;
- otherwise preserve the candidate output separately and surface the conflict.

Prefer one active owner per `T-###` task/canonical artifact at a time unless explicit coordination exists.

## 16. Local synced Google Drive folders

A locally synchronized Google Drive folder may be used as an **access path**, but it is not a separate canonical store.

When working through a synced folder:

- preserve the distinction between local sync state and canonical Drive identity;
- prefer Drive IDs in `SOURCES.md` rather than machine-specific local paths;
- do not assume a local write has reached Drive until synchronization can be verified;
- avoid using sync folders as scratch space for partial/intermediate writes; prefer `_ai/work/` in the local repository/workspace;
- for native Google Docs/Sheets/Slides, use connector/native operations rather than treating local shortcut/placeholder files as editable canonical content.

## 17. Git and temporary-work rules

The G1 GitHub repository is already a Git project. Preserve its existing `.gitignore` and add only non-destructive managed rules when useful.

For new G1 installs, normally ignore:

```gitignore
# project-infrastructure:start
_ai/work/
_ai/generated/
# project-infrastructure:end
```

Omit `_ai/generated/` if generated drafts are intentionally versioned.

Do not ignore `_ai/infrastructure/`, `_ai/plans/`, `_ai/decisions/`, `_ai/research/`, or `_ai/archive/` merely because they are agent-owned; they may contain durable project knowledge.

Do not commit materialized Drive binaries under `_ai/work/`.

## 18. Required G1 runtime rules in `AGENTS.md`

During bootstrap/migration, install a concise infrastructure-managed block containing at least:

- `Scenario: G1`;
- installed standard version/commit when known;
- project-memory profile/language and actual installed memory files;
- GitHub repository identity/default branch;
- Google Drive root folder ID and human-readable reference;
- path to `_ai/infrastructure/MANIFEST.md`;
- GitHub is the project-state/control plane; Drive is the document/large-artifact plane;
- existing canonical locations are preserved unless explicitly reorganized;
- `SOURCES.md` is the cross-store canonical registry when installed;
- connectors are preferred for discovery/small native operations;
- iterative/heavy work may materialize only the required subset into a non-canonical workspace;
- `_ai/work/` and ephemeral workspaces are never canonical;
- native Google exports are derived working copies unless explicitly promoted;
- publish/verify canonical results before marking tasks complete;
- re-check shared GitHub/Drive state before writes and do not overwrite concurrent changes blindly;
- secrets/credentials are never stored in project memory;
- external `ai-workflow` standard access is not required for ordinary project work.

Preserve project-specific/user-authored `AGENTS.md` content and update only the infrastructure-managed block when practical.

## 19. G1 bootstrap procedure

The user/agent must ground two target resources:

1. the project GitHub repository;
2. the project Google Drive root folder.

Do not guess either target when multiple plausible resources exist.

### Already initialized G1

1. Read the repository `AGENTS.md`, `_ai/infrastructure/MANIFEST.md`, and only the project-memory needed to understand installed state.
2. Verify the configured Drive root still resolves to the intended folder.
3. If infrastructure migration was requested, compare the local snapshot with the target standard and migrate non-destructively.
4. Preserve project-specific instructions, IDs, source registrations, and Drive/GitHub canonical relationships.
5. Refresh managed runtime/manifest/snapshot only as needed.
6. Perform G1 cold-start validation.

### Uninitialized brownfield G1

1. Read the bootstrap index, `COMMON.md`, and this scenario from authorized standard access or a provided local bundle.
2. Inspect the GitHub repository and Drive root with bounded metadata-first discovery.
3. Determine the project-memory profile and language from `COMMON.md` and existing project context.
4. Identify important existing artifacts and any competing/ambiguous canonical versions.
5. Preserve both existing organizations; do not restructure merely to fit G1 defaults.
6. Create/augment the justified project-memory files in GitHub; create `SOURCES.md` unless the project is exceptionally trivial and cross-store provenance is obvious without it.
7. Create `_ai/infrastructure/`, save the applied standard snapshot, and create/update `MANIFEST.md` with both store identities.
8. Install the G1 runtime rules in `AGENTS.md`.
9. Register important Drive/GitHub sources using stable IDs/relative paths.
10. Add Git-ignore rules non-destructively when relevant.
11. Optionally add a Drive-root pointer back to GitHub when useful for human discovery.
12. Summarize current state/tasks without claiming unresolved provenance as fact.
13. Perform G1 cold-start validation.

### Greenfield G1

1. Ground the empty/new GitHub repository and Drive root.
2. Start with Minimal profile unless known complexity justifies Standard; add `SOURCES.md` when cross-store artifacts begin to matter.
3. Create the GitHub runtime/infrastructure and only useful project directories.
4. Do not invent a Drive subfolder hierarchy before real artifacts justify it.
5. Install G1 runtime rules and manifest with both store identities.
6. Apply Git-ignore rules.
7. Optionally create the Drive pointer.
8. Perform G1 cold-start validation.

## 20. Cold-start validation for G1

Starting only from the project's GitHub `AGENTS.md` and installed project-memory files, a fresh agent with appropriate project connectors/access should be able to determine without the originating chat or external standard:

- that the project uses G1;
- the current phase/status and nearest active/next `T-###` tasks;
- the exact GitHub repository and Drive root identity;
- where key canonical artifacts live and how to locate them;
- which store is authoritative for project state vs Drive artifacts;
- whether a requested operation should normally use a connector or workspace/materialization;
- that local/ephemeral/materialized copies are non-canonical until published;
- where temporary/generated work belongs;
- the project-memory language and preservation/security rules.

When practical, validate with a genuinely fresh agent/session. Otherwise simulate the cold start using only installed project files and actual connectors/locators.

Unresolved access/provenance gaps become explicit tasks rather than hidden assumptions.

## 21. Completion report

After initialization, repair, or migration, report concisely:

- classification: initialized / brownfield / greenfield;
- selected project-memory profile/language;
- GitHub repository and Drive root grounded;
- project-memory/infrastructure files created or updated;
- existing files/organization preserved rather than moved;
- main canonical sources and any unresolved provenance conflicts;
- selected/available execution modes if relevant;
- Git-ignore/pointer changes made, if any;
- cold-start validation result;
- confirmation that the external infrastructure-standard repository is no longer needed for ordinary project work.

## 22. Minimal invocation

With authorized access to the private standard repository:

> Apply project infrastructure scenario **G1** to GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without standard-repository access, provide:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE.md`;

and ask:

> Apply project infrastructure scenario **G1** to GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using the provided project-infrastructure standard files.

For routine work after bootstrap:

> Read `AGENTS.md`, restore the current project context, and continue with my request.

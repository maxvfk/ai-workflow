# Scenario G1 — GitHub + Google Drive

**Status:** Draft  
**Depends on:** [`COMMON.md`](../COMMON.md)  
**Standard version:** inherit from [`../../PROJECT_INFRASTRUCTURE.md`](../../PROJECT_INFRASTRUCTURE.md)

This file is the **base G1 scenario**. Use it when one logical project is intentionally split between a dedicated GitHub repository and a dedicated Google Drive folder. Product-specific profiles may extend this base without changing the canonical-store model.

GitHub is the default **control/state plane** for project memory, code, scripts, configuration, and durable text knowledge. Google Drive is the default **artifact plane** for Google Docs/Sheets/Slides, Office/PDF files, media, large datasets, and other artifacts better suited to Drive.

Both locations may already contain project material. G1 is therefore brownfield-first on **both sides**.

`Draft` means the scenario is structurally specified but still needs representative real-project pilots before promotion to `Pilot`.

## Product profiles

Product-specific profiles extend this base without changing the canonical-store model.

- [`CHATGPT_PROJECT.md`](CHATGPT_PROJECT.md) — optimized profile for **1 ChatGPT Project ↔ 1 GitHub repository ↔ 1 Google Drive root folder**, including Project Instructions design/deployment and ChatGPT-specific cold-start validation.

## 1. Core model

A G1 project has two complementary canonical stores:

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

The stores are **not mirrors**.

Do not keep a second copy of `STATE.md`, `TASKS.md`, or other current project state in Drive. Do not mirror Drive documents into GitHub merely for completeness.

## 2. Default placement policy

For new artifacts, prefer GitHub for:

- project-memory/runtime files defined by `COMMON.md`;
- code, scripts, text-friendly notebooks, configuration, and small text data;
- plans, decisions, research notes, schemas, prompts, and documentation;
- other artifacts where Git diff/history is valuable.

Prefer Google Drive for:

- native Google Docs, Sheets, and Slides;
- DOCX/XLSX/PPTX and similar Office files;
- PDFs, images, audio/video, archives, and large binaries;
- large datasets or exports impractical for ordinary Git use;
- collaborative artifacts whose canonical editing environment is Google Workspace.

This is a **placement default, not a migration command**. During brownfield bootstrap, preserve existing canonical locations unless the user explicitly requests reorganization.

A source already canonical in the “other” store may remain there and should simply be registered accurately in `SOURCES.md`.

## 3. Project-memory profile and language

Use the Minimal/Standard profile rules from `COMMON.md`.

For most substantial G1 projects, `Standard` will be appropriate because cross-store provenance matters. `SOURCES.md` is strongly recommended even when the rest of the project remains close to Minimal.

Project-memory language follows `COMMON.md`; the default is Russian (`ru`). Deliverable language does not change project-memory language by itself.

## 4. Canonical runtime in GitHub

The project GitHub repository is the canonical home of the installed runtime and project-memory layer.

Typical structure:

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
    │       └── G1_GITHUB_GOOGLE_DRIVE/
    │           └── BASE.md
    ├── plans/
    ├── decisions/
    ├── research/
    ├── archive/
    ├── work/
    └── generated/
```

Create only files/directories that have a real role.

Normal runtime does **not** require the external `ai-workflow` standard repository. It does require access to the project's own GitHub runtime, either remotely or through a current local clone/check-out.

## 5. Infrastructure manifest

Create/update:

```text
_ai/infrastructure/MANIFEST.md
_ai/infrastructure/standard/COMMON.md
_ai/infrastructure/standard/G1_GITHUB_GOOGLE_DRIVE/BASE.md
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

Do **not** store a product-specific capability matrix in the manifest: connector/tool capabilities are session-dependent and may change independently of the project.

## 6. `SOURCES.md` as the cross-store registry

`SOURCES.md` is the primary bridge between GitHub project state and Drive artifacts.

Use stable `S-###` IDs from `COMMON.md`.

Example Drive source:

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

Example GitHub source:

```markdown
## S-013 — Расчётный код
Storage: GitHub
Path: src/cost_model.py
Canonical: yes
Modification: editable
```

Prefer IDs and repository-relative paths as stable machine locators. Human-readable names/folder context supplement them.

Do not register every ordinary file. Register important canonical/non-reconstructable inputs, major outputs, provenance-sensitive artifacts, and dependency entry points.

## 7. Optional Drive-to-GitHub pointer

When useful for human discoverability, the Drive root may contain a small pointer document such as `PROJECT_LINK.md` or a short Google Doc stating that the folder belongs to the G1 project and linking to the GitHub repository/runtime entry point.

This pointer is optional and must **not** duplicate `STATE.md`, `TASKS.md`, or other current project memory.

Preserve existing Drive organization and sharing permissions when adding such a pointer.

## 8. Brownfield-first bootstrap on both stores

A G1 project is brownfield if **either** the target GitHub repository or target Drive folder already contains meaningful project material.

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

During bootstrap do not move, rename, convert, regroup, or duplicate existing GitHub/Drive artifacts merely to match the preferred G1 layout.

If the two stores contain competing apparent “latest” versions, do not guess. Register the ambiguity as an assumption/task and resolve provenance before declaring one canonical.

## 9. Session operation discovery

G1 is **operation-driven, not product-driven**. Do not assume that all agents, chats, connectors, MCP servers, local runtimes, or product surfaces expose the same operations, permissions, or identity-preserving semantics.

Before a modifying task, determine the required path from **observable tool/actions and target state**, not from model self-assessment.

Use this process:

1. ground the exact GitHub/Drive target and read the metadata/revision needed for concurrency/provenance;
2. inspect the actual operations exposed in the current session;
3. choose the first identity-preserving operation that is explicitly available for the intended change;
4. do not infer write support from read support, product name, or prior sessions;
5. do not perform destructive/dummy writes merely to test a capability;
6. when the intended safe operation fails because the action is unavailable, unauthorized, unsupported, or cannot preserve identity, treat that path as unavailable and descend the fallback ladder;
7. preserve the failure as session context only when useful; do not turn transient capability observations into durable project state.

A successful metadata/read operation proves only that specific read path. A successful canonical write proves the corresponding write path for that operation/target at that moment.

The project manifest may record a **lasting required dependency** only when project operation genuinely depends on a particular API/tool. Do not store a session capability matrix.

## 10. Agent execution modes

Execution mode is selected per session/task and may combine capabilities.

### Mode A — connector/API native

Use when available connector/API operations can safely perform the required work directly.

Best for:

- discovery and metadata reads;
- bounded source reads;
- small GitHub text edits when GitHub write exists;
- native Google Docs/Sheets/Slides operations explicitly supported by the current connector/API;
- small addressed Drive operations;
- project-memory synchronization when GitHub write exists.

Do not assume that a Drive connector which can read or create files can also edit existing Google-native content.

### Mode B — local/hybrid workspace

Use when the agent has filesystem access and iterative local work is advantageous.

Typical setup:

```text
local repo clone/
└── _ai/work/
    ├── drive/
    ├── scratch/
    └── MATERIALIZATION.md
```

The GitHub working tree is a normal clone/check-out. Drive artifacts are materialized only as needed into the non-canonical work area.

### Mode C — ephemeral workspace

A cloud/chat agent may have a temporary execution filesystem without a persistent user-local folder.

Treat it like a local workspace for processing, except that all contents are disposable. Nothing there is canonical.

### Mode D — browser/computer-mediated

When a safe API/native write is unavailable but an authenticated browser/computer-use path can preserve the identity of the canonical artifact, UI-mediated editing may be used for bounded work.

Prefer API/native operations when both are available. Browser/computer use is generally less deterministic and should not be the default for large batch transformations when a reliable API/workflow can be used instead.

## 11. Safe operation fallback ladder

For a requested modification to a canonical artifact, select the first safe supported path:

```text
1. Native connector/API operation preserving canonical identity
        ↓ unavailable
2. Direct local editing when the canonical artifact is genuinely local-editable
   and synchronization/identity can be verified
        ↓ unavailable
3. Browser/computer-mediated editing that preserves canonical identity
        ↓ unavailable
4. Materialize → transform → publish-back,
   only when the round-trip is demonstrably safe
        ↓ unsafe or unavailable
5. Do not mutate the canonical artifact.
   Produce a proposed change / derived result and leave synchronization pending
   for a write-capable agent or workflow.
```

A lower rung must not be chosen merely for convenience if it risks changing file identity, permissions, links, collaboration semantics, formulas, formatting, comments, or other meaningful properties.

**Never emulate an in-place edit by replacing a canonical artifact with a newly uploaded file unless the user explicitly accepts the identity/provenance change and project records are updated accordingly.**

## 12. Connector vs materialization routing

Default rule:

> **Use connectors for discovery and small addressed operations; materialize only when iterative computation or unsupported tooling makes a workspace materially better.**

Prefer direct connector/native work for one to a few bounded operations.

Prefer materialization for repeated cycles such as:

```text
read → transform → inspect → modify → validate
```

or when Python/MATLAB/specialized parsers, multiple interdependent files, heavy table transformation, batch processing, or other local tooling are needed.

Materialize the **smallest sufficient subset**, not the whole Drive folder.

Before materializing for an intended edit, determine the safe publish-back path. If no safe path exists, treat the materialization as analysis/proposal generation rather than as a canonical edit workflow.

## 13. Materialization tracking

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
- intended publish target/action;
- whether safe publish-back has been confirmed.

This mapping is temporary execution metadata and should normally remain uncommitted with `_ai/work/`.

An ephemeral agent may keep equivalent in-session metadata without creating a durable file.

## 14. Native Google Docs/Sheets/Slides

Native Google Workspace files require identity-preserving handling.

Prefer connector/API-native reads and edits **only when the current session actually exposes the required write operation**.

If a native file is exported to DOCX/XLSX/PPTX/PDF/CSV or another local format:

- the export is a **derived working copy**, never automatically canonical;
- preserve the original Drive file ID as the canonical locator unless the user explicitly chooses a new canonical artifact;
- determine the publish-back method before substantial edits;
- do not silently replace the native file with an uploaded binary equivalent;
- apply validated changes back through an identity-preserving native/API/UI path when available;
- if no safe write-back path exists, keep the output as a proposed/derived result and mark synchronization pending;
- if the task intentionally creates a new imported/native document, verify the created artifact and then update `SOURCES.md`/state deliberately.

For native Sheets, range/table/formula operations are preferred for ordinary edits when available. Export/materialize only when complex computation or unsupported operations justify it.

Do not claim that formulas, formatting, comments, permissions, links, or other semantics were preserved unless the chosen round-trip was validated.

## 15. Stored non-native Drive files

For PDFs, Office files, ZIPs, images, datasets, and other stored non-native files:

- use connector reads for bounded inspection when sufficient;
- materialize/download raw files for local tooling when needed;
- preserve Drive file ID and source revision/modified metadata;
- publish edited results deliberately, preserving canonical identity when the available workflow safely supports replacement/versioning;
- otherwise create a new verified artifact and update `SOURCES.md` so the canonical relationship is explicit.

Do not leave an edited local file as the only copy of a completed result.

## 16. Publish-back transaction

For **substantial, cross-store, materialized, provenance-sensitive, or identity-sensitive** canonical changes, use this order:

```text
OPERATION DISCOVERY / GROUND
        ↓
DISCOVER / GROUND
        ↓
READ or MATERIALIZE
        ↓
WORK
        ↓
VALIDATE
        ↓
RE-CHECK CANONICAL SOURCE / SHARED STATE
        ↓
PUBLISH TO THE CANONICAL STORE
        ↓
VERIFY PUBLISHED RESULT
        ↓
UPDATE SOURCES / STATE / TASKS IN GITHUB
        ↓
VERIFY PROJECT-MEMORY SYNC
```

For a bounded low-risk edit to one clearly identified artifact, use the proportional small-edit path from `COMMON.md`: ground/verify the target, perform the safest identity-preserving edit, verify the result, and update project memory only if project state/provenance/task status materially changed.

Do not mark a deliverable complete in `STATE.md`/`TASKS.md` before the canonical artifact write succeeds and is verified.

Do not consider project synchronization complete until the relevant GitHub project-memory changes are also written and verified.

## 17. Incomplete synchronization and read-only agents

An agent may be capable of useful work without being capable of completing the full G1 transaction.

Examples include:

- GitHub read but no GitHub write;
- Drive read/create but no in-place native edit;
- local analysis with no safe publish-back path;
- Drive write succeeds but GitHub project-memory write is unavailable.

In these cases:

- complete every safe step that is actually possible;
- do not falsely report the project as fully synchronized;
- preserve the result as a proposed/derived artifact or explicit pending change;
- clearly identify which canonical write or project-memory synchronization remains pending;
- provide enough provenance/instructions for a write-capable agent or user to finish the transaction;
- do not replace a canonical artifact merely to work around missing write capability.

When GitHub project-memory cannot be updated, the task is not fully complete from the G1 project-state perspective even if useful analysis or an artifact draft has been produced.

A useful status distinction is:

```text
work result ready
canonical publication pending
project-memory synchronization pending
```

Record such status in project memory only if the current agent can safely write it; otherwise report it in the session handoff/output.

## 18. Concurrency and conflict checks

Apply optimistic-concurrency rules from `COMMON.md` to both stores.

Before writing GitHub project state, re-read the current target file/branch state and reconcile intervening changes.

Before publishing a materialized Drive artifact, re-check canonical Drive revision/modified metadata when available.

If the source changed after materialization:

- do not blindly overwrite it;
- compare/reconcile when safe;
- otherwise preserve the candidate output separately and surface the conflict.

Prefer one active owner per `T-###` task/canonical artifact at a time unless explicit coordination exists.

## 19. Local synced Google Drive folders

A locally synchronized Google Drive folder may be an **access path**, but it is not a separate canonical store.

When working through a synced folder:

- preserve the distinction between local sync state and canonical Drive identity;
- prefer Drive IDs in `SOURCES.md` rather than machine-specific local paths;
- do not assume a local write has reached Drive until synchronization can be verified;
- avoid using sync folders as scratch space for partial/intermediate writes; prefer `_ai/work/`;
- for native Google Docs/Sheets/Slides, do not treat local shortcut/placeholder files as ordinary editable binaries unless the access mechanism explicitly supports safe editing.

## 20. Git and temporary-work rules

Preserve the repository's existing `.gitignore` and add only non-destructive managed rules when useful.

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

## 21. Required G1 runtime rules in `AGENTS.md`

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
- each modifying session must choose workflows from observable available operations/target state and treat unsupported/failed operations as unavailable rather than guessing capabilities;
- connectors/APIs are preferred for discovery and safe native operations;
- use the safe fallback ladder when the preferred write path is unavailable;
- iterative/heavy work may materialize only the required subset into a non-canonical workspace;
- `_ai/work/` and ephemeral workspaces are never canonical;
- native Google exports are derived working copies unless explicitly promoted;
- missing in-place write capability must not be worked around by silently replacing canonical files;
- publish and verify canonical results before marking tasks complete;
- project-memory synchronization in GitHub is part of completion for project-changing work;
- if a write/synchronization step cannot be completed, report it explicitly as pending rather than claiming completion;
- re-check shared GitHub/Drive state before writes and do not overwrite concurrent changes blindly;
- secrets/credentials are never stored in project memory;
- external `ai-workflow` standard access is not required for ordinary project work.

Preserve project-specific/user-authored `AGENTS.md` content. When infrastructure rules share a pre-existing file with user/project content, maintain them only inside the mandatory managed block defined by `COMMON.md`.

## 22. G1 bootstrap procedure

Ground two target resources:

1. the project GitHub repository;
2. the project Google Drive root folder.

Do not guess either target when multiple plausible resources exist.

### Already initialized G1

1. Read repository `AGENTS.md`, `_ai/infrastructure/MANIFEST.md`, and only project-memory needed to understand installed state.
2. Verify configured Drive root still resolves to the intended folder.
3. Determine current-session capabilities relevant to the requested infrastructure operation.
4. If migration was requested, compare installed snapshot with target standard and migrate non-destructively.
5. Preserve project-specific instructions, IDs, source registrations, and Drive/GitHub canonical relationships.
6. Refresh managed runtime/manifest/snapshot only as needed.
7. Perform G1 cold-start validation.

### Uninitialized brownfield G1

1. Read the bootstrap index, `COMMON.md`, and this scenario from authorized standard access or a provided local bundle.
2. Ground the GitHub repository and Drive root.
3. Ground the required targets and discover/verify the concrete read/write operations needed for the bootstrap without assuming capabilities.
4. Inspect both stores with bounded metadata-first discovery.
5. Determine project-memory profile/language from `COMMON.md` and existing project context.
6. Identify important existing artifacts and competing/ambiguous canonical versions.
7. Preserve both existing organizations; do not restructure merely to fit G1 defaults.
8. Create/augment justified project-memory files in GitHub; create `SOURCES.md` unless the project is exceptionally trivial and cross-store provenance is obvious without it.
9. Create `_ai/infrastructure/`, save applied standard snapshot, and create/update `MANIFEST.md` with both store identities.
10. Install G1 runtime rules in `AGENTS.md`.
11. Register important Drive/GitHub sources using stable IDs/relative paths.
12. Add Git-ignore rules non-destructively when relevant.
13. Optionally add a Drive-root pointer back to GitHub when useful for human discovery.
14. Summarize current state/tasks without claiming unresolved provenance as fact.
15. Perform G1 cold-start validation.

If required bootstrap writes are unavailable in the current session, do not simulate completion. Produce an explicit bootstrap plan/pending-change set for a write-capable session.

### Greenfield G1

1. Ground the empty/new GitHub repository and Drive root.
2. Check current-session capabilities required for bootstrap.
3. Start with Minimal profile unless known complexity justifies Standard; add `SOURCES.md` when cross-store artifacts matter.
4. Create GitHub runtime/infrastructure and only useful project directories.
5. Do not invent a Drive subfolder hierarchy before real artifacts justify it.
6. Install G1 runtime rules and manifest with both store identities.
7. Apply Git-ignore rules.
8. Optionally create the Drive pointer.
9. Perform G1 cold-start validation.

If required writes are unavailable, leave a truthful pending bootstrap plan rather than claiming G1 is installed.

## 23. Cold-start validation for G1

Starting only from project GitHub `AGENTS.md` and installed project-memory files, a fresh agent with appropriate project access should be able to determine without the originating chat or external standard:

- that the project uses G1;
- current phase/status and nearest active/next `T-###` tasks;
- exact GitHub repository and Drive root identity;
- where key canonical artifacts live and how to locate them;
- which store is authoritative for project state vs Drive artifacts;
- that actual session capabilities must be checked before assuming writes are possible;
- the safe fallback order when a preferred operation is unavailable;
- that local/ephemeral/materialized copies are non-canonical until published;
- that incomplete publication/project-memory synchronization must be reported explicitly;
- where temporary/generated work belongs;
- project-memory language and preservation/security rules.

When practical, validate with a genuinely fresh agent/session. Otherwise simulate the cold start using only installed project files and actual connectors/locators.

Unresolved access/provenance gaps become explicit tasks rather than hidden assumptions.

## 24. Completion report

After initialization, repair, migration, or substantial project-changing work, report concisely when relevant:

- classification: initialized / brownfield / greenfield;
- selected project-memory profile/language;
- GitHub repository and Drive root grounded;
- relevant session capabilities and any material write limitations;
- project-memory/infrastructure files created or updated;
- existing files/organization preserved rather than moved;
- main canonical sources and unresolved provenance conflicts;
- execution/fallback path used;
- canonical publication verification result;
- GitHub project-memory synchronization result;
- any remaining pending publication/synchronization step;
- cold-start validation result for infrastructure work;
- confirmation that the external infrastructure-standard repository is not needed for ordinary project work.

## 25. Minimal invocation

With authorized access to the private standard repository:

> Apply project infrastructure scenario **G1** to GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without standard-repository access, provide:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md`;

and ask:

> Apply project infrastructure scenario **G1** to GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using the provided project-infrastructure standard files.

For routine work after bootstrap:

> Read `AGENTS.md`, restore the current project context, check the capabilities available in this session, and continue with my request.

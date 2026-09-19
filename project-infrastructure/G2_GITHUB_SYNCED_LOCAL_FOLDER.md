# Scenario G2 — GitHub + Synced Local Folder

**Status:** Draft  
**Depends on:** [COMMON.md](COMMON.md)  
**Standard version:** inherit from [PROJECT_INFRASTRUCTURE.md](../PROJECT_INFRASTRUCTURE.md)

Use this scenario when one logical project is split between a dedicated GitHub repository and a user-facing local project folder synchronized across machines by an external synchronization system such as Yandex Disk, OneDrive, Google Drive for desktop, Syncthing, NAS/cloud-sync software, or a similar service.

The synchronization provider is transport, not a third canonical store.

## 1. Core model

~~~text
                      G2 project
                          │
             ┌────────────┴────────────┐
             │                         │
         GitHub repo          synced local folder
       control/state plane       artifact plane
             │                         │
         AGENTS.md                AGENTS.md
         PROJECT.md               CAD / DOCX / XLSX
         STATE.md                 data / reports
         TASKS.md                 results / media
         SOURCES.md
         decisions/plans
             │                         │
             └────────────┬────────────┘
                          │
                 execution workspace
            preferably outside sync roots
~~~

GitHub is the **canonical control/state plane**. The synchronized local folder is the **canonical artifact root**. They are complementary, not mirrors.

Do not duplicate current project memory into the artifact root. Do not move large/user artifacts into GitHub merely to centralize state.

## 2. Why G2 exists

Use G2 when:

- work happens on several machines;
- project artifacts are already synchronized independently of Git;
- CAD/Office/data/binary files should remain ordinary local files;
- durable project memory benefits from Git history and one shared state plane;
- the user wants the synchronized working folder to remain mostly free of agent infrastructure.

Unlike L1, the local folder is not the canonical home of project memory. Unlike G1, artifacts are accessed as ordinary local files rather than primarily through a document API.

## 3. Canonical roles

### GitHub control/state plane

Prefer GitHub for:

- AGENTS.md, PROJECT.md, STATE.md, TASKS.md;
- ASSUMPTIONS.md and SOURCES.md when justified;
- durable plans, decisions, research notes, prompts, schemas;
- scripts, text-friendly code/configuration;
- infrastructure manifest and installed standard snapshot.

### Synced local artifact plane

Prefer the synchronized folder for:

- CAD projects and dependencies;
- DOCX/XLSX/PPTX and editable documents;
- PDFs, images, media, archives;
- datasets and measurement files;
- calculation outputs;
- reports and deliverables;
- other user-owned artifacts whose normal working environment is the local filesystem.

This is a placement default, not a migration command. Preserve existing canonical locations unless the user explicitly requests reorganization.

## 4. Runtime dependency model

G2 distinguishes:

1. the external infrastructure-standard repository, such as maxvfk/ai-workflow;
2. the project's own dedicated GitHub repository.

The external standard is needed only for initialization, validation, repair, or migration.

The project's own GitHub repository is a **permanent canonical part of G2 runtime** and is normally required for project-state continuity.

After bootstrap, ordinary work must not require the originating chat or the external standard repository.

A new agent must be able to continue from the synced artifact folder, its local bootstrap `AGENTS.md`, and access to the project GitHub repository named there.

### Control-repository access modes

The project GitHub repository is a permanent canonical control/state store, but G2 does **not** require one fixed machine-specific clone path.

Use one of these modes per session/task:

**Mode A — remote/API/connector access (preferred for project memory)**
- use an authenticated GitHub connector/API/CLI operation to read and update `AGENTS.md`, `STATE.md`, `TASKS.md`, `SOURCES.md`, manifests, decisions, and other small text state;
- immediately before a write, re-read the current file/revision;
- when the API exposes a blob/content SHA, revision, ETag, or equivalent conditional-write token, use it;
- if the write is rejected because the target changed, refresh and reconcile; never force-overwrite stale project state;
- a small project-memory update may go directly to the repository's normal/default branch only when that is consistent with the repository's existing contribution/branch policy and the current session is authorized.

**Mode B — local checkout outside the synchronized artifact root**
- use when code, scripts, many repository files, diff/build/test workflows, or multi-file Git operations materially benefit from a working tree;
- place/discover the checkout **outside the synchronized artifact root** and preferably outside any cloud-sync root;
- a harness-provided temporary workspace is suitable for an ephemeral checkout; a persistent local clone is also acceptable;
- the checkout's absolute path is machine/session-local context and is never canonical project state;
- before publishing, fetch/pull/rebase/merge according to the repository's established policy and reconcile concurrent changes;
- push normally; if push/merge is rejected, refresh and reconcile rather than force-pushing unless the user explicitly requests a destructive history operation.

**Never clone the control repository inside the synchronized artifact root.** This would mix `.git` and project-memory files into the artifact sync plane, violate the G2 separation of roles, and create avoidable sync/conflict risk.

Do not invent a new branching model merely for G2. Respect an existing repository policy. If none exists, prefer the simplest safe path: bounded project-memory edits through Mode A; task branches/local checkout only when the work itself benefits from Git workflow.

## 5. Recommended GitHub structure

~~~text
repo/
├── AGENTS.md
├── PROJECT.md          # when justified
├── STATE.md
├── TASKS.md
├── ASSUMPTIONS.md      # when relevant
├── SOURCES.md          # strongly recommended for G2
├── README.md           # optional
├── src/ ...            # text-friendly code/scripts when appropriate
└── _ai/
    ├── infrastructure/
    │   ├── MANIFEST.md
    │   └── standard/
    │       ├── COMMON.md
    │       └── G2_GITHUB_SYNCED_LOCAL_FOLDER.md
    ├── plans/
    ├── decisions/
    ├── research/
    └── archive/
~~~

A durable _ai/work/ directory is normally unnecessary because temporary execution should prefer a harness/local workspace outside the synchronized artifact root.

Create only support files that have a real role.

## 6. Synced artifact-root structure

G2 imposes almost no structure on the user artifact root.

~~~text
Synced-Project/
├── AGENTS.md
├── CAD/
├── Data/
├── Reports/
├── Calculations/
└── Results/
~~~

Preserve the user's existing structure.

The only required local runtime entry file in the artifact root is `AGENTS.md`. If bootstrap creates it from scratch, it may be infrastructure-owned; if a substantive user-authored `AGENTS.md` already exists, preserve it and add only a clearly managed G2 bootstrap section.

Do not add GitHub project-memory files, infrastructure snapshots, plans, or decisions to the artifact root.

## 7. Project identity and local bootstrap `AGENTS.md`

Every G2 project has a stable **Project ID**, preferably a short slug such as:

~~~text
tokamak-cost-study
~~~

The same Project ID must appear in the GitHub infrastructure manifest and the local artifact-root `AGENTS.md`.

Recommended minimal local bootstrap `AGENTS.md` for a new artifact root:

~~~markdown
# G2 local project bootstrap

<!-- project-infrastructure:start -->
Project: <human-readable project name>
Project ID: <stable-project-id>
Scenario: G2

Canonical project control:
https://github.com/<owner>/<repo>

This file is a thin local bootstrap adapter. The canonical full runtime
instructions and project memory live in the project GitHub repository.

Before substantial work:
1. access the canonical project repository using the G2 control-repository access modes;
2. read its root AGENTS.md;
3. restore current state/tasks from GitHub project memory;
4. treat this directory as the synchronized canonical artifact root;
5. resolve project artifact paths relative to this directory;
6. verify Project ID and basic synchronization health before important writes.

Do not create duplicate project-memory files in this folder.
<!-- project-infrastructure:end -->
~~~

Keep the local bootstrap `AGENTS.md` intentionally small and stable. Do not put active tasks, current state, source inventories, credentials, machine-specific absolute paths, or other volatile data into it. Shared/general runtime rules belong in the canonical GitHub `AGENTS.md`; the local file contains only the minimum needed to locate and enter that runtime plus any genuinely local artifact-root instructions.

### Tool compatibility of the local bootstrap

The local entry file is deliberately named `AGENTS.md` so agents that natively discover that convention can enter the project without a separate marker-specific prompt.

Do not create a local `CLAUDE.md` merely for G2 bootstrap. If a concrete Claude-specific local rule is later required, follow `COMMON.md`: keep the local `AGENTS.md` canonical for shared bootstrap behavior and make any `CLAUDE.md` a thin adapter/addition rather than a duplicate.

### Migration from G2 0.6

G2 0.6 used `PROJECT_LINK.md` as the artifact-root marker. Do not rename or delete it during ordinary work merely because the external standard changed.

During an explicit migration to 0.7+:

1. read and preserve any existing local `AGENTS.md`;
2. create or merge the G2 bootstrap block into local `AGENTS.md`;
3. verify that Project ID/repository mapping resolves correctly;
4. update the GitHub manifest/runtime to use `Artifact root marker: AGENTS.md`;
5. remove the old `PROJECT_LINK.md` only when it is clearly infrastructure-owned and its information is fully represented in the verified local `AGENTS.md`; otherwise preserve it as legacy user content.

## 8. Infrastructure manifest

Create/update in GitHub:

~~~text
_ai/infrastructure/MANIFEST.md
_ai/infrastructure/standard/COMMON.md
_ai/infrastructure/standard/G2_GITHUB_SYNCED_LOCAL_FOLDER.md
~~~

Recommended manifest fields:

~~~markdown
# Project infrastructure manifest

Scenario: G2
Project ID: <stable-project-id>
Project-memory profile: Minimal | Standard
Project-memory language: ru
Agent namespace: _ai/

GitHub repository: <owner/repo>
GitHub default branch: <branch>

Artifact root role: synchronized local folder
Artifact root marker: AGENTS.md
Artifact path convention: relative to artifact root
Synchronization assumption: synchronized across working machines

Standard source: maxvfk/ai-workflow or local bootstrap bundle
Standard version: <installed version>
Standard lifecycle: <Draft/Pilot/Stable>
Standard commit/ref: <exact commit/ref when known>
Initialized: YYYY-MM-DD
Last infrastructure update: YYYY-MM-DD
Runtime entry point: ../../AGENTS.md
Local standard snapshot: ./standard/
~~~

Never store a machine-specific absolute artifact-root path or synchronization credentials in the canonical manifest.

## 9. Project-memory profile and language

Use the Minimal/Standard profile rules from COMMON.md.

For substantial engineering, analytical, or long-running G2 projects, Standard is usually appropriate and SOURCES.md is strongly recommended.

Project-memory language follows COMMON.md; the default is Russian (ru) unless another language is explicitly selected or already established.

## 10. Relative artifact paths

Paths to artifacts inside the synchronized artifact root are recorded **relative to the artifact root**.

Example:

~~~markdown
## S-017 — Главная сборка
Storage: G2 artifact root
Path: CAD/MainAssembly.SLDASM
Canonical: yes
Modification: editable
~~~

Do not use machine-specific paths such as:

~~~text
D:\YandexDisk\Projects\Tokamak\CAD\MainAssembly.SLDASM
C:\Users\Max\OneDrive\Tokamak\CAD\MainAssembly.SLDASM
~~~

Absolute paths may exist only as temporary session context for the current machine.

Artifacts outside the G2 artifact root must be registered explicitly as external rather than pretending they are root-relative.

## 11. SOURCES.md as cross-plane registry

SOURCES.md links GitHub project state to important local artifacts.

Use stable S-### IDs from COMMON.md.

Register important canonical/non-reconstructable inputs, major outputs, dependency entry points, provenance-sensitive files, and artifacts with modification restrictions. Do not register every ordinary file.

Useful fields may include:

- Storage: G2 artifact root;
- root-relative Path;
- artifact type;
- Canonical: yes/no;
- modification policy;
- stable external/version identifier when the source itself provides one.

Do **not** maintain mutable file size, modified time, or live-file checksums manually in `SOURCES.md` as ordinary synchronization state. Those values become stale quickly and can create false conflict signals.

A checksum/fingerprint is appropriate only when it is deliberately tied to an **immutable or released artifact/version** (for example a raw input snapshot or approved release) and is generated/recorded as part of that versioning/release process rather than expected to track a changing working file.

## 12. Synchronization model

G2 assumes the external sync system normally keeps the artifact root logically consistent across working machines.

Do not perform a full folder comparison or hash scan on every startup.

Default assumption:

> the connected local artifact root represents the current synchronized project artifacts unless there is evidence of synchronization failure.

Important writes still require a bounded sync-sanity check.

The provider is outside the canonical project-state model. Record provider-specific details only when they are materially required to operate the project.

## 13. Proportional sync-sanity check

G2 assumes the synchronization layer is healthy by default. Do not perform a full project scan before ordinary work.

Before **any canonical artifact write**, perform the minimum target-level checks:

1. confirm the connected folder is the intended G2 artifact root by its local bootstrap `AGENTS.md` / Project ID;
2. confirm the intended relative target path resolves inside that artifact root;
3. check the target area for an obvious conflict copy, duplicate competing version, missing/offline placeholder, or other visible sync error.

For a **bounded low-risk edit**, these checks plus normal target inspection/verification are usually sufficient.

Escalate to an extended sync-sanity check for substantial, destructive, dependency-sensitive, provenance-sensitive, multi-file, or suspicious work. Then also inspect, as relevant:

- whether the target exists and is locally available when expected;
- enough metadata/content context to detect an obviously stale or wrong artifact;
- linked/dependent files required by the application (especially CAD/project bundles);
- provider-exposed sync-error indicators;
- an intentionally recorded immutable/release fingerprint from `SOURCES.md`, if one exists for the exact artifact version being used.

Do not compare mutable working-file timestamps/sizes/checksums against manually maintained registry values.

## 14. Synchronization conflicts

If the artifact root may not be current or internally consistent:

- do not silently select one competing file as canonical;
- do not overwrite the target;
- do not delete conflict copies;
- do not claim the artifact modification succeeded;
- mark the task/artifact blocked by a synchronization/provenance conflict;
- inspect/reconcile the conflict or request user intervention when necessary.

Examples include provider-generated conflict copies, unexpectedly stale files, missing CAD dependencies, offline placeholders, mismatched Project ID, or incompatible edits from another machine.

For CAD/linked-document projects, missing dependencies or unresolved references are possible sync failures; do not automatically rewrite paths.

## 15. Temporary execution workspace priority

Temporary/intermediate work should preferably occur **outside the synchronized artifact root**.

Use this priority:

~~~text
1. Harness-provided temporary/workspace directory outside the synchronized project
        ↓ unavailable
2. Another suitable local temporary/work directory outside the synchronized project
        ↓ unavailable
3. A clearly temporary fallback inside the artifact root
   only when no external workspace is available
~~~

If the harness already exposes a connected/usable temporary workspace, prefer it.

Do not copy the whole project there by default. Copy/materialize only the smallest subset needed for the task.

Temporary paths are session-specific and are never canonical project paths.

## 16. Local fallback work directory

If no external workspace is available, a fallback such as:

~~~text
<artifact-root>/_ai-local-work/
~~~

may be used.

It is non-canonical, disposable, excluded from SOURCES.md as a canonical location, and preferably excluded from synchronization when the provider/environment safely supports that. Otherwise use it transiently and clean it after successful publication when practical.

Do not confuse _ai-local-work/ with the durable GitHub _ai/ namespace.

## 17. Direct editing vs temporary working copies

Because G2 artifacts are ordinary local files, direct editing of the canonical file is often appropriate.

Prefer direct editing when:

- the format/tool supports safe direct modification;
- backup/version/recovery is adequate for the risk;
- the sync-sanity check passed;
- no conflicting simultaneous edit is known;
- the task does not require destructive experimentation.

Prefer an external temporary workspace/copy when:

- transformation is iterative or destructive;
- several files must be staged before replacing an output;
- conversion may lose information;
- validation should occur before promotion;
- external software may create scratch/intermediate files.

A synchronized folder is not automatically a good scratch area.

## 18. Publish/promote transaction

For a bounded low-risk single-artifact edit, use the proportional small-edit path from `COMMON.md` plus the minimum G2 sync-sanity check above. Do not update GitHub project memory unless the edit materially changes project state, task status, provenance, or a recorded decision.

For substantial artifact-changing work:

~~~text
GROUND PROJECT ID / ARTIFACT ROOT
        ↓
RESTORE GITHUB PROJECT STATE
        ↓
PROPORTIONAL / EXTENDED SYNC-SANITY CHECK
        ↓
DIRECT SAFE EDIT
        or
COPY/MATERIALIZE MINIMAL WORKING SET
        ↓
WORK
        ↓
VALIDATE
        ↓
RE-CHECK TARGET / CONFLICT SIGNALS
        ↓
PROMOTE RESULT TO CANONICAL ARTIFACT PATH
        ↓
VERIFY RESULT AT CANONICAL PATH
        ↓
UPDATE SOURCES / STATE / TASKS IN GITHUB
        ↓
VERIFY GITHUB PROJECT-MEMORY SYNC
~~~

Do not mark project-changing work complete before both the canonical local artifact result and relevant GitHub project-memory updates are verified.

The sync provider may need time to replicate changes to other machines. G2 does not require proof that every remote replica is current unless the environment exposes such verification and the task requires it.

## 19. Concurrent work and multi-machine behavior

GitHub project-memory changes follow COMMON.md optimistic-concurrency rules.

Before writing shared GitHub state, re-read current targets and reconcile intervening changes.

For local artifacts:

- assume synchronization normally propagates changes;
- avoid simultaneous modification of the same canonical artifact on multiple machines;
- use one active owner per T-### task/artifact when practical;
- re-check target metadata/conflict signals immediately before final replacement/promotion;
- if another machine appears to have changed the artifact during work, stop blind publication and reconcile.

GitHub history does not replace synchronization/versioning for binary/local artifacts.

## 20. Brownfield-first bootstrap

A G2 project is brownfield if either the GitHub repository or synchronized local artifact folder already contains meaningful project material.

Do not call it greenfield merely because one side is empty.

### GitHub inspection

Use bounded discovery: inspect root and normally no more than 2 levels initially; identify existing instructions/project memory/code/configuration; read before modifying; preserve history/structure and user content.

### Artifact-root inspection

Use bounded local discovery: inspect root and normally no more than 2 levels initially; identify major document/CAD/data/report/output areas and likely canonical artifacts; avoid recursive scans of huge archives, generated trees, CAD dependency forests, caches, vendor trees, or backups unless needed.

Do not reorganize either plane merely to match G2 defaults.

## 21. Already initialized G2

If the local artifact-root `AGENTS.md` and/or GitHub infrastructure metadata indicate G2 is already installed:

1. read the local artifact-root `AGENTS.md`;
2. access the named GitHub repository;
3. read the canonical GitHub `AGENTS.md`, manifest, and only required project memory;
4. verify Project ID match;
5. treat infrastructure work as reconcile/repair/migration rather than fresh bootstrap;
6. preserve IDs/state/source registrations/project language/user content;
7. perform bounded sync-sanity validation;
8. update only managed infrastructure behavior that needs change.

Do not create duplicate local project-memory files.

## 22. Uninitialized brownfield bootstrap

1. Read PROJECT_INFRASTRUCTURE.md, COMMON.md, and this scenario.
2. Ground the target GitHub repository and connected synchronized local folder.
3. Inspect both planes with bounded discovery.
4. Determine/create a stable Project ID.
5. Determine project-memory profile and language.
6. Identify important canonical artifacts and ambiguous/conflicting versions.
7. Preserve existing structures.
8. Create/augment justified project-memory files in GitHub.
9. Create SOURCES.md unless the project is exceptionally trivial.
10. Create GitHub _ai/infrastructure/, manifest, and applied standard snapshot.
11. Install G2 runtime rules in the canonical GitHub `AGENTS.md`.
12. Create or safely update the local artifact-root `AGENTS.md` bootstrap adapter.
13. Register important artifact paths relative to the artifact root.
14. Perform a basic sync-sanity check.
15. Perform G2 cold-start validation.

## 23. Greenfield bootstrap

1. Ground the new GitHub repository and synchronized local artifact root.
2. Create a stable Project ID.
3. Start with Minimal memory unless known complexity justifies Standard.
4. Create GitHub runtime/infrastructure.
5. Create the local artifact-root `AGENTS.md` bootstrap adapter.
6. Do not invent an artifact subfolder hierarchy before real needs justify it.
7. Add SOURCES.md when artifact tracking begins to matter.
8. Perform sync-sanity and cold-start validation.

## 24. Required G2 runtime rules in canonical GitHub `AGENTS.md`

During bootstrap/migration, install a concise infrastructure-managed section in the canonical GitHub `AGENTS.md` containing at least:

- Scenario: G2;
- Project ID;
- installed standard version/commit when known;
- project-memory profile/language and installed files;
- GitHub repository identity/default branch;
- path to GitHub infrastructure manifest;
- project-memory access may use remote/API/connector operations or a local checkout outside the synchronized artifact root; never place the control-repository clone inside the artifact root;
- the folder identified by the matching local bootstrap `AGENTS.md` is the synchronized canonical artifact root;
- project artifact paths are relative to that root;
- GitHub is canonical for runtime/state; do not duplicate that state locally;
- verify Project ID before substantial work;
- assume artifact synchronization is healthy by default but perform bounded sync-sanity checks before important writes;
- do not silently resolve sync conflicts or overwrite suspicious/stale targets;
- prefer an external/harness temporary workspace outside the synchronized folder when available;
- keep any in-root fallback non-canonical/disposable;
- temporary absolute paths are never canonical;
- preserve existing user artifact structure;
- update and verify GitHub project memory after substantial project-changing work;
- re-read shared GitHub state before writes and reconcile concurrent changes;
- never store secrets/credentials in project memory;
- external infrastructure-standard access is not required for ordinary work.

## 25. Cold-start validation

A fresh capable agent on another machine should be able to start from only the connected synced folder plus repository/network access:

1. read the local artifact-root `AGENTS.md`;
2. identify Project ID and GitHub repository;
3. access/read repository AGENTS.md;
4. restore STATE.md / TASKS.md and relevant project memory;
5. confirm Project ID matches the GitHub manifest;
6. resolve important artifact paths relative to the connected folder;
7. understand temporary-workspace policy;
8. perform a bounded sync-sanity check;
9. continue without the originating chat or external standard repository.

When practical, validate using a genuinely fresh session/machine/harness. Otherwise simulate this startup using only the installed runtime and marker file.

## 26. Completion report

After initialization, repair, or migration, report:

- initialized / brownfield / greenfield classification;
- Project ID;
- project-memory profile/language;
- GitHub repository and artifact root grounded;
- control-repository access mode used/available;
- local bootstrap `AGENTS.md` created/updated/preserved;
- important artifacts registered with relative paths;
- temporary-workspace route available/selected;
- sync-sanity result and any conflict;
- project-memory/infrastructure files created/updated;
- cold-start validation result;
- confirmation that the external standard repository is not needed for ordinary work.

## 27. Minimal invocation

With authorized access to the private standard repository and the synchronized artifact folder already connected:

> Apply project infrastructure scenario **G2** to this synchronized local project folder using GitHub repository <owner/repo> and https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md.

If the local artifact-root `AGENTS.md` already names the repository:

> Read this folder's `AGENTS.md`, restore the G2 project from its GitHub repository, and continue with my request.

Without standard-repository access, provide PROJECT_INFRASTRUCTURE.md, project-infrastructure/COMMON.md, and project-infrastructure/G2_GITHUB_SYNCED_LOCAL_FOLDER.md and ask the same bootstrap request using the provided standard files.

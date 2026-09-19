# Project Infrastructure

**Standard version:** 0.7.4  
**Lifecycle:** Draft  
**Purpose:** Entry point for reusable project-memory and handoff rules across different storage and execution environments.

> Core principle: **project state lives in project files, not in chat history.** Chat history may provide useful context, but it is not the canonical source of truth.

## Version and lifecycle policy

The infrastructure standard is versioned independently from individual projects.

Lifecycle values:

- `Draft` — design is still changing and has not yet completed real-project pilots;
- `Pilot` — validated on representative real projects but still subject to adjustment;
- `Stable` — suitable as the default production standard; breaking changes require deliberate migration guidance.

A project records the standard version and, when available, the exact Git commit/ref used during initialization or migration.

Projects do **not** automatically follow changes on `main`. The installed runtime remains authoritative for ordinary work until the user explicitly requests infrastructure validation, repair, or migration/upgrade.

When upgrading an initialized project:

1. read its infrastructure manifest and installed standard snapshot;
2. read the explicitly selected target standard;
3. compare installed and target behavior;
4. migrate non-destructively according to `COMMON.md` and the active scenario;
5. preserve project-specific rules, state, identifiers, language, canonical-store relationships, and user-owned content;
6. update the manifest and local snapshot only after migration is applied.

### Draft 0.3 compatibility note

L1 0.3 changed the preferred agent-support namespace for new installations from hidden `.ai/` to visible `_ai/`, added Minimal/Standard project-memory profiles, bounded brownfield inspection, task archiving, Git-ignore guidance, cold-start validation, unified record IDs, and an explicit project-memory language policy.

Projects installed under 0.2.x do not rename `.ai/` during ordinary work. Explicit migration may move it to `_ai/` only according to L1 safe-migration rules.

Version 0.3.1 defined Russian (`ru`) as the default project-memory language unless the user explicitly selects another language or the project already has an established project-memory language. Deliverable language does not change project-memory language by itself.

### Draft 0.4 note

Version 0.4.0 added the first fully specified **G1 — GitHub + Google Drive** scenario.

G1 treats GitHub and Drive as complementary canonical stores rather than mirrors: GitHub is the control/state plane for project memory and text/code knowledge, while Google Drive is the artifact plane for native Workspace documents, Office/PDF/media/large-file artifacts. Agents may work connector-native or through optional local/ephemeral materialization, but temporary workspaces are never canonical.

Version **0.4.1** made G1 explicitly **capability-aware**. Each modifying session determines its actual GitHub/Drive/execution read/write capabilities before selecting a workflow. G1 defines an identity-preserving fallback ladder and requires incomplete publication or project-memory synchronization to be reported explicitly.

### Draft 0.5 note

Version **0.5.0** restructures G1 as a scenario family. The universal GitHub + Google Drive rules now live in `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md`; product-specific profiles extend the base. The first profile, `CHATGPT_PROJECT.md`, defines the recommended mapping **1 ChatGPT Project ↔ 1 GitHub repository ↔ 1 Google Drive root folder**, adds Project Instructions as a versioned ChatGPT adapter, and validates bootstrap from a new empty project chat.

### Draft 0.6 note

Version **0.6.0** added **G2 — GitHub + Synced Local Folder**. G2 separates durable project control/state into GitHub while keeping user artifacts in an ordinary local folder synchronized across machines by an external sync system. In 0.6 the local folder used `PROJECT_LINK.md` as its lightweight marker; artifact paths are root-relative, important writes use bounded sync-sanity checks, and temporary execution prefers a harness/local workspace outside the synchronized folder.

### Draft 0.7 note

Version **0.7.0** standardizes `AGENTS.md` as the required vendor-neutral runtime entry point. `CLAUDE.md` is no longer recommended by default; create it only for concrete Claude-specific additions, keeping it thin and linked to canonical `AGENTS.md`. G2 replaces `PROJECT_LINK.md` with a local bootstrap `AGENTS.md`, so Codex, Claude Code 2.1.277+, and other compatible agents can auto-discover the project entry file. Existing G2 0.6 projects migrate explicitly and non-destructively.

Version **0.7.1** is a corrective/pre-pilot patch rather than a feature release. It adds proportional lightweight paths for small tasks, makes managed markers mandatory for infrastructure blocks in mixed-ownership files, fixes the project-memory-language example, replaces G1 capability self-report with observable operation routing, defines G2 control-repository access/write mechanics, scales G2 sync-sanity by task risk, and removes manually maintained mutable file metadata/checksums from ordinary G2 source tracking.

Version **0.7.2** is a deduplication/refactor patch. `COMMON.md` now owns generic bounded discovery/source-registration, the common bootstrap/reconcile flow, and the common `AGENTS.md` runtime baseline. L1/G1/G2 bootstrap, runtime, brownfield, concurrency, cold-start, and completion sections were reduced to scenario-specific deltas. Scenario/profile `Minimal invocation` copies were removed; `PROJECT_INFRASTRUCTURE.md` is the single canonical location for invocation prompts, and README now points to it instead of duplicating commands.

Version **0.7.3** freezes pre-pilot scenario scope to the three implemented Draft scenarios: **L1, G1, and G2**. The unimplemented Y1/R1/H1 placeholders were removed from the active standard and moved to `project-infrastructure/ROADMAP.md` as deferred ideas. They are not reserved scenario commitments; a future real-project gap should first be solved by the smallest suitable common rule, scenario delta, or profile before introducing a new scenario.

Version **0.7.4** temporarily restores a default minimal Claude compatibility adapter during the pre-pilot period: projects keep canonical shared instructions in `AGENTS.md` and, by default, also create a project-level `CLAUDE.md` containing only `@AGENTS.md`. Claude-specific additions may follow the import, but shared rules must not be duplicated. Retiring this adapter later requires an explicit migration.

## Bootstrap contract

This file is the single external entry point for project initialization, infrastructure validation, repair, or migration.

When a user asks an agent to initialize or adapt a project using a scenario ID, the agent must:

1. read this index;
2. read [`project-infrastructure/COMMON.md`](project-infrastructure/COMMON.md);
3. read the selected scenario file;
4. ground/inspect the target project environment and canonical stores;
5. apply the selected scenario completely, including bootstrap, preservation, project-memory, language, validation, runtime, synchronization/materialization, capability, and handoff rules.

The user should not need to repeat scenario details when the agent can access the standard.

If a scenario distinguishes brownfield from greenfield projects, the agent must determine this from the target resources unless the user explicitly overrides it.

## Private-repository and offline bootstrap

The canonical standard repository may be private. A GitHub URL is only a convenient bootstrap entry point for an agent with authorized access.

Do not assume that browser-visible `blob/...` or `raw` URLs grant access to a private repository.

If the bootstrap agent cannot access the standard repository, the user may provide local/offline copies of the required standard files.

For L1:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/L1_LOCAL_FOLDER.md`.

For G1 Base:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md`.

For G1 / ChatGPT Project, also provide:

- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/CHATGPT_PROJECT.md`.

For G2:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/G2_GITHUB_SYNCED_LOCAL_FOLDER.md`.

Treat supplied files exactly as the bootstrap specification and record available version/commit/ref provenance without invention.

After successful bootstrap, access to the external infrastructure-standard repository is not required for ordinary project work.

## Fundamental runtime rule

The external standard is an **installer/upgrader specification, not a permanent runtime dependency**.

Every implemented scenario must leave the initialized project sufficiently self-contained that normal future work can continue from its installed runtime/project-memory and configured canonical stores without access to this repository, the original chat, or the bootstrap agent.

Scenario-specific rules needed during ordinary work must be materialized into the installed project runtime. A scenario may keep a local snapshot of the applied standard for audit/repair/migration, but that snapshot should not be loaded during normal startup.

External-standard access is required again only for explicit initialization, infrastructure validation, repair, or migration/upgrade.

## Scenarios

| ID | Scenario | Status | Use when |
|---|---|---|---|
| **L1** | [Local folder](project-infrastructure/L1_LOCAL_FOLDER.md) | Draft | The project primarily lives in a normal local filesystem folder and the active agent has direct filesystem access. |
| **G1** | [GitHub + Google Drive](project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md) | Draft | One logical project uses a dedicated GitHub repository for project state/text/code and a dedicated Google Drive folder for documents/large artifacts; workflow selection is based on observable available operations and target state, with connectors/browser/local workspaces used only when they safely support the intended operation. |
| **G2** | [GitHub + Synced Local Folder](project-infrastructure/G2_GITHUB_SYNCED_LOCAL_FOLDER.md) | Draft | GitHub is the canonical project control/state plane while a synchronized ordinary local folder is the canonical artifact root; a thin local `AGENTS.md` bootstraps GitHub access, project-memory access is API/connector-first or via a clone outside the sync root, and task checks scale with risk. |

### G1 profiles

- **Base:** [`project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md`](project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md)
- **ChatGPT Project:** [`project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/CHATGPT_PROJECT.md`](project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/CHATGPT_PROJECT.md) — recommended when one ChatGPT Project is intentionally paired with one GitHub repository and one Google Drive root folder. Project Instructions are treated as a versioned product adapter, not as project state.

## Scenario selection rule

Choose the scenario according to **where canonical project state/artifacts live and how active agents access them**, not merely by file type.

If a project combines several environments, start with the closest primary scenario and add only specific required rules from another scenario. Do not duplicate canonical project state between scenarios.

If Yandex Disk, OneDrive, Google Drive for desktop, Syncthing, or another service is used to present the project as a synchronized ordinary local folder, use **G2**. Provider-specific remote/API/MCP behavior is not a current scenario; if a real project later exposes a gap, evaluate it using the roadmap discipline in [`project-infrastructure/ROADMAP.md`](project-infrastructure/ROADMAP.md).

## Deferred ideas

Provider-specific remote storage, remote-only agent access, and stronger multi-agent coordination are intentionally **outside the active pre-pilot scenario set**. See [`project-infrastructure/ROADMAP.md`](project-infrastructure/ROADMAP.md). They should not influence scenario selection unless explicitly reintroduced through a future standard revision.

## Minimal invocation

### L1

With authorized standard-repository access:

> Apply project infrastructure scenario **L1** to this folder using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without standard-repository access, provide the three L1 bootstrap files and use:

> Apply project infrastructure scenario **L1** to this folder using the provided project-infrastructure standard files.

### G1

With authorized standard-repository access:

> Apply project infrastructure scenario **G1** to GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

For the ChatGPT-optimized profile:

> Apply **G1 / ChatGPT Project** to this ChatGPT Project using GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` from `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without standard-repository access, provide the G1 base bootstrap files (`PROJECT_INFRASTRUCTURE.md`, `COMMON.md`, and `G1_GITHUB_GOOGLE_DRIVE/BASE.md`) and use:

> Apply project infrastructure scenario **G1** to GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using the provided project-infrastructure standard files.

For G1 / ChatGPT Project offline bootstrap, also provide `G1_GITHUB_GOOGLE_DRIVE/CHATGPT_PROJECT.md` and use:

> Apply **G1 / ChatGPT Project** to this ChatGPT Project using GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using the provided project-infrastructure standard files.

### G2

With authorized standard-repository access and the synchronized artifact folder already connected:

> Apply project infrastructure scenario **G2** to this synchronized local project folder using GitHub repository `<owner/repo>` and `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

If the local bootstrap `AGENTS.md` is already present:

> Read this folder's `AGENTS.md`, restore the G2 project from its GitHub repository, and continue with my request.

Without standard-repository access, provide `PROJECT_INFRASTRUCTURE.md`, `COMMON.md`, and `G2_GITHUB_SYNCED_LOCAL_FOLDER.md`.

### Already initialized project

> Read `AGENTS.md`, restore the current project context, use the operations actually available in this session, and continue with my request.

No external-standard access should be required for that routine invocation.

A task ID may be added when useful, for example `continue task T-017`.

## Compatibility

The common memory model is tool-agnostic. `AGENTS.md` is the canonical vendor-neutral runtime instruction file. During the current pre-pilot period, create a minimal project-level `CLAUDE.md` containing `@AGENTS.md` as a compatibility adapter; it is never an independent copy of project state. Product-specific additions must remain thin.

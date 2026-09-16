# Project Infrastructure

**Standard version:** 0.4.1  
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

Version **0.4.1** makes G1 explicitly **capability-aware**. Each modifying session must determine its actual GitHub/Drive/execution read/write capabilities before selecting a workflow. G1 now defines an identity-preserving fallback ladder and requires agents to report incomplete publication or project-memory synchronization instead of silently replacing canonical artifacts or claiming completion.

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

For G1:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE.md`.

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
| **G1** | [GitHub + Google Drive](project-infrastructure/G1_GITHUB_GOOGLE_DRIVE.md) | Draft | One logical project uses a dedicated GitHub repository for project state/text/code and a dedicated Google Drive folder for documents/large artifacts; agents may work through connectors, browser/computer use, or optional local/ephemeral workspaces according to actual session capabilities. |
| **Y1** | [GitHub + Yandex Disk](project-infrastructure/Y1_GITHUB_YANDEX.md) | Planned | GitHub stores code/text/project state while documents, CAD, data, or other large artifacts live in Yandex Disk and/or its synchronized local folder. |
| **R1** | [Remote agent](project-infrastructure/R1_REMOTE_AGENT.md) | Planned | The active agent cannot directly access the user's local filesystem and must retrieve required artifacts through connectors, MCP, or remote storage. |
| **H1** | [Hybrid multi-agent](project-infrastructure/H1_HYBRID_MULTI_AGENT.md) | Planned | Several agents/environments cooperate using local materialization, shared project state, validation, and publish-back rules. |

## Scenario selection rule

Choose the scenario according to **where canonical project state/artifacts live and how active agents access them**, not merely by file type.

If a project combines several environments, start with the closest primary scenario and add only specific required rules from another scenario. Do not duplicate canonical project state between scenarios.

## Minimal invocation

### L1

With authorized standard-repository access:

> Apply project infrastructure scenario **L1** to this folder using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without standard-repository access, provide the three L1 bootstrap files and use:

> Apply project infrastructure scenario **L1** to this folder using the provided project-infrastructure standard files.

### G1

With authorized standard-repository access:

> Apply project infrastructure scenario **G1** to GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without standard-repository access, provide the three G1 bootstrap files and use:

> Apply project infrastructure scenario **G1** to GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` using the provided project-infrastructure standard files.

### Already initialized project

> Read `AGENTS.md`, restore the current project context, check the capabilities available in this session, and continue with my request.

No external-standard access should be required for that routine invocation.

A task ID may be added when useful, for example `continue task T-017`.

## Compatibility

The common memory model is tool-agnostic. Product-specific entry files or workspace instructions should be thin adapters pointing to the installed project runtime rather than independent copies of project state.

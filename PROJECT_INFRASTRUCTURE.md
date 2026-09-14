# Project Infrastructure

**Standard version:** 0.3.0  
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

Projects do **not** automatically follow changes on `main`. The installed local runtime remains authoritative for ordinary work until the user explicitly requests infrastructure validation, repair, or migration/upgrade.

When upgrading an initialized project:

1. read its local infrastructure manifest and installed standard snapshot;
2. read the explicitly selected target standard;
3. compare installed and target behavior;
4. migrate non-destructively according to `COMMON.md` and the active scenario;
5. preserve project-specific rules, state, identifiers, and user-owned content;
6. update the manifest and local snapshot only after the migration is applied.

### Draft 0.3 compatibility note

L1 0.3 changes the preferred agent-support namespace for **new installations** from hidden `.ai/` to visible `_ai/`, adds Minimal/Standard project-memory profiles, bounded brownfield inspection, task archiving, Git-ignore guidance, cold-start validation, and unified record IDs.

Projects installed under 0.2.x do not rename `.ai/` during ordinary work. An explicit migration may move it to `_ai/` only according to the safe migration rules in L1; otherwise the installed namespace remains valid and must be recorded in the manifest/runtime instructions.

## Bootstrap contract

This file is the single external entry point for project initialization, infrastructure validation, repair, or migration.

When a user asks an agent to initialize or adapt a project using a scenario ID, the agent must:

1. read this index;
2. read [`project-infrastructure/COMMON.md`](project-infrastructure/COMMON.md);
3. read the selected scenario file;
4. inspect the target project environment;
5. apply the selected scenario completely, including its bootstrap, preservation, project-memory, validation, local-runtime, and handoff rules.

The user should **not** need to repeat scenario details in the prompt or enumerate the linked files manually when the agent can access this repository.

If a scenario distinguishes brownfield from greenfield projects, the agent must make that determination from the target folder and follow the scenario rules unless the user explicitly overrides it.

## Private-repository and offline bootstrap

The canonical standard repository may be private. A GitHub URL is therefore only a convenient bootstrap entry point for an agent that has authorized access to the repository.

Do not assume that a browser-visible `blob/...` URL or a `raw` URL grants access to a private repository.

If the bootstrap agent cannot access the canonical repository, the user may provide local/offline copies of the required standard files instead. For Scenario L1 the required bootstrap set is:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/L1_LOCAL_FOLDER.md`.

The agent should treat those supplied files exactly as the external bootstrap specification, record the version/commit/ref available in them or supplied alongside them, and then install the same self-contained local runtime and snapshot required by the scenario.

After successful bootstrap, neither GitHub access nor the externally supplied bootstrap copies are required for ordinary project work.

## Fundamental runtime rule

The external standard is an **installer/upgrader specification, not a permanent runtime dependency**.

Every implemented scenario must leave the initialized project sufficiently self-contained that normal future work can continue from the project's own `AGENTS.md` and project-memory files without access to this repository, the original chat, or the bootstrap agent.

Scenario-specific rules that remain relevant during ordinary work must therefore be materialized locally during bootstrap/migration. A scenario may also keep a local snapshot of the applied standard for audit, repair, and migration, but that snapshot should not be loaded during normal startup.

External-standard access is required again only when the user explicitly requests initialization, infrastructure validation, repair, or migration/upgrade.

## Scenarios

| ID | Scenario | Status | Use when |
|---|---|---|---|
| **L1** | [Local folder](project-infrastructure/L1_LOCAL_FOLDER.md) | Draft | The project primarily lives in a normal local filesystem folder and the active agent has direct filesystem access. |
| **G1** | [GitHub + Google Drive](project-infrastructure/G1_GITHUB_GOOGLE_DRIVE.md) | Planned | GitHub is the canonical store for code/text/project state while documents and large artifacts live in Google Drive. |
| **Y1** | [GitHub + Yandex Disk](project-infrastructure/Y1_GITHUB_YANDEX.md) | Planned | GitHub stores code/text/project state while documents, CAD, data, or other large artifacts live in Yandex Disk and/or its synchronized local folder. |
| **R1** | [Remote agent](project-infrastructure/R1_REMOTE_AGENT.md) | Planned | The active agent cannot directly access the user's local filesystem and must retrieve required artifacts through connectors, MCP, or remote storage. |
| **H1** | [Hybrid multi-agent](project-infrastructure/H1_HYBRID_MULTI_AGENT.md) | Planned | Several agents/environments cooperate using local materialization, shared project state, validation, and publish-back rules. |

## Scenario selection rule

Choose the scenario according to **where the canonical project state lives and how the active agent accesses working files**, not merely by file type.

If a project combines several environments, start with the closest primary scenario and add only the specific rules needed from another scenario. Do not duplicate canonical project state between scenarios.

## Minimal invocation

When the agent has access to the canonical repository:

> Apply project infrastructure scenario **L1** to this folder using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

That is intentionally sufficient. The bootstrap agent must retrieve the linked common/scenario instructions and install a self-contained local runtime.

When the agent has no access to the private repository, provide the three L1 bootstrap files listed above and use:

> Apply project infrastructure scenario **L1** to this folder using the provided project-infrastructure standard files.

For an already initialized project:

> Read `AGENTS.md`, restore the current project context, and continue with my request.

No GitHub-standard access should be required for that routine invocation.

A task ID may be added when useful, for example `continue task T-017`.

## Compatibility

The common memory model is tool-agnostic. Product-specific entry files or workspace instructions should be thin adapters pointing to the locally installed project runtime rather than independent copies of project state.

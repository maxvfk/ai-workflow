# Project Infrastructure

**Status:** Working index  
**Purpose:** Entry point for reusable project-memory and handoff rules across different storage and execution environments.

> Core principle: **project state lives in project files, not in chat history.** Chat history may provide useful context, but it is not the canonical source of truth.

## How to use this standard

1. Read [`project-infrastructure/COMMON.md`](project-infrastructure/COMMON.md).
2. Select the scenario matching the project's actual storage and execution environment.
3. Read only that scenario file unless another scenario is directly relevant.
4. Initialize or update the project according to the selected scenario.

This keeps startup context small: agents do not need to load rules for unrelated storage systems.

## Scenarios

| ID | Scenario | Status | Use when |
|---|---|---|---|
| **L1** | [Local folder](project-infrastructure/L1_LOCAL_FOLDER.md) | Implemented | The project primarily lives in a normal local filesystem folder and the active agent has direct filesystem access. |
| **G1** | [GitHub + Google Drive](project-infrastructure/G1_GITHUB_GOOGLE_DRIVE.md) | Planned | GitHub is the canonical store for code/text/project state while documents and large artifacts live in Google Drive. |
| **Y1** | [GitHub + Yandex Disk](project-infrastructure/Y1_GITHUB_YANDEX.md) | Planned | GitHub stores code/text/project state while documents, CAD, data, or other large artifacts live in Yandex Disk and/or its synchronized local folder. |
| **R1** | [Remote agent](project-infrastructure/R1_REMOTE_AGENT.md) | Planned | The active agent cannot directly access the user's local filesystem and must retrieve required artifacts through connectors, MCP, or remote storage. |
| **H1** | [Hybrid multi-agent](project-infrastructure/H1_HYBRID_MULTI_AGENT.md) | Planned | Several agents/environments cooperate using local materialization, shared project state, validation, and publish-back rules. |

## Scenario selection rule

Choose the scenario according to **where the canonical project state lives and how the active agent accesses working files**, not merely by file type.

If a project combines several environments, start with the closest primary scenario and add only the specific rules needed from another scenario. Do not duplicate canonical project state between scenarios.

## Invocation examples

New local-folder project:

> Read `PROJECT_INFRASTRUCTURE.md`, then `project-infrastructure/COMMON.md` and `project-infrastructure/L1_LOCAL_FOLDER.md`. Initialize this project from the existing files. Do not invent missing facts.

Existing initialized project:

> Read `AGENTS.md`, restore the current project context, and continue task `T-XXX`.

## Compatibility

The common memory model is tool-agnostic. Product-specific entry files or workspace instructions should be thin adapters pointing to the project infrastructure rather than independent copies of project state.

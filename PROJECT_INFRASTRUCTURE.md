# Project Infrastructure

**Status:** Working index  
**Purpose:** Entry point for reusable project-memory and handoff rules across different storage and execution environments.

> Core principle: **project state lives in project files, not in chat history.** Chat history may provide useful context, but it is not the canonical source of truth.

## Bootstrap contract

This file is the single external entry point for project initialization.

When a user asks an agent to initialize or adapt a project using a scenario ID, the agent must:

1. read this index;
2. read [`project-infrastructure/COMMON.md`](project-infrastructure/COMMON.md);
3. read the selected scenario file;
4. inspect the target project environment;
5. apply the selected scenario completely, including its bootstrap, preservation, project-memory, validation, and handoff rules.

The user should **not** need to repeat scenario details in the prompt or enumerate the linked files manually.

If a scenario distinguishes brownfield from greenfield projects, the agent must make that determination from the target folder and follow the scenario rules unless the user explicitly overrides it.

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

## Minimal invocation

For a new or existing local-folder project:

> Apply project infrastructure scenario **L1** to this folder using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

That is intentionally sufficient. The agent must follow the Bootstrap contract above and retrieve the linked common/scenario instructions itself.

For an already initialized project:

> Read `AGENTS.md`, restore the current project context, and continue with my request.

A task ID may be added when useful, for example `continue task T-017`.

## Compatibility

The common memory model is tool-agnostic. Product-specific entry files or workspace instructions should be thin adapters pointing to the project infrastructure rather than independent copies of project state.

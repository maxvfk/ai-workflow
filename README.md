# ai-workflow

Shared AI workflow notes, routing rules, and project-infrastructure standards.

## Files

- `AI_MODEL_ROUTING_MEMO.md` — stable routing rules for choosing vendor, environment, model, and effort.
- `AI_MODEL_CURRENT_STATE.md` — refreshed snapshot of current ChatGPT/Claude models, limits, benchmark evidence, and practical recommendations.
- `PROJECT_INFRASTRUCTURE.md` — canonical entry point for project-infrastructure bootstrap and migration.
- `project-infrastructure/COMMON.md` — common project-memory/runtime rules used by all scenarios.
- `project-infrastructure/L1_LOCAL_FOLDER.md` — **Draft** local-folder scenario.
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md` — **Draft** base GitHub + Google Drive scenario.
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/CHATGPT_PROJECT.md` — **Draft** ChatGPT Project profile for G1.
- `project-infrastructure/G2_GITHUB_SYNCED_LOCAL_FOLDER.md` — **Draft** GitHub + synchronized local artifact-folder scenario.
- `project-infrastructure/ROADMAP.md` — deferred ideas intentionally outside the active scenario set.
- `skills/model-router/SKILL.md` — reusable Agent Skill for applying the routing memo/current-state snapshot.

## Project infrastructure

Current standard version: **0.7.4**  
Lifecycle: **Draft**

`PROJECT_INFRASTRUCTURE.md` is the **single canonical entry point** for scenario selection, bootstrap/offline requirements, and invocation prompts. README intentionally does not duplicate those commands.

Core conventions:

- project state lives in project files/canonical stores, not chat history;
- `AGENTS.md` is the vendor-neutral runtime instruction convention;
- `CLAUDE.md` is temporarily created by default as a one-line `@AGENTS.md` compatibility adapter; `AGENTS.md` remains the only shared source of truth;
- project-memory prose defaults to Russian (`ru`) unless another language is explicitly selected/established;
- `COMMON.md` owns shared runtime, preservation, bounded-discovery, concurrency, proportional-work, security, and cold-start rules;
- scenario files contain only environment/storage-specific deltas.

Implemented Draft scenarios — and the complete active pre-pilot scenario set — are:

- **L1 — Local Folder:** project runtime/memory and artifacts live in one normal local folder; existing user structure is preserved.
- **G1 — GitHub + Google Drive:** GitHub is the control/state plane and Drive is the artifact plane; G1 has a ChatGPT Project profile.
- **G2 — GitHub + Synced Local Folder:** GitHub is the control/state plane, a synchronized ordinary local folder is the artifact root, and control-repo clones never live inside the sync root.

Provider-specific remote storage, remote-only agents, and stronger multi-agent coordination are deferred ideas in `project-infrastructure/ROADMAP.md`, not active/planned scenarios.

For bootstrap, migration, or the exact start prompt, read `PROJECT_INFRASTRUCTURE.md`.

## Model routing

For an important task, ask:

`Используй model-router для этой задачи: [описание задачи]`

If the skill is not installed natively in the current product, ask the agent to read `skills/model-router/SKILL.md` from this repository and follow it.

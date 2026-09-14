# ai-workflow

Shared AI workflow notes, routing rules, and project-infrastructure standards.

## Files

- `AI_MODEL_ROUTING_MEMO.md` — stable routing rules for choosing vendor, environment, model, and effort.
- `AI_MODEL_CURRENT_STATE.md` — refreshed snapshot of current ChatGPT/Claude models, limits, benchmark evidence, and practical recommendations.
- `PROJECT_INFRASTRUCTURE.md` — canonical entry point for project-infrastructure bootstrap and migration.
- `project-infrastructure/COMMON.md` — common project-memory/runtime rules used by all scenarios.
- `project-infrastructure/L1_LOCAL_FOLDER.md` — **Draft** local-folder scenario.
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE.md` — planned GitHub + Google Drive scenario.
- `project-infrastructure/Y1_GITHUB_YANDEX.md` — planned GitHub + Yandex Disk scenario.
- `project-infrastructure/R1_REMOTE_AGENT.md` — planned remote-agent scenario.
- `project-infrastructure/H1_HYBRID_MULTI_AGENT.md` — planned hybrid multi-agent scenario.
- `skills/model-router/SKILL.md` — reusable Agent Skill for applying the routing memo/current-state snapshot.

## Project infrastructure

Current standard version: **0.3.0**  
Lifecycle: **Draft**

The external standard is used for initialization, validation, repair, and migration. After bootstrap, a project is expected to be self-contained and ordinary work should continue from its local `AGENTS.md` and installed project-memory files without GitHub access.

L1 is brownfield-first, supports Minimal and Standard project-memory profiles, uses visible `_ai/` as the preferred support namespace for new installations, and preserves older installed `.ai/` namespaces until an explicit migration.

### L1 bootstrap

If the agent has authorized access to the private repository:

`Apply project infrastructure scenario L1 to this folder using https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md.`

If the agent cannot access the private repository, provide local copies of:

- `PROJECT_INFRASTRUCTURE.md`
- `project-infrastructure/COMMON.md`
- `project-infrastructure/L1_LOCAL_FOLDER.md`

Then ask:

`Apply project infrastructure scenario L1 to this folder using the provided project-infrastructure standard files.`

For an already initialized project:

`Read AGENTS.md, restore the current project context, and continue with my request.`

Projects do not automatically follow changes on `main`; migration to a newer infrastructure version is explicit and version/commit-aware.

## Model routing

For an important task, ask:

`Используй model-router для этой задачи: [описание задачи]`

If the skill is not installed natively in the current product, ask the agent to read `skills/model-router/SKILL.md` from this repository and follow it.

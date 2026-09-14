# ai-workflow

Shared AI workflow notes, routing rules and current model state.

## Files

- `AI_MODEL_ROUTING_MEMO.md` — stable routing rules for choosing vendor, environment, model and effort.
- `AI_MODEL_CURRENT_STATE.md` — regularly refreshed snapshot of current ChatGPT/Claude models, limits, benchmark evidence and practical recommendations.
- `PROJECT_INFRASTRUCTURE_STANDARD.md` — reusable project-memory and handoff standard. It defines the common `AGENTS.md` / `PROJECT.md` / `STATE.md` / `TASKS.md` / `ASSUMPTIONS.md` / `SOURCES.md` infrastructure and scenario-specific setup rules. Scenario L1 covers projects stored in a local folder.
- `skills/model-router/SKILL.md` — reusable Agent Skill that applies the routing memo and current-state snapshot to a concrete task.

## Usage

### Simple chat invocation

For an important task, ask:

`Используй model-router для этой задачи: [описание задачи]`

If the skill is not installed natively in the current product, ask the chat to read `skills/model-router/SKILL.md` from this repository and follow it.

### Project infrastructure

For a new project, ask the agent to read `PROJECT_INFRASTRUCTURE_STANDARD.md` and apply the scenario matching the storage/work environment.

For a local-folder project:

`Read PROJECT_INFRASTRUCTURE_STANDARD.md and apply Scenario L1 to this project folder.`

### Freshness behavior

The router reads `AI_MODEL_ROUTING_MEMO.md` and `AI_MODEL_CURRENT_STATE.md`, then performs a short delta-check for developments since the last update before recommending a workflow when the decision is important or non-obvious.

The intended routing output is: vendor → product surface → model → effort, with relevant benchmark evidence, usage economics, and optional cross-vendor adversarial review.

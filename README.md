# ai-workflow

Personal knowledge and workflow repository for organizing work with AI agents and AI harnesses: infrastructure standards, model routing, reusable skills, product-specific guidance, operational notes, lessons learned, and experiments.

<!-- project-infrastructure:start -->
Agent runtime: [`AGENTS.md`](AGENTS.md). Current project state: [`STATE.md`](STATE.md). Active/next work: [`TASKS.md`](TASKS.md).
<!-- project-infrastructure:end -->

## Repository map

- **Project Infrastructure** — `PROJECT_INFRASTRUCTURE.md` and `project-infrastructure/`: project memory, canonical stores, bootstrap, handoff and runtime standards.
- **Model routing** — `AI_MODEL_ROUTING_MEMO.md`, `AI_MODEL_CURRENT_STATE.md`, and the reusable `skills/model-router/` skill.
- **Reusable skills** — `skills/`. Read `skills/README.md` for the current index and placement rules.
- **Harness/product-specific guidance** — thematic directories such as `claude-desktop/` and `codex-cloud/`. Read their local `README.md` files for Claude Desktop and Codex Cloud guidance.
- **Notes, rules, errors, experiments and lessons learned** — keep them with the thematic area they belong to; create a new top-level category only when a durable independent class of material actually emerges.

Project Infrastructure has its own version. That version does **not** version the whole repository or automatically version model-routing, skills, harness-specific guidance, or other areas unless an explicit dependency says otherwise.

## Project infrastructure

Current standard version: **0.8.10**  
Lifecycle: **Draft**

`PROJECT_INFRASTRUCTURE.md` is the **single canonical entry point** for scenario selection, bootstrap/offline requirements, and invocation prompts. README intentionally does not duplicate those commands.

Core conventions:

- project state lives in project files/canonical stores, not chat history;
- `AGENTS.md` is the vendor-neutral runtime instruction convention;
- `CLAUDE.md` is temporarily created by default as a one-line `@AGENTS.md` compatibility adapter; `AGENTS.md` remains the only shared source of truth;
- project-memory prose defaults to Russian (`ru`) unless another language is explicitly selected/established;
- `COMMON.md` owns shared runtime, preservation, bounded-discovery, concurrency, proportional-work, canonical-target-first tool routing, security, and cold-start rules;
- scenario files contain only environment/storage-specific deltas.
- small personal multi-project workspaces may use one optional `PROJECTS/PROJECTS.md` catalog; projects remain authoritative, organizational group folders remain plain folders by default, and cross-project dependencies use stable Project IDs.
- a workspace may expose the whole `PROJECTS/` tree while one project remains active; sibling/other projects are external read-only sources by default, and `PROJECTS.md` is only a resolver/catalog, not a combined runtime.
- users, domain applications, and delegated/local agents may edit canonical artifacts directly; project memory can be reconciled later through an explicit bounded refresh rather than requiring the main orchestrator for every small artifact change.
- a dedicated G2 Project Registry may maintain `PROJECTS/PROJECTS.md`; its GitHub repo owns runtime/state, while the workspace root gets no parent `AGENTS.md`, and child projects remain authoritative/read-only during registry maintenance.
- ordinary G2 local/delegated agents without GitHub may perform explicitly bounded artifact-only tasks from sufficient local/user context and leave `_LOCAL_AGENT_REPORT.md` near the changed work for later full-access reconciliation; they do not create substitute project memory or claim full project restoration.
- G2 may optionally enable a complementary control-plane-only fallback for GitHub-visible/cloud agents without artifact-root access: canonical project memory is read-only by default, handoff uses `_ai/inbox/`, selected text artifacts may be exposed through bounded read-only `_ai/snapshots/`, and an external incoming artifact area is configured only when the user actually needs one.
- multi-project workspaces keep one active project by default: registry-owned catalogs are updated through verified handoffs rather than child direct writes, important cross-project dependencies use Project ID + source-relative path as durable identity, and auto-loaded sibling instructions never expand write scope.
- G2 operational hardening distinguishes exact-content verified redundant/stale copies from unresolved conflicts, preserves nontrivial artifact-only build helpers only as minimal `_LOCAL_AGENT_HANDOFF/` staging, and limits temp-leftover hygiene to brownfield/migration events.
- common small clarifications standardize new Project ID naming, align bootstrap prose with project-memory language, label cold-start validation strength, and require persisted-result verification for escape-sensitive programmatic text writes.

Implemented Draft scenarios — and the complete active pre-pilot scenario set — are:

- **G0 — GitHub Repository:** one GitHub repo is the canonical runtime/state and ordinary Git-artifact store; local clones are access paths.
- **L1 — Local Folder:** project runtime/memory and artifacts live in one normal local folder; existing user structure is preserved.
- **G1 — GitHub + Google Drive:** GitHub is the control/state plane and Drive is the artifact plane; G1 has a ChatGPT Project profile.
- **G2 — GitHub + Synced Local Folder:** GitHub is the control/state plane, a synchronized ordinary local folder is the artifact root, and control-repo clones never live inside the sync root.

Provider-specific remote-storage scenarios and stronger multi-agent coordination are deferred ideas in `project-infrastructure/ROADMAP.md`, not active/planned scenarios. G2 control-plane-only access is handled as a bounded fallback inside G2 rather than as a separate remote-only scenario.

For bootstrap, migration, or the exact start prompt, read `PROJECT_INFRASTRUCTURE.md`.

## Model routing

For an important task, ask:

`Используй model-router для этой задачи: [описание задачи]`

If the skill is not installed natively in the current product, ask the agent to read `skills/model-router/SKILL.md` from this repository and follow it.

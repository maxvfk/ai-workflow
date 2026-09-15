# ai-workflow

Shared AI workflow notes, routing rules, and project-infrastructure standards.

## Files

- `AI_MODEL_ROUTING_MEMO.md` — stable routing rules for choosing vendor, environment, model, and effort.
- `AI_MODEL_CURRENT_STATE.md` — refreshed snapshot of current ChatGPT/Claude models, limits, benchmark evidence, and practical recommendations.
- `PROJECT_INFRASTRUCTURE.md` — canonical entry point for project-infrastructure bootstrap and migration.
- `project-infrastructure/COMMON.md` — common project-memory/runtime rules used by all scenarios.
- `project-infrastructure/L1_LOCAL_FOLDER.md` — **Draft** local-folder scenario.
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE.md` — **Draft** GitHub + Google Drive scenario.
- `project-infrastructure/Y1_GITHUB_YANDEX.md` — planned GitHub + Yandex Disk scenario.
- `project-infrastructure/R1_REMOTE_AGENT.md` — planned remote-agent scenario.
- `project-infrastructure/H1_HYBRID_MULTI_AGENT.md` — planned hybrid multi-agent scenario.
- `skills/model-router/SKILL.md` — reusable Agent Skill for applying the routing memo/current-state snapshot.

## Project infrastructure

Current standard version: **0.4.0**  
Lifecycle: **Draft**

The external standard is used for initialization, validation, repair, and migration. After bootstrap, a project is expected to use its installed runtime and canonical stores without requiring the external standard repository for ordinary work.

Project-memory prose defaults to **Russian (`ru`)** unless the user explicitly selects another language or an existing project already has an established project-memory language. Deliverable language does not automatically change project-memory language; filenames, record IDs, and controlled status values remain in their defined English forms.

### L1 — Local folder

L1 is brownfield-first, supports Minimal and Standard project-memory profiles, uses visible `_ai/` as the preferred support namespace for new installations, and preserves older installed `.ai/` namespaces until explicit migration.

With authorized access to the private standard repository:

`Apply project infrastructure scenario L1 to this folder using https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md.`

Without standard-repository access, provide local copies of:

- `PROJECT_INFRASTRUCTURE.md`
- `project-infrastructure/COMMON.md`
- `project-infrastructure/L1_LOCAL_FOLDER.md`

Then ask:

`Apply project infrastructure scenario L1 to this folder using the provided project-infrastructure standard files.`

### G1 — GitHub + Google Drive

G1 treats GitHub and Google Drive as complementary canonical stores rather than mirrors:

- GitHub is the project control/state plane for project memory, text/code knowledge, plans, and decisions;
- Google Drive is the artifact plane for native Docs/Sheets/Slides, Office/PDF/media/large-file artifacts;
- connector-native work is preferred for discovery and small addressed edits;
- local or ephemeral materialization is optional for iterative/heavy work and is never canonical;
- publish-back and verification must complete before project state marks the work complete.

With authorized access to the private standard repository:

`Apply project infrastructure scenario G1 to GitHub repository <owner/repo> and Google Drive folder <folder URL or ID> using https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md.`

Without standard-repository access, provide local copies of:

- `PROJECT_INFRASTRUCTURE.md`
- `project-infrastructure/COMMON.md`
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE.md`

Then ask:

`Apply project infrastructure scenario G1 to GitHub repository <owner/repo> and Google Drive folder <folder URL or ID> using the provided project-infrastructure standard files.`

### Already initialized project

`Read AGENTS.md, restore the current project context, and continue with my request.`

Projects do not automatically follow changes on `main`; migration to a newer infrastructure version is explicit and version/commit-aware.

## Model routing

For an important task, ask:

`Используй model-router для этой задачи: [описание задачи]`

If the skill is not installed natively in the current product, ask the agent to read `skills/model-router/SKILL.md` from this repository and follow it.

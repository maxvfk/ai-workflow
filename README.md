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
- `project-infrastructure/Y1_GITHUB_YANDEX.md` — planned GitHub + Yandex Disk scenario.
- `project-infrastructure/R1_REMOTE_AGENT.md` — planned remote-agent scenario.
- `project-infrastructure/H1_HYBRID_MULTI_AGENT.md` — planned hybrid multi-agent scenario.
- `skills/model-router/SKILL.md` — reusable Agent Skill for applying the routing memo/current-state snapshot.

## Project infrastructure

Current standard version: **0.7.1**  
Lifecycle: **Draft**

The external standard is used for initialization, validation, repair, and migration. After bootstrap, a project is expected to use its installed runtime and canonical stores without requiring the external standard repository for ordinary work.

`AGENTS.md` is the required vendor-neutral runtime entry point. `CLAUDE.md` is optional and should exist only for concrete Claude-specific or compatibility requirements; when used, keep it thin, explicitly import/point to `AGENTS.md`, and avoid duplicating shared rules.

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

G1 is now a scenario family: `BASE.md` contains vendor-independent canonical-store/materialization/synchronization rules, while product profiles add only environment-specific bootstrap behavior.


G1 treats GitHub and Google Drive as complementary canonical stores rather than mirrors:

- GitHub is the project control/state plane for project memory, text/code knowledge, plans, and decisions;
- Google Drive is the artifact plane for native Docs/Sheets/Slides, Office/PDF/media/large-file artifacts;
- each modifying session selects workflows from observable available operations and target/revision state instead of asking the model to self-report capabilities;
- connector/API-native work is preferred when it safely preserves canonical identity;
- local/ephemeral materialization or browser/computer use may be selected when appropriate, but temporary workspaces are never canonical;
- a safe fallback ladder prevents a missing in-place edit operation from being emulated by silently replacing the canonical artifact;
- publish-back, verification, and GitHub project-memory synchronization must complete before project-changing work is considered fully synchronized;
- if publication or synchronization cannot be completed, the remaining step is reported explicitly as pending.

With authorized access to the private standard repository:

`Apply project infrastructure scenario G1 to GitHub repository <owner/repo> and Google Drive folder <folder URL or ID> using https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md.`

Without standard-repository access, provide local copies of:

- `PROJECT_INFRASTRUCTURE.md`
- `project-infrastructure/COMMON.md`
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md`

Then ask:

`Apply project infrastructure scenario G1 to GitHub repository <owner/repo> and Google Drive folder <folder URL or ID> using the provided project-infrastructure standard files.`

For a ChatGPT-only project, use the profile in `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/CHATGPT_PROJECT.md` and bootstrap with:

`Apply G1 / ChatGPT Project to this ChatGPT Project using GitHub repository <owner/repo> and Google Drive folder <folder URL or ID> from https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md.`

### G2 — GitHub + Synced Local Folder

G2 keeps durable project runtime/state in GitHub while the user's normal local project folder is the canonical artifact root and is synchronized across machines by an external sync system. The artifact root uses a thin local `AGENTS.md` bootstrap adapter that points to the canonical GitHub runtime; project artifact paths are stored relative to that root. Small project-memory operations prefer authenticated GitHub API/connector access; a local checkout is used only when useful and must stay outside the synchronized artifact root. Small edits use proportional target-level checks; the full publish/promote transaction is reserved for substantial or risk-bearing work.

Use G2 when Yandex Disk, OneDrive, Google Drive for desktop, Syncthing, NAS/cloud sync, or similar tooling is acting primarily as a transparent local-folder synchronization layer.

Bootstrap:

`Apply project infrastructure scenario G2 to this synchronized local project folder using GitHub repository <owner/repo> and https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md.`

On another machine, once the synchronized folder is available:

`Read this folder's AGENTS.md, restore the G2 project from its GitHub repository, and continue with my request.`

### Already initialized project

`Read AGENTS.md, restore the current project context, check the capabilities available in this session, and continue with my request.`

Projects do not automatically follow changes on `main`; migration to a newer infrastructure version is explicit and version/commit-aware.

## Model routing

For an important task, ask:

`Используй model-router для этой задачи: [описание задачи]`

If the skill is not installed natively in the current product, ask the agent to read `skills/model-router/SKILL.md` from this repository and follow it.

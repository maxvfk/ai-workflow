# Scenario L1 — Local Folder

**Status:** Implemented  
**Depends on:** [`COMMON.md`](COMMON.md)

Use this scenario when the project primarily lives in a normal local filesystem folder and the active agent has direct access to it.

## Goal

The local folder is the working environment and default canonical location for project memory. A new agent should be able to read the project-memory files defined in `COMMON.md`, locate relevant artifacts, and continue without relying on previous chat history.

No GitHub, Google Drive, Yandex Disk, MCP, or connector is required by this scenario.

## Recommended structure

```text
Project-X/
├── README.md
├── AGENTS.md
├── PROJECT.md
├── STATE.md
├── TASKS.md
├── ASSUMPTIONS.md
├── SOURCES.md
├── docs/
│   ├── decisions/
│   ├── plans/
│   │   ├── active/
│   │   └── completed/
│   ├── research/
│   └── methodology/
├── data/
├── calculations/
├── src/
└── outputs/
```

Only create directories that match the real project. Engineering projects may instead need directories such as `cad/`, `experiments/`, `references/`, or `reports/`.

## Source locations

For artifacts inside the project, prefer relative paths in `SOURCES.md` so the folder remains portable between computers.

Example:

```markdown
## S-001 — Final application
Type: authoritative document
Path: `references/application_final.docx`
Canonical: yes
```

Use an absolute path only when an important source necessarily lives outside the project folder, and document that dependency.

## Local working rules

- Prefer direct filesystem access when the agent can access the project locally.
- Use targeted listing, search, bounded reads, and appropriate document/data tools instead of loading whole large files into model context.
- Keep temporary and derived files separate from canonical artifacts, for example under `.work/`, `tmp/`, or `outputs/drafts/`.
- Treat raw source or experimental data as immutable by default. When useful, separate `data/raw/` from `data/processed/`.
- Register important binary artifacts in `SOURCES.md`.
- Preserve linked/dependent file structures for CAD and similar applications; use application-native packaging mechanisms when appropriate.

## Git and backup

Git is optional in Scenario L1. If enabled, use it where version history is useful for text/code/project-memory files, but do not automatically commit large binaries, CAD, generated outputs, or large datasets.

If GitHub later becomes the canonical remote location for project state, reassess the project against a GitHub-based scenario.

Backup or synchronization is strongly recommended when the local folder is canonical, but the backup copy must not become a competing canonical copy.

## Bootstrap procedure

When initializing a project with Scenario L1:

1. Read `COMMON.md` and this scenario.
2. Inspect the existing folder without unnecessarily moving or deleting files.
3. Create or complete the core files defined in `COMMON.md`: `README.md`, `AGENTS.md`, `PROJECT.md`, `STATE.md`, `TASKS.md`, `ASSUMPTIONS.md`, and `SOURCES.md`.
4. Create decision and plan directories when the project is substantial enough to benefit from them.
5. Add domain-specific directories only when justified by existing content.
6. Populate project-memory files from evidence already present in the project.
7. Mark missing information explicitly as unknown, assumption, or task rather than guessing.
8. Register important artifacts in `SOURCES.md`, preferably with relative paths.
9. Summarize the current state in `STATE.md` and supported next actions in `TASKS.md`.
10. Verify that a fresh agent can continue by following `AGENTS.md` without reading the originating chat.

## Invocation

New project:

> Read `PROJECT_INFRASTRUCTURE.md`, `project-infrastructure/COMMON.md`, and `project-infrastructure/L1_LOCAL_FOLDER.md`. Apply Scenario L1 to this project and populate the project-memory infrastructure from existing evidence.

Existing project:

> Read `AGENTS.md`, restore the current project context, and continue task `T-XXX`.

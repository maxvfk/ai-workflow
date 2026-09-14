# Scenario L1 — Local Folder

**Status:** Implemented  
**Depends on:** [`COMMON.md`](COMMON.md)

Use this scenario when the project primarily lives in a normal local filesystem folder and the active agent has direct access to it.

## Goal

The local folder is the working environment and default canonical location for project memory. A new agent should be able to read the project-memory files defined in `COMMON.md`, understand the existing folder structure, locate relevant artifacts, and continue without relying on previous chat history.

No GitHub, Google Drive, Yandex Disk, MCP, or connector is required by this scenario.

## Brownfield-first rule

Most L1 projects are expected to be **existing user-maintained folders**, not empty folders created for an agent.

Therefore, the default behavior is:

> **Adapt the project-memory infrastructure to the existing folder. Do not reorganize the user's files to match a generic template.**

During initialization, an agent must not move, rename, regroup, convert, or otherwise reorganize existing user files or directories unless the user explicitly requests that change.

This rule is especially important for:

- DOCX/XLSX files with links or embedded objects;
- CAD assemblies and dependent parts;
- MATLAB/Python projects using relative paths;
- established report, experiment, reference, or archive structures;
- files used by external applications or other people.

If the existing structure is inconvenient, document it and propose a reorganization separately rather than silently performing one.

## Recommended brownfield structure

For an existing project, preserve the user's current tree and add only a small project-memory layer plus an agent-owned namespace:

```text
Existing-Project/
├── [existing user folders and files — keep in place]
│   ├── *.docx / *.pdf / *.xlsx
│   ├── reports/
│   ├── experiments/
│   ├── CAD/
│   └── ...
│
├── README.md
├── AGENTS.md
├── PROJECT.md
├── STATE.md
├── TASKS.md
├── ASSUMPTIONS.md
├── SOURCES.md
│
└── .ai/
    ├── plans/
    │   ├── active/
    │   └── completed/
    ├── decisions/
    ├── research/
    ├── work/
    └── generated/
```

The root Markdown files are intentionally visible at project root so a new agent can discover the project entry points immediately.

The `.ai/` directory is for **agent-owned support material**, not for relocating the user's original project files.

### `.ai/` directory roles

- `.ai/plans/` — plans for complex or multi-session work.
- `.ai/decisions/` — decision records whose rationale may matter later.
- `.ai/research/` — intermediate research notes and evidence syntheses.
- `.ai/work/` — temporary or disposable working files and intermediate processing artifacts.
- `.ai/generated/` — generated deliverables that have not yet been reviewed and promoted into the user's normal project structure.

For Scenario L1 brownfield projects, the decision and plan records described in `COMMON.md` should normally use `.ai/decisions/` and `.ai/plans/` rather than introducing a new top-level `docs/` hierarchy into an established folder.

## Ownership and promotion rules

Treat files as belonging to one of three categories:

1. **User-owned existing artifacts** — preserve their paths and names unless the user explicitly asks for reorganization.
2. **Project-memory files** — root Markdown files maintained collaboratively by agents and the user.
3. **Agent-generated support/output files** — keep under `.ai/` until they have a clear long-term role.

A generated file should not become canonical merely because it is newest.

When a generated result is reviewed and accepted, place it in the location that makes sense within the user's existing structure, then update `SOURCES.md` and `STATE.md` as needed.

Example:

```text
.ai/generated/report_draft.docx
        ↓ reviewed / accepted
Отчеты/Отчет_2026.docx
```

After promotion, the file under the user's normal structure is canonical; the `.ai/generated/` copy should be removed or clearly treated as non-canonical.

## Greenfield exception

If the folder is genuinely new or the user explicitly asks to create a new project structure, the agent may propose or create domain-appropriate directories such as:

```text
data/
calculations/
src/
outputs/
cad/
experiments/
references/
reports/
```

Do not create these mechanically. Prefer names and organization appropriate to the real engineering, research, document, or software project.

Even in a greenfield project, keep the project-memory files at root and use `.ai/` for agent-specific planning, research, temporary work, and unreviewed generated outputs.

## Source locations

For artifacts inside the project, prefer relative paths in `SOURCES.md` so the folder remains portable between computers.

Example:

```markdown
## S-001 — Final application
Type: authoritative document
Path: `Грант/Заявка итоговая.docx`
Canonical: yes
```

There is no requirement to rename that file or move it into a standardized `references/` directory.

Use an absolute path only when an important source necessarily lives outside the project folder, and document that dependency.

## Local working rules

- Prefer direct filesystem access when the agent can access the project locally.
- Use targeted listing, search, bounded reads, and appropriate document/data tools instead of loading whole large files into model context.
- Do not reorganize user files as part of project initialization.
- Keep temporary and intermediate agent files under `.ai/work/` where practical.
- Keep unreviewed generated deliverables under `.ai/generated/` until they are accepted or intentionally placed in the user's normal structure.
- Treat raw source or experimental data as immutable by default unless the project explicitly defines otherwise.
- Register important user artifacts and accepted generated outputs in `SOURCES.md` without requiring them to be moved.
- Preserve linked/dependent file structures for CAD and similar applications; use application-native packaging mechanisms when relocation is explicitly required.

## Git and backup

Git is optional in Scenario L1. If enabled, use it where version history is useful for text/code/project-memory files, but do not automatically commit large binaries, CAD, generated outputs, or large datasets.

If GitHub later becomes the canonical remote location for project state, reassess the project against a GitHub-based scenario.

Backup or synchronization is strongly recommended when the local folder is canonical, but the backup copy must not become a competing canonical copy.

## Bootstrap procedure

When initializing an **existing** project with Scenario L1:

1. Read `COMMON.md` and this scenario.
2. Inspect the existing folder and infer its current organization without changing it.
3. Identify likely authoritative documents, data, outputs, linked files, and application-specific dependencies.
4. Create or complete the core files defined in `COMMON.md`: `README.md`, `AGENTS.md`, `PROJECT.md`, `STATE.md`, `TASKS.md`, `ASSUMPTIONS.md`, and `SOURCES.md`.
5. Create `.ai/` and only the subdirectories that are useful for the project; normally start with `plans/`, `decisions/`, `research/`, `work/`, and `generated/`.
6. Populate project-memory files from evidence already present in the project.
7. Mark missing information explicitly as unknown, assumption, or task rather than guessing.
8. Register important existing artifacts in `SOURCES.md` using their **current** relative paths.
9. Do not move or rename existing files solely to make the structure look standardized.
10. Summarize the current state in `STATE.md` and supported next actions in `TASKS.md`.
11. Verify that a fresh agent can continue by following `AGENTS.md` without reading the originating chat.

For a genuinely new empty project, use the same memory files and `.ai/` namespace, then create domain directories only as needed.

## Invocation

Existing project (default L1 case):

> Read `PROJECT_INFRASTRUCTURE.md`, `project-infrastructure/COMMON.md`, and `project-infrastructure/L1_LOCAL_FOLDER.md`. Apply Scenario L1 to this existing project. Preserve the user's current folder structure and file locations; add the project-memory infrastructure and organize agent-owned files under `.ai/`. Populate everything from existing evidence and do not invent missing facts.

New empty project:

> Read `PROJECT_INFRASTRUCTURE.md`, `project-infrastructure/COMMON.md`, and `project-infrastructure/L1_LOCAL_FOLDER.md`. Apply Scenario L1 as a greenfield project, create only domain-appropriate folders that are actually needed, and initialize the project-memory infrastructure.

Existing initialized project:

> Read `AGENTS.md`, restore the current project context, and continue task `T-XXX`.

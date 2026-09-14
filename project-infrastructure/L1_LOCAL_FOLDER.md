# Scenario L1 — Local Folder

**Status:** Implemented  
**Depends on:** [`COMMON.md`](COMMON.md)

Use this scenario when the project primarily lives in a normal local filesystem folder and the active agent has direct access to it.

## Goal

The local folder is the working environment and default canonical location for project memory. A new agent should be able to read the project-memory files defined in `COMMON.md`, understand the existing folder structure, locate relevant artifacts, and continue without relying on previous chat history.

The GitHub project-infrastructure standard is required only for initialization, validation, repair, or migration. **Normal L1 work must remain possible with the local project folder alone.**

## Self-contained L1 runtime

After bootstrap, an L1 project must contain enough local information that an agent without GitHub access can continue safely.

For ordinary work:

- `AGENTS.md` is the runtime entry point;
- root project-memory files are the current project source of truth;
- L1-specific runtime rules must be copied into `AGENTS.md` during bootstrap/migration;
- agents must not need to read the GitHub copy of `COMMON.md` or `L1_LOCAL_FOLDER.md`;
- the local infrastructure snapshot is for audit, repair, or migration only and is not part of normal startup.

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
    ├── infrastructure/
    │   ├── MANIFEST.md
    │   └── standard/
    │       ├── COMMON.md
    │       └── L1_LOCAL_FOLDER.md
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

- `.ai/infrastructure/` — installed infrastructure metadata and local standard snapshot.
- `.ai/plans/` — plans for complex or multi-session work.
- `.ai/decisions/` — decision records whose rationale may matter later.
- `.ai/research/` — intermediate research notes and evidence syntheses.
- `.ai/work/` — temporary or disposable working files and intermediate processing artifacts.
- `.ai/generated/` — generated deliverables that have not yet been reviewed and promoted into the user's normal project structure.

For Scenario L1 brownfield projects, decision and plan records use `.ai/decisions/` and `.ai/plans/`. Generic common rules must not introduce a competing `docs/decisions/` or `docs/plans/` convention.

## Infrastructure manifest and local snapshot

During bootstrap or an explicit infrastructure migration, create or update:

```text
.ai/infrastructure/MANIFEST.md
.ai/infrastructure/standard/COMMON.md
.ai/infrastructure/standard/L1_LOCAL_FOLDER.md
```

The two files under `standard/` should be exact local copies of the common and L1 instructions applied during the most recent initialization/migration whenever the bootstrap agent can retrieve them.

`MANIFEST.md` should record, when known:

```markdown
# Project infrastructure manifest

Scenario: L1
Standard source: maxvfk/ai-workflow
Standard version: <version if defined>
Standard commit/ref: <commit/ref if known>
Initialized: YYYY-MM-DD
Last infrastructure update: YYYY-MM-DD
Runtime entry point: ../../AGENTS.md
Local standard snapshot: ./standard/
```

If a version or commit cannot be established, record it as `unknown` rather than inventing one.

### Authority rules

For **normal project work**:

1. `AGENTS.md` defines installed runtime behavior.
2. Current project-memory files define current project state.
3. The local standard snapshot is not loaded unless needed for infrastructure work.

For **infrastructure repair or migration**:

1. the local manifest/snapshot describes the previously installed specification;
2. the explicitly selected newer GitHub standard is the target specification;
3. project-specific runtime rules and user-owned content must be preserved unless the migration explicitly changes them.

The snapshot must never be treated as a second copy of current project state.

## Required L1 runtime rules in `AGENTS.md`

During L1 bootstrap/migration, `AGENTS.md` must contain a concise L1 runtime section with at least:

- `Scenario: L1`;
- installed standard version/commit when known;
- path to `.ai/infrastructure/MANIFEST.md`;
- statement that normal work does not require GitHub or the local standard snapshot;
- preserve the user's existing file/folder structure unless explicitly asked to reorganize it;
- user-owned files must not be moved, renamed, regrouped, or converted merely to fit the infrastructure;
- temporary/intermediate agent files belong under `.ai/work/` where practical;
- unreviewed generated deliverables belong under `.ai/generated/`;
- accepted/generated artifacts should be promoted into the user's normal structure only when their long-term location is clear, with `SOURCES.md` / `STATE.md` updated as appropriate;
- decisions and plans use `.ai/decisions/` and `.ai/plans/`;
- secrets/credentials must not be stored in project-memory or infrastructure-managed text files;
- the project must remain continuable by another agent without previous chat history or external-standard access.

When `AGENTS.md` already exists, preserve its project-specific/user-authored content and install/update the L1 runtime rules using a clearly identifiable infrastructure-managed block when practical. Do not replace the whole file merely to apply this scenario.

## Existing infrastructure and safe reapplication

Before treating a non-empty folder as a first-time brownfield bootstrap, check for evidence that L1 or another infrastructure scenario is already installed, especially:

- scenario/infrastructure metadata in `AGENTS.md`;
- `.ai/infrastructure/MANIFEST.md`;
- an existing local infrastructure snapshot;
- existing project-memory files with populated state/tasks/source records.

If L1 is already installed, **do not bootstrap from scratch**. Treat the operation as reconciliation, repair, or migration according to `COMMON.md`.

On reapplication:

- read every existing project-memory/instruction file before modifying it;
- preserve user-authored and project-specific content;
- preserve current task/source/assumption identifiers and decision history;
- update only missing or obsolete infrastructure-managed rules/metadata;
- refresh the local standard snapshot and manifest only as part of explicit infrastructure work;
- do not reconstruct `STATE.md` or `TASKS.md` from folder contents unless the existing files are unusable and reconstruction is explicitly justified;
- if a safe merge is ambiguous, leave the original file intact and place a proposed replacement/patch under `.ai/work/` for review.

Existing `README.md` and tool-specific files such as `CLAUDE.md` follow the same preservation rule. Never replace a substantive existing `CLAUDE.md` with a one-line adapter.

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

Even in a greenfield project, keep the project-memory files at root and use `.ai/` for infrastructure metadata, agent-specific planning, research, temporary work, and unreviewed generated outputs.

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

Do not copy secret values, access tokens, credentials, or unnecessary personal data from source artifacts into `SOURCES.md`; follow the security/privacy rules in `COMMON.md`.

## Local working rules

- Prefer direct filesystem access when the agent can access the project locally.
- Use targeted listing, search, bounded reads, and appropriate document/data tools instead of loading whole large files into model context.
- Do not reorganize user files as part of project initialization.
- Keep temporary and intermediate agent files under `.ai/work/` where practical.
- Keep unreviewed generated deliverables under `.ai/generated/` until they are accepted or intentionally placed in the user's normal structure.
- Treat raw source or experimental data as immutable by default unless the project explicitly defines otherwise.
- Register important user artifacts and accepted generated outputs in `SOURCES.md` without requiring them to be moved.
- Preserve linked/dependent file structures for CAD and similar applications; use application-native packaging mechanisms when relocation is explicitly required.
- Do not load `.ai/infrastructure/standard/` during routine work.
- Never use project-memory files as storage for passwords, API keys, tokens, private keys, cookies, or other credentials.

## Git and backup

Git is optional in Scenario L1. If enabled, use it where version history is useful for text/code/project-memory files, but do not automatically commit large binaries, CAD, generated outputs, or large datasets.

If GitHub later becomes the canonical remote location for project state, reassess the project against a GitHub-based scenario.

Backup or synchronization is strongly recommended when the local folder is canonical, but the backup copy must not become a competing canonical copy.

## Bootstrap procedure

When Scenario L1 is requested, first determine whether the target is:

1. already initialized infrastructure;
2. uninitialized brownfield; or
3. greenfield.

### Already initialized L1

1. Read `AGENTS.md`, the local infrastructure manifest, and only the project-memory files needed to understand installed state.
2. Compare installed runtime/infrastructure with the explicitly requested target standard.
3. Reconcile or migrate non-destructively using the safe reapplication rules above.
4. Preserve user/project-specific instructions and all current project state.
5. Refresh infrastructure-managed blocks, manifest, and snapshot only as needed.
6. Verify that routine future work remains possible without GitHub.

### Existing project / uninitialized brownfield

1. Read the external index, `COMMON.md`, and this scenario while bootstrap access is available.
2. Inspect the existing folder and infer its current organization without changing it.
3. Identify likely authoritative documents, data, outputs, linked files, and application-specific dependencies.
4. Read any existing root/instruction files before deciding how to integrate the infrastructure.
5. Create missing core project-memory files and safely augment existing ones; never overwrite useful existing content from a template.
6. Create `.ai/infrastructure/`, `.ai/infrastructure/standard/`, and only the additional `.ai/` subdirectories useful for the project.
7. Save the applied `COMMON.md` and `L1_LOCAL_FOLDER.md` under `.ai/infrastructure/standard/` and create/update `MANIFEST.md`.
8. Ensure `AGENTS.md` contains the required L1 runtime rules and infrastructure metadata so normal future work does not depend on GitHub.
9. Populate project-memory files from evidence already present in the project.
10. Mark missing information explicitly as unknown, assumption, needs-validation, or task rather than guessing.
11. Register important existing artifacts in `SOURCES.md` using their current relative paths.
12. Do not move or rename existing files solely to make the structure look standardized.
13. Summarize the current state in `STATE.md` and supported next actions in `TASKS.md`.
14. Verify that a fresh agent with access only to the project folder can continue by following `AGENTS.md`, without previous chat history or GitHub access.

### New project / greenfield

1. Create the project-memory files, infrastructure manifest/snapshot, and `.ai/` namespace that are actually needed.
2. Create domain directories only when they are useful for the project.
3. If any target file already exists despite the project being otherwise greenfield, read and preserve it before modification.
4. Record known objectives, constraints, sources, assumptions, and initial tasks without inventing unavailable project facts.
5. Ensure `AGENTS.md` contains the L1 runtime rules.
6. Leave the project ready for a later offline/local agent to continue through `AGENTS.md` alone.

## Completion report

After initialization, restructuring, repair, or migration, report concisely:

- whether the project was treated as already initialized, brownfield, or greenfield;
- which project-memory and `.ai/` infrastructure files/directories were created or updated;
- which existing instruction/project-memory files were preserved/merged rather than replaced;
- which standard source/version/commit was recorded, if known;
- the main canonical sources identified;
- the reconstructed current state;
- important unknowns/assumptions;
- structural issues noticed but deliberately left unchanged;
- confirmation that normal future work no longer requires GitHub access.

## Minimal invocation

The intended user prompt is deliberately short:

> Apply project infrastructure scenario **L1** to this folder using `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

All bootstrap details are defined in the GitHub standard and must not need to be repeated by the user.

After bootstrap, routine work uses only the project itself:

> Read `AGENTS.md`, restore the current project context, and continue with my request.

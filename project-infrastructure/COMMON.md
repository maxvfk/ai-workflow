# Common Project Infrastructure Rules

**Status:** Working standard  
**Applies to:** All project-infrastructure scenarios.

These rules define the canonical project-memory model. Scenario files add environment-specific storage, access, synchronization, bootstrap, and runtime rules.

## 0. Self-contained runtime after bootstrap

The external project-infrastructure standard is an **installer and upgrader, not a runtime dependency**.

After initialization, a project must be self-contained enough that a capable agent with access only to the project files can understand the project, follow the active scenario rules, and continue normal work without access to the standard repository, previous chat history, or the bootstrap agent.

Every scenario bootstrap must therefore materialize locally:

- a self-contained `AGENTS.md` runtime entry point;
- the active scenario identifier and installed infrastructure metadata;
- scenario-specific rules needed during ordinary work;
- pointers to project-memory files and scenario-defined support locations;
- enough infrastructure metadata to audit, repair, or migrate the setup later.

### Runtime source of truth

For ordinary project work, the authoritative runtime layer is:

`AGENTS.md` + the current project-memory files.

A future agent must not require the external standard for normal work.

### Local infrastructure snapshot

A scenario may require or recommend storing a local snapshot of the exact common/scenario instructions used for the latest initialization or migration, together with a manifest.

The snapshot exists for audit/provenance, repair, migration comparison, and offline recovery. It is **not** part of the normal startup sequence and should not be loaded unless infrastructure work is actually being performed.

### External standard and versioning

The current external standard becomes authoritative again only when the user explicitly requests infrastructure initialization, validation, repair, or migration/upgrade.

Projects do **not** silently follow changes to a mutable branch such as `main`. During bootstrap or migration, record the standard version and, when available, the exact commit/ref used. During a later upgrade, compare the installed manifest/snapshot with the explicitly selected target standard and migrate deliberately.

## 1. Project-memory profiles

Do not create empty infrastructure files merely because they appear in the standard. Start with the smallest profile that can preserve continuity and **promote the project when complexity requires it**.

### Minimal profile

Use for a small, short-lived, or structurally simple project where the objective and source material are obvious and there is little uncertainty.

Required:

- `AGENTS.md` — runtime entry point;
- `STATE.md` — current snapshot;
- `TASKS.md` — active/next work.

Add other project-memory files only when they have real content to hold.

### Standard profile

Use for substantial, long-running, multi-deliverable, research, engineering, analytical, or dependency-rich work.

Typical files:

- `AGENTS.md` — AI entry point and runtime contract;
- `PROJECT.md` — stable project definition: objective, scope, deliverables, constraints, terminology, success criteria;
- `STATE.md` — current project snapshot;
- `TASKS.md` — task registry;
- `ASSUMPTIONS.md` — uncertainty register;
- `SOURCES.md` — registry of authoritative source files, datasets, external artifacts, and canonical locations;
- `README.md` — optional human entry point when useful or already present.

### Promotion triggers

Promote from Minimal by creating only the needed file(s):

- create `PROJECT.md` when scope, deliverables, terminology, or constraints are no longer obvious from `AGENTS.md`/`STATE.md`;
- create `SOURCES.md` when provenance, canonical-vs-derived status, multiple authoritative artifacts, external sources, or modification restrictions matter;
- create `ASSUMPTIONS.md` when estimates, uncertainty, design choices, research premises, or validation state matter;
- use decision records when rationale must survive future sessions;
- use plans when a task spans a long run, multiple sessions, or multiple agents;
- use `README.md` when a human-facing entry point adds value.

Never create placeholder files that would remain effectively empty. `AGENTS.md` must list the actual installed project-memory files so startup does not assume absent optional files.

## 2. Startup sequence and progressive disclosure

Do not load the whole project into model context by default.

Preferred runtime sequence is:

1. `AGENTS.md`;
2. the installed current-state/task files named there (`STATE.md`, `TASKS.md`);
3. `PROJECT.md`, `ASSUMPTIONS.md`, and `SOURCES.md` only if they exist and are relevant;
4. decisions, plans, source documents, code, data, and outputs only as needed.

Do not load the local infrastructure-standard snapshot during ordinary startup.

## 3. Current state is not a session log

`STATE.md` is the default handoff snapshot. It describes the **present**, not a chronological diary.

When information stops being current, replace or remove it from `STATE.md`. Historical context belongs in version history, the scenario-defined decision-record and completed-plan locations, or optional archives when they add real value.

Do not create parallel `HANDOFF.md`, `LATEST_CONTEXT.md`, `CURRENT.md`, or `SESSION_SUMMARY.md` files by default.

## 4. Facts, decisions, assumptions, recommendations, and tasks

Agents should distinguish explicitly:

- **Fact** — supported by project evidence or an authoritative source.
- **Decision** — an explicit project choice.
- **Assumption** — a provisional premise used for analysis or planning.
- **Recommendation** — a proposed course of action not necessarily accepted.
- **Task** — work to be performed.

Do not silently convert one category into another.

## 5. Stable identifiers

Use one shared identifier convention across scenarios when records are non-trivial:

- `T-001`, `T-002`, ... — tasks;
- `A-001`, `A-002`, ... — assumptions;
- `S-001`, `S-002`, ... — sources/canonical artifacts;
- `D-001`, `D-002`, ... — decisions;
- `P-001`, `P-002`, ... — substantial plans.

IDs are stable, monotonically increasing within a project, and must not be reused after deletion, cancellation, rejection, or supersession.

Recommended filenames for standalone records:

- `D-001-short-decision-title.md`;
- `P-001-short-plan-title.md`.

Cross-reference these IDs from `STATE.md`, `TASKS.md`, decisions, plans, and other project-memory files when useful.

## 6. One canonical copy

For every important artifact, identify one canonical copy. Avoid maintaining competing “latest” copies across folders or services.

If another copy exists for transport, conversion, review, local processing, or publication, treat it as temporary/derived and point back to the canonical artifact in `SOURCES.md`.

## 7. Safe initialization, reapplication, and file preservation

Infrastructure initialization and migration must be **non-destructive and idempotent by default**.

Before creating or updating any existing root/project-instruction file, including `README.md`, `AGENTS.md`, `PROJECT.md`, `STATE.md`, `TASKS.md`, `ASSUMPTIONS.md`, `SOURCES.md`, `CLAUDE.md`, or another tool-specific instruction file:

1. read the existing file first;
2. identify user-maintained and project-specific content;
3. preserve valid existing content and integrate infrastructure rules around it;
4. never replace the complete file merely because the standard contains a template;
5. if a safe merge is ambiguous, leave the original unchanged and create a proposed patch/draft in the scenario-defined agent work area.

Templates are **shapes and defaults**, not permission to overwrite existing content.

### Reapplying an already-installed scenario

When infrastructure metadata shows that a project is already initialized:

- treat the operation as reconcile/repair/migration, not as a new bootstrap;
- preserve current project state, IDs, decisions, source registrations, and project-specific instructions;
- update only missing, obsolete, or explicitly migrated infrastructure behavior;
- do not recreate project-memory files from scratch;
- do not reset `STATE.md` or `TASKS.md` from a new scan unless the existing files are unusable and reconstruction is explicitly justified.

### Infrastructure-managed blocks

When practical, scenario/runtime material added to a pre-existing instruction file should be isolated with stable markers:

```markdown
<!-- project-infrastructure:start -->
... infrastructure-managed runtime rules ...
<!-- project-infrastructure:end -->
```

On later reapplication, update only the managed block and preserve content outside it. Existing substantive tool-specific files such as `CLAUDE.md` follow the same preservation rule.

## 8. Security, secrets, and personal data

Project-memory and infrastructure files must not become a credential store.

Never write secret values into infrastructure-managed text files, including passwords, API keys/tokens, OAuth or refresh tokens, session cookies, private keys, seed phrases, database credentials, or access tokens embedded in URLs.

If a secret is required by the workflow, record only a non-secret reference such as `configured via environment variable`, `stored in system credential manager`, or a secret-manager identifier.

If a secret is discovered in project content, avoid echoing or propagating it. Flag the exposure and, when relevant, recommend moving it to an appropriate credential mechanism and rotating/revoking it.

Personal or sensitive data should be minimized in project-memory files. Prefer references to protected canonical sources over duplication and avoid placing sensitive details into repositories/shared memory unless genuinely required and appropriate for the storage/access model.

## 9. Root-file guidance

### `README.md`

Keep it short when present: project name, one-paragraph purpose, basic structure, pointer to `AGENTS.md`, and essential human setup/opening instructions. Do not duplicate detailed project state.

### `AGENTS.md` — AI entry point and runtime contract

`AGENTS.md` must be sufficient for a future agent to discover and follow the installed infrastructure without external-standard access.

During bootstrap/migration, the selected scenario must add its required runtime rules and infrastructure metadata locally.

A useful baseline contains:

```markdown
# Agent instructions

## Infrastructure
Scenario: <scenario-id>
Installed standard version/commit: <version and commit/ref when known>
Local infrastructure metadata: <scenario-defined manifest path>
Project-memory profile: <Minimal/Standard>
Installed project-memory files: <actual files>

For normal work, this file and the project-memory files are the runtime source of truth. Do not require the external standard or load the local standard snapshot unless performing infrastructure audit, repair, or migration.

## Startup
Read only the installed project-memory files needed for the task, beginning with current state/tasks.

## Working rules
- Prefer project files over remembered chat context when they conflict.
- Read only what is needed for the current task.
- Preserve canonical source files unless the task explicitly requires changing them.
- Distinguish facts, decisions, assumptions, recommendations, and tasks.
- Use appropriate tools for large/complex files instead of loading their full contents unnecessarily.
- Never store secrets or credential values in project-memory/infrastructure files.
- Follow the scenario-specific runtime rules recorded here.

## Before finishing substantial work
- Re-read shared project-memory files you are about to modify and reconcile concurrent changes.
- Update current state/tasks and other installed project-memory files when relevant.
- Record significant decisions in the scenario-defined location.
- Leave the project continuable without the previous chat or external standard.
```

Do not turn `AGENTS.md` into a full project encyclopedia; include runtime rules and route detailed context to the appropriate files.

### `PROJECT.md`

Recommended sections: Objective; Scope (Included/Excluded); Deliverables; Constraints; Definitions and terminology; Success criteria.

### `STATE.md`

Recommended sections: Last updated; Current phase; Current status; Completed; In progress; Blocked/waiting; Current canonical outputs; Key current conclusions; Immediate next actions.

### `TASKS.md`

Use stable `T-###` IDs for non-trivial projects. Suggested statuses: `todo`, `active`, `blocked`, `done`, `cancelled`. Do not use it as a narrative diary.

`TASKS.md` is an **active working set**, not a permanent ledger. Keep active/blocked/todo tasks plus recently completed tasks that still provide useful context. Periodically move older `done`/`cancelled` entries to the scenario-defined task archive while preserving IDs and relevant output/evidence references.

Archive when the file becomes noisy enough to hinder startup rather than at a rigid task count. Do not archive active or blocked tasks.

### `ASSUMPTIONS.md`

For engineering, scientific, cost-estimation, research, planning, and analytical projects, an explicit uncertainty register is strongly recommended.

### `SOURCES.md`

Register important authoritative information and artifacts. Record when useful: `S-###` ID, title/name, type, canonical location/path/URL/ID, canonical status, provenance, purpose, modification restrictions, and version/date. The scenario defines location conventions.

## 10. Decisions

Use `D-###` for one decision record per significant decision when future agents may need to understand **why** it was made. The storage location is scenario-defined.

A useful record contains: ID/title, status, date, context, decision, alternatives considered, and consequences. When a decision changes, normally create a new record and mark the old one `Superseded` rather than rewriting history.

## 11. Plans for complex work

For a small task, `TASKS.md` is enough. For work spanning a long agent run, multiple sessions, or multiple agents, create a `P-###` plan in the active scenario's plan location.

A plan should contain objective, inputs, expected outputs, steps/workstreams, dependencies, validation criteria, and open questions. Reference it from `STATE.md`/`TASKS.md` instead of duplicating it there.

## 12. End-of-session synchronization

Before ending substantial work, the active agent should:

1. re-read every shared project-memory file it intends to modify;
2. reconcile any changes made since it last read the file rather than overwriting them;
3. update installed current-state/task/source/assumption files as relevant;
4. record significant decisions in the scenario-defined location;
5. archive stale completed/cancelled tasks when `TASKS.md` has become noisy;
6. leave the project continuable without the previous chat or external standard.

## 13. Concurrent agents and shared-state writes

L1 and other scenarios may be used by more than one agent even before a dedicated multi-agent scenario is adopted. Use **optimistic concurrency** for shared project state.

Rules:

- Immediately before writing `AGENTS.md`, `PROJECT.md`, `STATE.md`, `TASKS.md`, `ASSUMPTIONS.md`, `SOURCES.md`, a manifest, or another shared canonical text file, re-read the current file.
- If it changed since the agent's working copy was read, merge/reconcile the newer content; never blindly overwrite it with stale state.
- Avoid assigning two active agents to modify the same task or canonical artifact at the same time unless explicit coordination exists.
- For parallel work, prefer separate task IDs and scenario-defined work areas; merge results deliberately into shared state.
- When a conflict cannot be reconciled confidently, preserve both contributions in a non-canonical work area and surface the conflict rather than choosing silently.
- A dedicated multi-agent scenario may later add stronger coordination/locking rules; these minimum rules apply everywhere.

## 14. Cold-start validation

A bootstrap, repair, or migration is not complete merely because files were created.

Validate the installed runtime from the perspective of a fresh agent that has access only to the project folder and begins with `AGENTS.md`. Without relying on the originating chat or external standard, that agent should be able to determine at least:

- what the project is currently doing/current phase;
- the nearest active/next tasks;
- where the important canonical sources or outputs are, when source tracking is part of the installed profile;
- which scenario/runtime rules constrain its work;
- where temporary/generated work belongs.

When an independent fresh-agent run is available and proportionate, use it. Otherwise perform the same check explicitly by following only the installed local runtime. Record unresolved gaps as tasks instead of claiming successful validation.

## 15. Tool-specific adapters

The canonical project memory must remain tool-agnostic. Tool-specific entry files or workspace instructions should be thin adapters rather than independent project-state copies.

### Claude Code

For a new project with no existing `CLAUDE.md`, it may be useful to create:

```markdown
@AGENTS.md
```

If `CLAUDE.md` already exists, preserve its instructions and integrate a reference to `AGENTS.md` only when useful.

### Codex

Use the root `AGENTS.md` directly. Add nested `AGENTS.md` files only when a subdirectory needs materially different rules.

### ChatGPT Work / Cowork / other project agents

Configure workspace/project instructions to read the root `AGENTS.md` before substantial work when the product does not automatically discover it. Do not maintain separate full copies of project state inside product-specific instructions.

# Common Project Infrastructure Rules

**Status:** Working standard  
**Applies to:** All project-infrastructure scenarios.

These rules define the canonical project-memory model. Scenario files add environment-specific storage, access, synchronization, bootstrap, and runtime rules.

## 0. Self-contained runtime after bootstrap

The external project-infrastructure standard is an **installer and upgrader, not a runtime dependency**.

After initialization, a project must be self-contained enough that a capable agent with access to the scenario-defined project entry resources and canonical stores can understand the project, follow the active scenario rules, and continue normal work without access to the external standard repository, previous chat history, or the bootstrap agent.

Every scenario bootstrap must therefore materialize in the project's canonical runtime/control store:

- a self-contained `AGENTS.md` runtime entry point;
- the active scenario identifier and installed infrastructure metadata;
- scenario-specific rules needed during ordinary work;
- pointers to project-memory files and scenario-defined support locations;
- enough infrastructure metadata to audit, repair, or migrate the setup later.

For ordinary work, the authoritative runtime layer is the canonical `AGENTS.md` plus the current project-memory files. A scenario may expose a thin local/product bootstrap adapter that leads to this canonical runtime. The installed standard snapshot is for audit, repair, migration comparison, and recovery only; it is not part of normal startup.

Projects do not silently follow changes to a mutable branch such as `main`. During bootstrap/migration, record the standard version and, when available, exact commit/ref. Upgrade only when explicitly requested.

## 1. Project-memory profiles

Do not create empty infrastructure files merely because they appear in the standard. Start with the smallest profile that preserves continuity and promote the project when complexity requires it.

### Minimal profile

Use for a small, short-lived, or structurally simple project.

Required:

- `AGENTS.md` — runtime entry point;
- `STATE.md` — current snapshot;
- `TASKS.md` — active/next work.

Add other project-memory files only when they have real content to hold.

### Standard profile

Use for substantial, long-running, multi-deliverable, research, engineering, analytical, or dependency-rich work.

Typical files:

- `AGENTS.md`;
- `PROJECT.md`;
- `STATE.md`;
- `TASKS.md`;
- `ASSUMPTIONS.md` when uncertainty/validation matters;
- `SOURCES.md` when provenance/canonical-source tracking matters;
- `README.md` when a human entry point is useful or already exists.

Promotion triggers:

- create `PROJECT.md` when scope, deliverables, terminology, or constraints are no longer obvious;
- create `SOURCES.md` when provenance, canonical-vs-derived status, multiple authoritative artifacts, external sources, or modification restrictions matter;
- create `ASSUMPTIONS.md` when estimates, uncertainty, design choices, research premises, or validation state matter;
- use decision records when rationale must survive future sessions;
- use plans when work spans a long run, multiple sessions, or multiple agents.

Never create placeholder files that would remain effectively empty. `AGENTS.md` must list the actual installed project-memory files.

## 2. Project-memory language

The project-memory layer should use **one primary human language per project**.

For this standard, the default is:

> **Project-memory prose is Russian (`ru`) unless the user explicitly requests another language or the project already has an established project-memory language.**

Rules:

- keep ordinary prose, headings, explanations, task descriptions, conclusions, and human-facing table labels in the selected project-memory language;
- keep infrastructure filenames stable in their defined English forms (`AGENTS.md`, `PROJECT.md`, `STATE.md`, `TASKS.md`, `ASSUMPTIONS.md`, `SOURCES.md`);
- keep record IDs in their defined forms (`T-###`, `A-###`, `S-###`, `D-###`, `P-###`);
- keep controlled machine-like values defined by the standard in English, for example task statuses `todo`, `active`, `blocked`, `done`, `cancelled`, and similar controlled status/priority values;
- the language of a particular deliverable does **not** change the project-memory language by itself. An English manuscript, cover letter, codebase, or journal submission can live inside a project whose memory remains Russian;
- do not automatically translate an already initialized project's project-memory files. Preserve the installed language unless the user explicitly requests a language change;
- when the user explicitly chooses another project-memory language, record that choice in infrastructure metadata and runtime instructions.

Scenario manifests should record the installed project-memory language using a short code such as `ru` or `en`.

`AGENTS.md` should contain a concise runtime rule such as:

```text
Project-memory language: ru
Maintain project-memory prose in Russian unless the user explicitly requests a project-memory language change. Keep filenames, record IDs, and controlled status values in their defined English forms.
```

## 3. Startup sequence and progressive disclosure

Do not load the whole project into model context by default.

Preferred runtime sequence:

1. `AGENTS.md`;
2. the installed current-state/task files named there (`STATE.md`, `TASKS.md`);
3. `PROJECT.md`, `ASSUMPTIONS.md`, and `SOURCES.md` only if they exist and are relevant;
4. decisions, plans, source documents, code, data, and outputs only as needed.

Do not load the local infrastructure-standard snapshot during ordinary startup.

## 4. Current state is not a session log

`STATE.md` is the default handoff snapshot. It describes the **present**, not a chronological diary.

When information stops being current, replace or remove it. Historical context belongs in version history, scenario-defined decision/completed-plan locations, or optional archives when they add real value.

Do not create parallel `HANDOFF.md`, `LATEST_CONTEXT.md`, `CURRENT.md`, or `SESSION_SUMMARY.md` files by default.

## 5. Facts, decisions, assumptions, recommendations, and tasks

Agents should distinguish explicitly:

- **Fact** — supported by project evidence or an authoritative source;
- **Decision** — an explicit project choice;
- **Assumption** — a provisional premise used for analysis/planning;
- **Recommendation** — a proposed course of action not necessarily accepted;
- **Task** — work to be performed.

Do not silently convert one category into another.

## 6. Stable identifiers

Use one shared identifier convention across scenarios when records are non-trivial:

- `T-001`, `T-002`, ... — tasks;
- `A-001`, `A-002`, ... — assumptions;
- `S-001`, `S-002`, ... — sources/canonical artifacts;
- `D-001`, `D-002`, ... — decisions;
- `P-001`, `P-002`, ... — substantial plans.

IDs are stable, monotonically increasing within a project, and must not be reused after deletion, cancellation, rejection, or supersession.

Recommended standalone filenames:

- `D-001-short-decision-title.md`;
- `P-001-short-plan-title.md`.

## 7. One canonical copy

For every important artifact, identify one canonical copy. Avoid competing “latest” copies across folders or services.

If another copy exists for transport, conversion, review, local processing, or publication, treat it as temporary/derived and point back to the canonical artifact in `SOURCES.md` when source tracking is installed.

## 8. Safe initialization, reapplication, and file preservation

Infrastructure initialization and migration must be **non-destructive and idempotent by default**.

Before updating any existing root/project-instruction file:

1. read it first;
2. identify user-maintained/project-specific content;
3. preserve valid existing content and integrate infrastructure rules around it;
4. never replace the complete file merely because the standard contains a template;
5. if a safe merge is ambiguous, leave the original unchanged and create a proposed patch/draft in the scenario-defined work area.

Templates are shapes/defaults, not permission to overwrite existing content.

When infrastructure metadata shows that a project is already initialized:

- treat the operation as reconcile/repair/migration, not a new bootstrap;
- preserve current state, IDs, decisions, source registrations, language, and project-specific instructions;
- update only missing, obsolete, or explicitly migrated infrastructure behavior;
- do not recreate project-memory files from scratch;
- do not reset `STATE.md` or `TASKS.md` from a new scan unless existing files are unusable and reconstruction is explicitly justified.

When practical, infrastructure-managed material added to a pre-existing instruction file should use stable markers:

```markdown
<!-- project-infrastructure:start -->
... infrastructure-managed runtime rules ...
<!-- project-infrastructure:end -->
```

Update only the managed block on later reapplication. Existing substantive tool-specific files such as `CLAUDE.md` follow the same preservation rule.

## 9. Security, secrets, and personal data

Project-memory/infrastructure files must not become a credential store.

Never write passwords, API keys/tokens, OAuth/refresh tokens, session cookies, private keys, seed phrases, database credentials, or access tokens embedded in URLs into infrastructure-managed text files.

If a secret is required by the workflow, record only a non-secret reference such as `configured via environment variable`, `stored in system credential manager`, or a secret-manager identifier.

If a secret is discovered in project content, avoid echoing/propagating it. Flag the exposure and, when relevant, recommend moving it to an appropriate credential mechanism and rotating/revoking it.

Personal/sensitive data should be minimized in project memory. Prefer references to protected canonical sources over duplication.

## 10. Root-file guidance

### `README.md`

Keep it short when present: project name, one-paragraph purpose, basic structure, pointer to `AGENTS.md`, and essential human setup/opening instructions. Do not duplicate detailed current state.

### `AGENTS.md`

`AGENTS.md` must be sufficient for a future agent to discover and follow the installed runtime without external-standard access.

A useful baseline contains:

```markdown
# Инструкции для агента

## Infrastructure
Scenario: <scenario-id>
Installed standard version/commit: <version and commit/ref when known>
Local infrastructure metadata: <manifest path>
Project-memory profile: <Minimal/Standard>
Project-memory language: <ru/en/...>
Installed project-memory files: <actual files>

For normal work, this file and the project-memory files are the runtime source of truth. Do not require the external standard or load the local standard snapshot unless performing infrastructure audit, repair, or migration.

## Запуск
Read only the installed project-memory files needed for the task, beginning with current state/tasks.

## Правила работы
- Prefer project files over remembered chat context when they conflict.
- Preserve canonical source files unless the task explicitly requires changing them.
- Maintain project-memory prose in the installed project-memory language.
- Keep filenames, record IDs, and controlled status values in their defined English forms.
- Distinguish facts, decisions, assumptions, recommendations, and tasks.
- Never store secrets or credential values in project-memory/infrastructure files.
- Follow the scenario-specific runtime rules recorded here.

## Перед завершением существенной работы
- Re-read shared project-memory files you are about to modify and reconcile concurrent changes.
- Update current state/tasks and other installed project-memory files when relevant.
- Record significant decisions in the scenario-defined location.
- Leave the project continuable without the previous chat or external standard.
```

Do not turn `AGENTS.md` into a full project encyclopedia.

### `PROJECT.md`

Recommended content: objective; scope; deliverables; constraints; definitions/terminology; success criteria.

### `STATE.md`

Recommended content: last updated; current phase/status; completed; in progress; blocked/waiting; current canonical outputs; key current conclusions; immediate next actions.

### `TASKS.md`

Use stable `T-###` IDs. Controlled task statuses are `todo`, `active`, `blocked`, `done`, `cancelled`.

`TASKS.md` is an active working set, not a permanent ledger. Keep active/blocked/todo tasks plus recently completed items that still provide useful context. Periodically archive older `done`/`cancelled` entries under the scenario-defined task archive while preserving IDs and evidence references.

### `ASSUMPTIONS.md`

For engineering, scientific, cost-estimation, research, planning, and analytical projects, an explicit uncertainty register is strongly recommended.

### `SOURCES.md`

Register important authoritative information/artifacts. Record when useful: `S-###` ID, title/name, type, canonical location/path/URL/ID, canonical status, provenance, purpose, modification restrictions, version/date.

## 11. Decisions and plans

Use `D-###` for significant decision records whose rationale must survive future sessions. Use `P-###` for substantial plans spanning long runs, multiple sessions, or multiple agents.

Decision/plan storage locations are scenario-defined. When a decision changes, normally create a new record and mark the old one `Superseded` rather than rewriting history.

## 12. End-of-session synchronization

Before ending substantial work:

1. re-read every shared project-memory file you intend to modify;
2. reconcile concurrent changes instead of overwriting them;
3. update installed current-state/task/source/assumption files as relevant;
4. record significant decisions;
5. archive stale completed/cancelled tasks when `TASKS.md` becomes noisy;
6. preserve the installed project-memory language;
7. leave the project continuable without the previous chat or external standard.

## 13. Concurrent agents and shared-state writes

Use optimistic concurrency for shared project state:

- immediately before writing a shared canonical/runtime file, re-read the current file;
- if it changed, reconcile newer content; never blindly overwrite stale state;
- avoid assigning two active agents to the same task/canonical artifact unless coordinated;
- for parallel work, prefer separate task IDs/work areas and deliberate merge;
- when a conflict cannot be reconciled confidently, preserve both contributions in a non-canonical work area and surface the conflict.

A dedicated multi-agent scenario may later add stronger coordination/locking rules.

## 14. Cold-start validation

A bootstrap, repair, or migration is not complete merely because files were created.

Validate from the perspective of a fresh agent that has only the scenario-defined project entry resources/canonical-store access and no originating chat. The agent must be able to discover or enter the canonical `AGENTS.md` runtime (directly or through a thin scenario/product adapter) and determine at least:

- installed scenario/profile/project-memory language;
- current phase/status;
- nearest active/next tasks;
- important canonical sources/outputs when source tracking is installed;
- scenario/runtime constraints;
- where temporary/generated work belongs.

When an independent fresh-agent run is available and proportionate, use it. Otherwise perform the same check explicitly using only the installed runtime and scenario-defined entry resources.

## 15. Universal `AGENTS.md` and tool-specific adapters

`AGENTS.md` is the **canonical, vendor-neutral runtime instruction file** for this standard.

Rules that are valid regardless of the active agent belong in `AGENTS.md`. Current project state belongs in the project-memory files named from `AGENTS.md`, not in vendor-specific instruction files.

Tool-specific entry files/workspace instructions are optional thin adapters. They must not become independent copies of project state or duplicate the general runtime rules.

### Claude Code

Claude Code 2.1.277+ can load `AGENTS.md` natively when the project has no project-specific `CLAUDE.md`. Therefore the default for a new project is:

> **Always create/maintain `AGENTS.md`. Do not create `CLAUDE.md` unless the project has a concrete Claude-specific requirement.**

When a Claude-specific adapter is genuinely useful, keep `AGENTS.md` as the single shared source of truth and make `CLAUDE.md` thin, for example:

```markdown
@AGENTS.md

# Claude-specific additions

...only instructions that are specific to Claude Code...
```

Appropriate Claude-only additions include tool-specific skills, subagent policy, Claude hooks/rules, or compatibility requirements that do not apply to other agents.

Do not copy shared project rules from `AGENTS.md` into `CLAUDE.md`.

Do not make project correctness depend on a user-global Claude setting such as loading both instruction formats. A repository-level adapter, when needed, should carry its own explicit relationship to `AGENTS.md`.

If an existing `CLAUDE.md` or `CLAUDE.local.md` is present, preserve it non-destructively. Project-specific Claude instruction files can change whether native `AGENTS.md` fallback is used, so ensure the effective Claude instructions still include the canonical `AGENTS.md` rules when required.

### Codex

Use the root `AGENTS.md` directly.

Add nested `AGENTS.md` files only when a subdirectory needs materially different or path-scoped rules. Keep the root `AGENTS.md` self-contained enough for ordinary project startup.

For cross-tool portability, do not rely on Claude-specific `@path` import behavior inside canonical `AGENTS.md` unless all required agents are known to support the same semantics.

### ChatGPT Work / Cowork / other project agents

When a product does not automatically discover `AGENTS.md`, configure its project/workspace instructions as a thin adapter that points to the canonical `AGENTS.md`.

Do not maintain separate full copies of current project state inside product-specific instructions.

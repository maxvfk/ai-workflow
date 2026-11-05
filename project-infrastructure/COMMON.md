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
- project-owned bootstrap/runtime **human-facing prose** should normally follow the installed project-memory language, while stable infrastructure field labels/keys, filenames, IDs, scenario codes, language codes, and other machine-like values remain in their defined English forms;
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

### Task scale and proportional write path

Do not apply the heaviest synchronization/publication procedure to every task. Use the lightest path that preserves correctness.

**Read-only or informational task**
- read the canonical `AGENTS.md` and only the project/source files needed for the answer;
- do not update project memory merely because a read occurred;
- if the user nevertheless establishes a new durable project/task decision or answer that materially changes an active task, record that durable information in the same session;
- do not run publication or write-synchronization procedures unless such a durable update actually requires a write.

**Bounded small edit**
- use for a low-risk edit to one clearly identified canonical artifact or one small project-memory change;
- ground the project/target and check only the concurrency/synchronization signals relevant to that target;
- make the edit through the safest available identity-preserving path;
- verify the edited target;
- update `STATE.md`, `TASKS.md`, `SOURCES.md`, decisions, or other project memory **only when the edit materially changes project state, task status, provenance, or a recorded decision**;
- a scenario's full publish/promote transaction is not required unless one of the substantial-work triggers below applies.

Use the **full scenario transaction** when work is substantial or risk-bearing, including one or more of:
- several canonical artifacts/stores must change together;
- a derived/materialized copy must be promoted or published back;
- conversion/replacement may alter identity, structure, formulas, references, metadata, or other important semantics;
- the work is destructive, difficult to reverse, or provenance-sensitive;
- concurrent edits are plausible;
- project state/tasks/decisions materially change;
- the work spans multiple agents/sessions or has a meaningful handoff;
- the active scenario explicitly requires a stronger transaction for that operation.

When uncertain, escalate one level rather than automatically using the full workflow.

### Canonical-target-first tool routing

Select the **canonical target before selecting the tool or workspace**.

For any read or write that is intended to affect project state or a canonical artifact:

1. determine the intended canonical store and exact target from the installed scenario/runtime, `SOURCES.md`, project metadata, and the user's request;
2. when an identity-preserving operation against that canonical target is available and suitable, use it directly;
3. do **not** create or edit a local/workspace substitute merely because filesystem, browser, computer-use, or generic file tools are available;
4. use a local checkout, materialized copy, or temporary workspace only when the task materially requires local execution, transformation, validation/staging, multi-file work, application-specific tooling, or an operation unavailable safely against the canonical target;
5. treat every such working copy as non-canonical until the scenario-defined publish/promote step succeeds and is verified;
6. when several stores or similarly named resources are available, resolve the target from project infrastructure rather than guessing from the filename/project name alone;
7. successful work on a non-canonical copy does not satisfy a requested canonical read/write.

Tool availability influences **how** to reach the target, not **which target is authoritative**.

### Programmatic text-write integrity

When text is written through an API, connector, script, tool call, or other serialization path, do not assume that escape-sensitive syntax was preserved exactly merely because the write operation succeeded.

For materially important content containing sequences that may be interpreted by intermediate string/serialization layers — for example LaTeX commands, regular expressions, Windows paths, shell/code fragments, or literal backslashes such as `\r`, `\n`, and `\t` — verify the **persisted result** after the write.

Use simpler plain-Unicode notation when it is genuinely equivalent and improves robustness, but do not replace exact syntax with a lossy workaround when the syntax itself matters. In that case preserve the intended syntax and validate the stored file after writing.

A successful transport/API acknowledgement proves that the write request completed; it does not by itself prove textual integrity.

### Manual, external, and delegated artifact changes

Canonical project artifacts may be changed outside the main/orchestrating agent workflow by the user, a domain application, a local/delegated agent, or another authorized tool. This is normal and does not require every bounded artifact edit to pass through the project orchestrator.

Project memory is a maintained operational view of the project and may temporarily lag behind canonical artifacts changed through those paths.

When the user asks to **refresh**, **reconcile**, or **update project state from current artifacts**:

1. treat the current canonical stores/artifacts as the observed artifact state;
2. perform bounded, change-focused discovery rather than rescanning the whole project;
3. compare only relevant observations with installed `PROJECT.md`, `STATE.md`, `TASKS.md`, `SOURCES.md`, `ASSUMPTIONS.md`, decisions, and other project memory;
4. update project memory only where the observed changes materially affect scope, current state, tasks, provenance, assumptions, decisions, canonical outputs, paths, or dependencies;
5. do **not** infer that a newer-looking filename, timestamp, revision suffix, or newly discovered file automatically supersedes an existing canonical artifact;
6. preserve ambiguity explicitly when the intended canonical/superseding artifact cannot be established safely;
7. do not reorganize, rename, rewrite, or otherwise alter user artifacts merely to make project memory agree with them.

A local/delegated agent performing an artifact-only task does not need to update the project's control/state plane merely because it touched a canonical artifact. If its task explicitly includes project-state synchronization, or the change materially requires immediate state/provenance updates and the agent has safe access to the control plane, apply the normal scenario write/concurrency rules. Otherwise a later reconciliation pass may update project memory.

Do not add mandatory filesystem watchers, per-file change logs, or mutable hashes merely to detect such edits. Use explicit reconciliation when continuity or downstream work requires it.

## 4. Current state, task continuity, and historical layers

Project memory should make the **current position fast to recover** while preserving enough deeper history to reconstruct how the project arrived there.

### `STATE.md / Now`

`STATE.md` is the default project-wide handoff snapshot. It describes the **present**, not a chronological diary.

For non-trivial projects, begin `STATE.md` with a compact **Now / Сейчас** section that is rewritten as the project changes. It should normally expose only what a fresh coordinator needs first:

- active streams/current phase;
- current position and immediate next steps;
- important current outputs/artifacts;
- pointers to relevant task `Decided`/`Open`, journals, decision records, or other deeper context.

Treat “about 15 lines” as a useful compactness target, not a hard limit.

When information stops being current, replace or remove it from the current snapshot rather than appending chronology.

### Historical state archive

Meaningful superseded project-state snapshots should be preserved when they materially help reconstruct project evolution. The default location is:

```text
_ai/archive/state/
```

or the scenario-equivalent durable archive area when a scenario uses another namespace.

Preserve enough fidelity to recover earlier priorities, transitions, and project context. Do not create a separate snapshot for trivial wording/format-only edits.

The current `STATE.md` may point to the archive but should not duplicate it.

### Task journals

A task that extends beyond a **single bounded work session / working pass** and is expected to continue later should normally have a dedicated journal.

Default location:

```text
_ai/journal/T-###.md
```

The task journal is chronological / append-oriented (**oldest → newest**) and preserves meaningful working history such as:

- important steps and intermediate results;
- rationale and transitions;
- failed approaches;
- checks/validation;
- context needed to reconstruct the work later.

It is not a chat transcript.

A truly one-pass bounded task does not need a journal merely because it has a task ID. Once the task continues into later work, a journal becomes the default.

`TASKS.md` should remain the current summary and link to the journal when one exists.

### Manual chat dumps

Raw/full conversation transcripts may be preserved as a separate historical-evidence layer under:

```text
_ai/archive/chats/
```

This is **manual / explicit-request only**. Do not automatically archive every conversation, session, fork, or child session.

Create a dump only when the user directly provides/creates it or explicitly asks the agent to preserve/export the conversation. When useful, add lightweight metadata such as date/period, harness/product, topic/title, completeness (`full` or `partial`), and provenance/export method. An incomplete dump must be marked `partial`.

Chat dumps are historical evidence/raw context, not current structured project memory and not a substitute for `STATE.md`, `TASKS.md`, journals, decision records, or state archives. Ordinary startup does not load them. Use them only for deeper reconstruction when structured memory is insufficient.

If durable information recovered from a dump becomes operationally relevant again, reconcile/promote it into the appropriate current project-memory layer.

Do not register every chat dump in `SOURCES.md` automatically. Register one only when it is itself an important provenance/evidence source. Journals, decision records, or archived state snapshots may link to a dump when that materially helps reconstruction.

Do not create parallel `HANDOFF.md`, `LATEST_CONTEXT.md`, `CURRENT.md`, or `SESSION_SUMMARY.md` files by default.

## 5. Facts, decisions, assumptions, recommendations, and tasks## 5. Facts, decisions, assumptions, recommendations, and tasks

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

### Project IDs, personal workspace catalog, and cross-project references

For a small personal workspace containing multiple related projects, keep cross-project coordination deliberately lightweight.

**Stable Project ID**

- assign a stable Project ID when a project participates in a workspace catalog or cross-project references;
- the ID should remain stable across folder moves, repository renames, and scenario migrations;
- Project IDs need only be unique within the user's maintained project workspace unless a wider scope is explicitly required;
- for **new** Project IDs, prefer an uppercase ASCII hyphenated form such as `TOK-COST`, `SP-LAB-GRANT`, or `PROJECTS-REGISTRY`; letters `A-Z` and digits are suitable, semantic segments use `-`, and spaces/underscores/slashes/dots should normally be avoided;
- treat `[A-Z0-9]+(?:-[A-Z0-9]+)*` as a descriptive naming convention rather than a hard validator;
- do **not** rename an existing stable Project ID merely to normalize its style; changing an established ID is an explicit migration because references, manifests, registry entries, sources, issues/handoffs, and other metadata may depend on it;
- when another project's record is referenced, qualify the local record ID as `<ProjectID>/<RecordID>`, for example `TOK-COST/D-001`.

**Optional workspace catalog**

A personal workspace root such as `PROJECTS/` may contain one maintained `PROJECTS.md` catalog. It is a convenience/discovery index, **not canonical project state**.

A compact catalog may record:

- Project ID;
- human-readable project name;
- organizational group, such as `Tokamak`;
- local path relative to the workspace root;
- installed scenario;
- GitHub repository when applicable;
- lightweight lifecycle such as `active` or `completed`.

Projects themselves remain authoritative. If `PROJECTS.md` disagrees with a project's own runtime/manifest/project-memory files, trust the project and repair the catalog during the next maintenance pass.

Organizational folders such as `PROJECTS/Tokamak/` are ordinary grouping folders by default. Do **not** create `AGENTS.md`, `STATE.md`, `TASKS.md`, nested registries, or a separate project runtime there merely because the folder contains several projects. Promote a group folder into its own project only when it acquires an independent objective/state/task lifecycle.

Catalog maintenance may be performed by a dedicated maintenance agent on demand or periodically. A maintenance pass should use bounded discovery: inventory likely project folders, inspect project markers/runtime/manifests, compare them with `PROJECTS.md`, and update stale/missing catalog entries. Do not recursively ingest project artifacts merely to reconcile the catalog.

When the catalog is owned by a dedicated registry project, child projects do **not** gain direct write authority to that registry-owned catalog merely because their own metadata changed. If the workspace has an explicitly configured registry handoff mechanism, a child/bootstrap agent may submit a registration/update request to the registry owner; otherwise report registration as pending. Do not guess a registry repository or handoff endpoint.

**Cross-project relationships**

Keep relationship ownership distributed rather than maintaining a central dependency graph:

- the **consuming project** records meaningful project-level dependencies in its own `PROJECT.md`;
- the producer does not need to mirror a `downstream-consumer` relationship unless that reverse relationship is independently useful;
- concrete external artifacts consumed from another project are registered in the consumer's `SOURCES.md`.

Recommended cross-project source fields:

```markdown
Source project: <ProjectID>
Source store/plane: <project root | artifact root | repository | other canonical store, when needed>
Path: <path relative to that source project's named canonical root/store>
Canonical: external
Modification: read-only | editable-by-explicit-agreement
Baseline/version: <when provenance matters>
```

Use `Project ID + source-relative path` as the durable identity. A current filesystem path such as `../SiblingProject/... ` may be used as a session-resolution hint, but should not be the durable cross-project identity.

For materially important cross-project dependencies referenced **inside user artifacts**, the same durable identity rule applies. An embedded relative filesystem link may remain as a clickable/navigation convenience, but it should not be the only durable identity for a dependency that needs to survive workspace restructuring. The durable locator may live in the artifact itself or in the consuming project's `SOURCES.md`/project memory when that is sufficient; do not mechanically duplicate infrastructure annotations beside every link. Ordinary intra-project relative links are unaffected.

The maintained personal-workspace model assumes normal cross-project resources remain inside the managed `PROJECTS/` workspace and participating projects have stable Project IDs. Legacy/exceptional resources outside that workspace continue to use the existing external-source model; do not invent a Project ID merely to repair a link.

When the workspace structure is actually reorganized, or a project move/adoption can affect cross-project paths, perform a **bounded link reconciliation** for affected projects: inspect relevant cross-boundary relative links, resolve important dependencies through Project ID + canonical source-relative path, update navigation links only where the target is clear and the task requires it, and preserve ambiguity rather than mass-rewriting unrelated user documents.

This workspace/catalog layer does not introduce a new infrastructure scenario and does not require every project to share the same scenario.

**Workspace scope and active-project boundary**

An agent workspace may expose a broader filesystem root than the active project, including the whole `PROJECTS/` tree. Broader visibility is an access convenience, not a change in project ownership.

For an ordinary **single-project** task, prefer opening/rooting the execution session at the active project rather than at the shared `PROJECTS/` root when the tool/environment permits it. Broader workspace access may still be granted for reading external/source projects. This is a recommended operational default that reduces accidental discovery of sibling-project instructions; it is not a security boundary or a guarantee, and the user/operator remains responsible for how a local agent session is launched.

When a workspace contains multiple projects:

- identify one **active project** for the task unless the user explicitly requests coordinated modification of several projects;
- load that active project's runtime/project memory as the working authority;
- use the workspace-root `PROJECTS.md` only to resolve Project IDs to current project locations and lightweight catalog metadata;
- other visible projects are **external projects** relative to the active project;
- cross-project visibility grants read access only by default; it does **not** grant write authority;
- do not modify another project's project memory, canonical artifacts, repository, or source records unless the user/task explicitly includes that project as a modification target;
- when another project is used only as a source, follow the consuming project's recorded dependency/source references and preserve the source project's canonical files;
- if several projects must be modified in one task, treat each as an explicit canonical target and apply its own runtime/concurrency/write rules rather than treating the workspace root as one combined project.

**Automatically discovered external-project instructions**

Some execution environments may automatically load `AGENTS.md`, `CLAUDE.md`, or other instruction files from an external/source project when files inside that project are accessed. Project Infrastructure cannot rely on preventing that behavior.

If external-project instructions are auto-loaded:

- they do **not** make that project active;
- they do **not** expand the current session's write scope;
- they do **not** override the active project's task-control/runtime authority;
- they remain relevant for interpreting and preserving that external project's own source semantics, canonical locations, provenance, immutable/read-only constraints, and other source-specific safety rules;
- if that external project later becomes an explicit modification target, its own runtime governs writes to that project under the multi-project-write rule above.

Product-specific permission, exclusion, or workspace settings may be used as defense in depth, but correctness must not depend on a particular vendor setting or on successfully suppressing instruction auto-loading. Project-local tool-configuration directories such as `.claude/` may exist when useful; they are tool configuration, not project memory merely because they live in the project tree.

A useful session declaration is:

```text
Workspace root: PROJECTS/
Active project: TOK-COST
External source projects: TOK-HTS-SYS, TOK-RSF-HTS
```

The existence of `PROJECTS.md` at the workspace root does not make `PROJECTS/` itself a Project Infrastructure project.

## 7. One canonical copy

For every important artifact, identify one canonical copy. Avoid competing “latest” copies across folders or services.

If another copy exists for transport, conversion, review, local processing, or publication, treat it as temporary/derived and point back to the canonical artifact in `SOURCES.md` when source tracking is installed.

## 8. Safe initialization, reapplication, and file preservation

Infrastructure initialization and migration must be **non-destructive and idempotent by default**.

### Explicit standard upgrades: review before adaptation

An upgrade to a newer Project Infrastructure version is a **review and adaptation process, not a template reapplication**.

Before proposing any upgrade changes:

1. inspect the project's actual current runtime and project-memory structure, including `AGENTS.md`, infrastructure metadata/manifest, current project-memory files, and relevant support/runtime guidance;
2. treat existing project-specific rules, ordering, workflows, and conventions as potentially intentional and valuable even when they are not formally recorded as local deviations;
3. inspect the selected target standard and identify which changes are actually useful for this project;
4. prepare an explicit upgrade proposal that distinguishes:
   - what should be added;
   - what should be changed;
   - what should remain as-is;
   - where the new standard conflicts with or overlaps existing project practice;
   - which existing project-specific behavior should intentionally be preserved;
5. present that proposal to the user/project owner and obtain approval **before modifying project runtime or project-memory files**;
6. apply only the approved subset;
7. after application, update infrastructure metadata/snapshots and verify that the resulting runtime reflects the approved project-specific workflow rather than merely the upstream template.

Recorded local deviations in a manifest are useful evidence, but they are not the only source of truth. The actual current project may contain intentional rules/workflows that evolved after installation and were never formally classified as deviations.

If the target standard conflicts with current project practice and the correct choice is not obvious, preserve the current behavior until the user decides.

A mandatory universal three-way-merge protocol is not required. Git history, installed-standard snapshots, manifests, diffs, and other evidence may be used when they help reconstruct intent.

The target is:

> current project practice + useful improvements from the new standard + explicit user approval → reconciled project runtime

Before updating any existing root/project-instruction file:

1. read it first;
2. identify user-maintained/project-specific content;
3. preserve valid existing content and integrate infrastructure rules around it;
4. never replace the complete file merely because the standard contains a template;
5. if a safe merge is ambiguous, leave the original unchanged and create a proposed patch/draft in the scenario-defined work area.

Templates are shapes/defaults, not permission to overwrite existing content.

### Common bootstrap/reconcile flow

Scenario bootstrap procedures add only environment-specific steps to this common flow:

1. read `PROJECT_INFRASTRUCTURE.md`, `COMMON.md`, and the selected scenario/profile;
2. ground the scenario-defined canonical resources; do not guess among ambiguous targets;
3. determine whether the project is already initialized, uninitialized brownfield, or greenfield;
4. perform bounded discovery using §9 and read existing instructions/project-memory before modifying them;
5. determine/preserve project-memory profile and language;
6. identify canonical artifacts/sources and unresolved provenance conflicts without silently choosing among competing versions;
7. create or non-destructively update only justified project-memory/runtime/infrastructure files;
8. install the common runtime baseline plus scenario-specific `AGENTS.md` additions;
9. create/update scenario manifest and installed standard snapshot when the scenario uses them;
10. register important sources using the scenario's locator/path rules;
11. verify every canonical write actually performed; unavailable required writes remain explicit pending work rather than simulated completion;
12. run the common cold-start validation plus scenario/profile-specific additions.

For an already initialized project, steps 4–10 become **reconcile/repair/migrate only what is needed**, preserving installed state/IDs/content unless the requested migration explicitly changes them.

When infrastructure metadata shows that a project is already initialized:

- treat the operation as reconcile/repair/migration, not a new bootstrap;
- preserve current state, IDs, decisions, source registrations, language, and project-specific instructions;
- update only missing, obsolete, or explicitly migrated infrastructure behavior;
- do not recreate project-memory files from scratch;
- do not reset `STATE.md` or `TASKS.md` from a new scan unless existing files are unusable and reconstruction is explicitly justified.

When infrastructure-managed material is inserted into a **pre-existing file that also contains user/project-authored content**, the managed block **must** use stable markers:

```markdown
<!-- project-infrastructure:start -->
... infrastructure-managed runtime rules ...
<!-- project-infrastructure:end -->
```

On reapplication, update only the marked managed block.

A file created and owned entirely by the infrastructure may omit the markers while it remains wholly infrastructure-owned. If user/project-authored content is later mixed into that file, convert the infrastructure-owned portion to a marked block before further automated maintenance.

Existing substantive tool-specific files such as `CLAUDE.md` follow the same preservation rule. Never add unmarked infrastructure text to an existing mixed-ownership instruction file.

## 9. Bounded discovery and source registration

Bootstrap/reconstruction should discover enough to establish project purpose, state, authority, dependencies, and deliverables without recursively ingesting the whole project.

Default discovery pattern:

1. **Inventory first:** inspect names/types/metadata at the project/store root and normally no more than about 2 levels below it.
2. **Targeted expansion:** go deeper only into specific branches needed to understand the project or current task.
3. **High-value reads:** prioritize existing instructions/README/manifests, current/final/approved documents, obvious code/CAD/notebook/data entry points, files explicitly named by the user, and artifacts referenced by authoritative sources.
4. **Avoid bulk ingestion:** skip caches, dependencies, generated trees, backups, large archives, vendor folders, and dependency leaves unless directly relevant.
5. **Use format-aware inspection:** for large or complex artifacts prefer metadata, targeted sections, application-aware tools, summaries, or bounded extraction over loading everything.

When `SOURCES.md` is installed, register an artifact or logical group when at least one is true:

- it is authoritative/canonical;
- it is an important non-reconstructable input/raw dataset;
- provenance/version matters;
- it is a current major deliverable/output;
- modification restrictions matter;
- it is an external dependency/source required to reproduce or continue work;
- it is a dependency-sensitive application entry point (for example a main CAD assembly/project).

Do not register every ordinary file, cache, generated intermediate, or dependency leaf.

Scenario files may add store-specific discovery rules, locators, and preservation constraints; they should not restate this generic process.

## 10. Security, secrets, and personal data

Project-memory/infrastructure files must not become a credential store.

Never write passwords, API keys/tokens, OAuth/refresh tokens, session cookies, private keys, seed phrases, database credentials, or access tokens embedded in URLs into infrastructure-managed text files.

If a secret is required by the workflow, record only a non-secret reference such as `configured via environment variable`, `stored in system credential manager`, or a secret-manager identifier.

If a secret is discovered in project content, avoid echoing/propagating it. Flag the exposure and, when relevant, recommend moving it to an appropriate credential mechanism and rotating/revoking it.

Personal/sensitive data should be minimized in project memory. Prefer references to protected canonical sources over duplication.

## 11. Root-file guidance

### `README.md`

Keep it short when present: project name, one-paragraph purpose, basic structure, pointer to `AGENTS.md`, and essential human setup/opening instructions. Do not duplicate detailed current state.

### `AGENTS.md`

`AGENTS.md` must be sufficient for a future agent to discover and follow the installed runtime without external-standard access.

A useful baseline contains the following shape. The `Infrastructure` field names/controlled values remain in their defined English forms; ordinary headings and prose use the installed project-memory language. Example for `ru`:

```markdown
# Инструкции для агента

## Infrastructure
Scenario: <scenario-id>
Installed standard version/commit: <version and commit/ref when known>
Local infrastructure metadata: <manifest path>
Project-memory profile: <Minimal/Standard>
Project-memory language: <ru/en/...>
Installed project-memory files: <actual files>

Для обычной работы этот файл и установленные файлы project memory являются источником истины. Не обращайся к внешнему репозиторию стандарта и не загружай snapshot стандарта, кроме задач аудита, ремонта или миграции инфраструктуры.

## Запуск
Читай только те файлы project memory, которые нужны для текущей задачи, начиная с актуального состояния и задач.

## Правила работы
- Если файлы проекта противоречат запомненному контексту чата, приоритет имеют файлы проекта.
- Сохраняй canonical source files, если задача явно не требует их изменения.
- Веди обычную прозу project memory на установленном языке проекта.
- Сохраняй filenames, record IDs и controlled status values в их определённых английских формах.
- Различай факты, решения, допущения, рекомендации и задачи.
- Никогда не сохраняй secrets или credential values в project-memory/infrastructure files.
- Следуй scenario-specific runtime rules, записанным в этом файле.

## Перед завершением существенной работы
- Перечитай shared project-memory files, которые собираешься изменить, и согласуй конкурентные изменения.
- При необходимости обнови актуальное состояние, задачи и другие установленные project-memory files.
- Зафиксируй существенные решения в месте, определённом сценарием.
- Оставь проект в состоянии, позволяющем продолжить работу без предыдущего чата и внешнего стандарта.
```

Do not turn `AGENTS.md` into a full project encyclopedia.

Treat `AGENTS.md` primarily as the **runtime entry point**. Its exact section order is adaptive rather than permanently fixed: guidance used in ordinary work should stay close to the startup/runtime path, while bulky or rare procedures may move to support files. When moving a rule out, keep a concise pointer and a clear trigger that tells a fresh agent when the support file must be read. Frequently used guidance may later be promoted back toward the entry path.

Remove accidental duplication instead of preserving repeated rules for historical reasons.

When durable project-wide interaction rules exist, keep a bounded **Working with the user / Работа с пользователем** section (or an equivalent support file reached through a clear pointer). It is for durable rules that materially affect work across many tasks in this project, not for a general profile of the user. Task-, document-, tool-, source-, or one-off instructions belong near their relevant scope.

A newly stated rule should be promoted here **in the same session once its durable project-wide intent is clear**, especially when the user explicitly indicates future applicability. Do not interpret every casual phrase as a permanent rule.

### Common runtime baseline

Every scenario's **canonical full-runtime `AGENTS.md`** must materialize the common rules needed during ordinary work. At minimum it must make discoverable:

- installed scenario, standard version/commit when known, project-memory profile/language, installed project-memory files, and infrastructure metadata path;
- canonical project/runtime authority and the rule that remembered chat context is non-authoritative when it conflicts with project files;
- progressive disclosure/startup order, with `STATE.md / Now` and the current task summary as the fast path;
- proportional task path (read-only / bounded small edit / full scenario transaction);
- current task-memory semantics: `Decided` / `Open` when meaningful and task journals for work that continues beyond one bounded work pass;
- durable project-wide user-working rules when such rules exist;
- canonical-target-first tool routing: identify the authoritative store/artifact before choosing connector, filesystem, browser, or workspace operations;
- programmatic/API text writes with materially important escape-sensitive syntax must verify the persisted result rather than treating write acknowledgement as proof of textual integrity;
- installed project-memory language rule;
- canonical/source preservation and one-canonical-copy rule;
- secrets/credentials prohibition;
- optimistic concurrency: re-read shared state immediately before writes and reconcile changes;
- manual/external/delegated artifact reconciliation: project memory may temporarily lag artifact changes, and explicit refresh/reconcile uses bounded discovery without guessing supersession;
- end-of-substantial-work synchronization/handoff expectations;
- scenario-specific runtime additions.

Scenario files must list **only their additional runtime requirements**, not repeat this common baseline.

### `PROJECT.md`

Recommended content: objective; scope; deliverables; constraints; definitions/terminology; success criteria.

When project-specific terminology, abbreviations, mode names, part labels, stage names, or other notation becomes non-trivial enough to create interpretation risk, keep a durable **Terminology / Словарь** section. Prefer `PROJECT.md` while the glossary is compact; move it to a dedicated support file such as `TERMINOLOGY.md` when growth makes that clearer, leaving an explicit pointer.

Do not create a glossary merely because the project uses the Standard profile, and do not turn it into a dictionary of ordinary domain terminology. `STATE.md / Now` may point to the glossary when terminology materially affects understanding of the current work, but that pointer is not mandatory.

If an important project term is unclear, first search authoritative current project documents/registered sources. If it remains unclear, ask the user rather than guess. If asking is not currently appropriate or the user defers the question, record it in the relevant `Open` summary until resolved. Once clarified and likely to matter again, add the durable definition to the glossary.

### `STATE.md`

Recommended content: a compact `Now / Сейчас` current snapshot first, followed as needed by last updated; current phase/status; completed context that is still operationally relevant; in progress; blocked/waiting; current canonical outputs; key current conclusions; immediate next actions; pointers to deeper task/history layers.

Rewrite the current snapshot instead of appending a session log. Preserve meaningful superseded project-state snapshots under the historical-state rules in §4.

### `TASKS.md`

Use stable `T-###` IDs. Controlled task statuses are `todo`, `active`, `blocked`, `done`, `cancelled`.

For a **non-trivial active task**, when meaningful content exists, keep:

- `Decided` — current durable decisions and user answers that govern continuation;
- `Open` — unresolved questions that may affect continuation.

Do not add empty `Decided`/`Open` sections to trivial tasks.

`Decided` is **current state, not decision history**. Remove superseded/cancelled items from the current summary; preserve rationale/history in the task journal or a `D-###` record when needed.

Before asking the user a question that may already have been settled, check the task's `Decided` summary first, then relevant journal/decision records if necessary.

If the user provides a new durable answer/decision during any session and it materially changes or clarifies an active task, record it in `Decided` in the same session, even when the original request was informational/read-only.

When a task continues beyond one bounded work session/pass, link its dedicated journal as defined in §4.

`TASKS.md` is an active working set, not a permanent ledger. Keep active/blocked/todo tasks plus recently completed items that still provide useful context. Periodically archive older `done`/`cancelled` entries under the scenario-defined task archive while preserving IDs and evidence references.

### `ASSUMPTIONS.md`

For engineering, scientific, cost-estimation, research, planning, and analytical projects, an explicit uncertainty register is strongly recommended.

### `SOURCES.md`

`SOURCES.md` is a **source/canonical-artifact registry, not a work log**.

Register important authoritative information/artifacts. Record when useful: `S-###` ID, title/name, type, canonical location/path/URL/ID, canonical status, provenance, purpose, modification restrictions, version/date.

Do not accumulate chronological work notes there. Put working history in the relevant task journal/history layer.

### Working documents and derived artifacts

Working documents should primarily expose their **current state**. Superseded material should not accumulate in the main body merely to preserve chronology.

Preserve history through the mechanism that best fits the artifact: an explicit revision/history section when useful, the task journal, Git history, project/state archives, or another defined historical layer. Do not impose one mandatory header/revision-history template across all artifact types.

Open questions maintained inside a working document should remain consistent with the relevant task's `Open` summary.

For generated/derived artifacts, identify the source of truth. When an artifact is truly **derived and reproducible** from another source, the normal workflow is to modify the source and regenerate the derived output rather than manually editing the generated file. Do not apply that rule mechanically to every PDF/DOCX/XLSX or file that happened to be generated once; if such an artifact becomes a canonical manually maintained deliverable, treat its current role accordingly.

Distinguish facts, decisions, assumptions, estimates, and recommendations where that distinction materially affects interpretation or continuation.

### Operational know-how and pitfalls

Durable operational knowledge discovered during project work should not remain only in chat context.

If a finding is clearly **local to the current project** and is likely to recur, prevent a real mistake, or materially improve reproducibility/continuation, record it promptly in the same session once its durable value is clear. Store it as close as practical to the area where it is used: tool-specific README, workflow/support file, `AGENTS.md`, relevant task journal, or another domain-specific project file.

Do not document every incidental observation.

If a finding appears broader than the current project — for example cross-project operational knowledge, reusable agent workflow, model-routing lesson, harness/product-specific guidance, candidate reusable skill, or common infrastructure rule — do **not** silently copy/promote it into a shared repository or another project. Surface an explicit proposal to the user/project coordinator to preserve/promote it in the appropriate shared area. A local note/reference may remain meanwhile when needed for continuity.

## 12. Decisions and plans

Use `D-###` for significant decision records whose rationale must survive future sessions. Use `P-###` for substantial plans spanning long runs, multiple sessions, or multiple agents.

Decision/plan storage locations are scenario-defined. When a decision changes, normally create a new record and mark the old one `Superseded` rather than rewriting history.

## 13. End-of-session synchronization

Before ending substantial work:

1. re-read every shared project-memory file you intend to modify;
2. reconcile concurrent changes instead of overwriting them;
3. update installed current-state/task/source/assumption files as relevant;
4. record significant decisions and durable user answers in the current task summary;
5. update the task journal when work will continue beyond the current bounded pass;
6. record newly discovered durable **project-local** operational know-how when its value is clear;
7. archive stale completed/cancelled tasks when `TASKS.md` becomes noisy;
8. preserve the installed project-memory language;
9. leave the project continuable without the previous chat or external standard.

## 14. Concurrent agents and shared-state writes

Use optimistic concurrency for shared project state. **No agent, including the primary/project-coordinator agent, may assume it is the only writer.**

Before modifying a shared canonical/runtime/project-memory file:

- re-read the current canonical version immediately before the write;
- do not treat an earlier local copy or remembered chat content as current;
- if the file changed, reconcile newer content and preserve intervening work;
- if reconciliation is not reliable, do not silently overwrite; preserve the conflict and surface it.

Avoid assigning two active agents to the same task/canonical artifact unless coordinated. For parallel work, prefer separate task IDs/work areas and deliberate reconciliation.

If an agent launches subagents, forks, child sessions, or delegated workers, **coordination and reconciliation remain the launching/parent agent's responsibility**. The standard does not require a separate locking/orchestration protocol merely because delegated work exists.

When a conflict cannot be reconciled confidently, preserve both contributions in a non-canonical work area and surface the conflict.

A dedicated multi-agent scenario may later add stronger coordination/locking rules if a real project demonstrates the need.

## 15. Cold-start validation

A bootstrap, repair, migration, or substantial memory restructuring is not complete merely because files were created or edited.

Validate from the perspective of a **fresh agent** that has only the scenario-defined project entry resources/canonical-store access and no originating-chat context. The agent should be able to discover or enter the canonical `AGENTS.md` runtime (directly or through a thin scenario/product adapter) and answer representative questions such as:

- where the project currently stands;
- what has already been decided for the relevant active work;
- what remains open;
- what the immediate next step is;
- where key current artifacts/sources live;
- which scenario/runtime constraints materially affect the next work.

For an `independent-agent` validation, the fresh agent should:

- answer only from project files and scenario-defined canonical resources;
- identify/cite where each answer was found;
- say `not found` (or equivalent) rather than guess;
- **not ask the user during the test**, because that would hide memory gaps;
- surface contradictions, unclear wording, broken references, and missing durable information as findings.

The requesting/coordinating agent should know the expected answers or otherwise have a reliable comparison basis and evaluate the result after the run.

There is no fixed mandatory number of questions and no universal requirement to create a dedicated report file. Use a representative set appropriate to the project's complexity and current risks. Preserve a durable report when the validation is substantial/diagnostic or later auditability matters.

Re-run independent validation after **substantial memory restructuring or migration**, not after every ordinary project-memory edit.

When an independent fresh-agent run is available and proportionate, use it. Otherwise perform the same check explicitly using only the installed runtime and scenario-defined entry resources.

Validate **effective behavior**, not merely file presence. If the active product does not expose all loaded instruction files in its memory/context UI, confirm the startup/instruction announcement when available or ask the fresh agent to state the project/scenario/runtime rules it actually received. Do not treat a file existing on disk as proof that the product loaded it.

Report the validation method accurately:

- `independent-agent` — a genuinely separate fresh agent/session without the originating-chat context exercised the startup path;
- `checklist/simulated-fresh` — the current agent deliberately exercised the startup path using only the installed runtime and scenario-defined entry resources, without relying on originating-context knowledge;
- `partial` or `not run` — the startup path could not be fully exercised; record the limitation/reason.

Do not describe a self-check as an independent-agent validation. `checklist/simulated-fresh` is an acceptable normal method when an independent run is unavailable or disproportionate, provided it exercises the actual startup route rather than merely confirming that expected files exist.

Findings from cold-start validation are ordinary project-memory defects: fix them, or leave them explicitly open when resolution is deferred.

## 16. Universal `AGENTS.md` and tool-specific adapters## 16. Universal `AGENTS.md` and tool-specific adapters

`AGENTS.md` is the **canonical vendor-neutral instruction convention** for this standard. Each project has one **canonical full-runtime `AGENTS.md`** in its scenario-defined runtime/control store.

A scenario may also use additional local/scoped `AGENTS.md` files as thin bootstrap adapters or path-scoped instruction files. Those additional files must not duplicate current project state or become competing full-runtime copies; they must lead to, or remain consistent with, the canonical full-runtime `AGENTS.md`.

Rules that are valid regardless of the active agent belong in the canonical `AGENTS.md`. Current project state belongs in the project-memory files named from it, not in vendor-specific instruction files.

Tool-specific entry files/workspace instructions are optional thin adapters. They must not become independent copies of project state or duplicate the general runtime rules.

### Claude Code

`AGENTS.md` remains the canonical shared source of truth.

During the current pre-pilot period, create a minimal project-level `CLAUDE.md` compatibility adapter **by default** alongside the canonical `AGENTS.md`:

```markdown
@AGENTS.md
```

This is a temporary compatibility policy, not a second source of truth. The adapter exists to make Claude's relationship to `AGENTS.md` explicit across environments while native `AGENTS.md` support is still settling.

Rules:

- shared/runtime rules live only in `AGENTS.md`;
- the default `CLAUDE.md` contains only `@AGENTS.md`;
- add Claude-specific instructions below the import only when there is a concrete Claude-only requirement;
- never copy shared project rules into `CLAUDE.md`;
- preserve an existing substantive `CLAUDE.md` non-destructively and ensure it explicitly imports `@AGENTS.md` when safe;
- do not make project correctness depend on a user-global Claude setting;
- do not rely on Claude-specific `@path` imports inside canonical `AGENTS.md` for cross-tool behavior.

Claude Code 2.1.277+ can load `AGENTS.md` natively in supported environments, but project-specific `CLAUDE.md`, `.claude/CLAUDE.md`, or `CLAUDE.local.md` can alter fallback behavior, and support remains version/provider/configuration dependent. The explicit adapter avoids relying on that fallback.

A future standard revision may retire the default adapter after native support has been stable long enough in the target environments. Such removal must be an explicit migration, not an automatic deletion of user-authored `CLAUDE.md` files.

### Codex

Use the root `AGENTS.md` directly.

Add nested `AGENTS.md` files only when a subdirectory needs materially different or path-scoped rules. Keep the root `AGENTS.md` self-contained enough for ordinary project startup.

For cross-tool portability, do not rely on Claude-specific `@path` import behavior inside canonical `AGENTS.md` unless all required agents are known to support the same semantics.

### ChatGPT Work / Cowork / other project agents

When a product does not automatically discover `AGENTS.md`, configure its project/workspace instructions as a thin adapter that points to the canonical `AGENTS.md`.

Do not maintain separate full copies of current project state inside product-specific instructions.

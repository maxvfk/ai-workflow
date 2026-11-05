# Review decisions — G2 pilot part 3

Date started: 2026-11-02  
Source review: `project-infrastructure/pilots/2026-10-G2-SP-LAB-GRANT-part3.md`  
Scope: F-25…F-36  
Status: in progress

This file records review decisions separately from the original pilot report so that the report remains unchanged as evidence. Findings are added here after explicit review with the project owner. Standard changes are implemented separately after the relevant decision is accepted.

## F-25 — Новый агент переспрашивает решённое

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

For a non-trivial active task, when there is meaningful content to preserve, `TASKS.md` should expose compact current summaries:

- **Decided** — current decisions and durable user answers relevant to the task;
- **Open** — unresolved questions that still require work or an explicit user decision.

Before asking the user a question that may already have been settled, the agent should check the task's `Decided` summary and, when needed, its journal or linked decision records.

`Decided` represents **current state, not history**. Superseded or cancelled decisions are removed from the current summary; durable rationale/history remains in the task journal or a `D-###` decision record when appropriate.

### Modification to the pilot proposal

Do not require empty `Decided` / `Open` sections for trivial tasks that have nothing meaningful to summarize.

A read-only/informational request does **not** by itself require a project-memory write. However, if during any session the user provides a new durable answer or decision that materially changes or clarifies an active task, record that information in `Decided` in the same session even if the original request was informational.

### Rationale

The pilot showed that merely storing answers inside chronological task history is insufficient for cold-start continuity: a fresh agent may technically have the information available but still re-ask settled questions because the current decision state is not directly visible.

---

## F-26 — Нет короткой точки входа: «где мы сейчас»

**Decision:** ACCEPT

### Accepted

`STATE.md` should begin with a compact **Now / Сейчас** section that gives a fresh coordinator the current operational picture:

- active work streams;
- where the project currently stands;
- immediate next steps;
- pointers to the relevant task `Decided` / `Open` summaries, journals, or decision records;
- key current artifacts/files when useful.

The `Now` section is a **current snapshot**. It is rewritten/updated when the situation changes rather than extended as a chronological log. It should remain compact enough to serve as the first operational entry point; the pilot's “≈15 lines” is guidance, not a hard line-count requirement.

Startup should read `Now` first after the runtime entry point, then expand into task/project history only as needed.

### Historical state archive

Superseded **meaningful project-state snapshots or substantive STATE sections** should be preserved under a scenario-defined archive such as:

`_ai/archive/state/`

The purpose of this archive is not merely backup. It preserves the recoverable chain of project development so that a future coordinator can reconstruct how the project reached its current state, including earlier priorities, work streams, transitions, and context that may no longer belong in the current `STATE.md`.

Preserve archived state with enough fidelity to recover that historical context; do not reduce every previous state to a lossy one-line summary when the original snapshot is still useful.

Minor wording/format-only changes do not need a separate archive snapshot.

Current `STATE.md` should point to the historical-state archive without duplicating its contents.

### Relationship to other memory layers

- `STATE.md / Now` — current project-wide operational position.
- `TASKS.md / Decided / Open` — current state of individual tasks.
- task journals — detailed history of individual work.
- `_ai/archive/state/` — historical evolution of the project as a whole.
- `D-###` — durable rationale for significant decisions.

### Rationale

The pilot demonstrated that a current-state file can satisfy the standard syntactically yet still fail as an entry point when historical sections accumulate. At the same time, discarding old state would remove context needed by future coordinators. A compact current snapshot plus preserved historical states provides both fast startup and reconstructable project history.

---

## F-27 — Где вести журнал длительной задачи

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

A task that extends beyond a single bounded work session / working pass and is expected to continue later should have a dedicated journal.

Default location:

`_ai/journal/T-###.md`

The threshold is intentionally low: do not wait until the task becomes large or complicated. If a task has already become longitudinal enough that a future session or coordinator may need to understand what happened before, create the journal.

`TASKS.md` remains the current operational summary and should normally keep:

- task status;
- `Decided` when there are durable decisions/answers;
- `Open` when unresolved questions remain;
- a link to the journal.

The journal preserves the meaningful working history of the task: important steps, intermediate results, rationale, failed approaches, checks, transitions, and context needed to reconstruct how the current state was reached. It is not a transcript of the chat.

### Modification to the pilot proposal

This is a **common Project Infrastructure mechanism**, not a G2-specific one. Scenarios may define a different locator only when their storage model genuinely requires it; otherwise `_ai/journal/T-###.md` is the normal default.

The journal should be **chronological / append-oriented (oldest to newest)** rather than newest-first. Current state is already available through `TASKS.md` and `STATE.md / Now`; the journal's primary role is historical reconstruction.

A task that is truly completed in one bounded working pass does not need a journal merely because every task has an ID. Once a task continues into later work, the journal becomes the default.

### Rationale

The project needs both fast current-state access and recoverable reasoning/history. Creating journals early for tasks that persist across work sessions prevents important context from being lost before anyone notices that the task has become “long-running”, while keeping one-pass tasks lightweight.

---

## Cross-cutting decision — Manual chat dumps

**Decision:** ACCEPT

Raw/full chat transcripts may be preserved as a separate historical-evidence layer when the user explicitly creates them or asks an agent to create them.

Default location:

`_ai/archive/chats/`

### Creation policy

Chat dumps are **manual / explicit-request only**.

Do not automatically archive every conversation, session, fork, or child session. Create a chat dump only when:

- the user creates/provides it directly; or
- the user explicitly asks an agent to preserve/export the conversation.

This mechanism must not become an automatic logging system.

### Suggested naming and metadata

Use a date plus a short descriptive slug when practical, for example:

`_ai/archive/chats/2026-11-05-chatgpt-g2-review.md`

A dump should preserve the available original conversation content with minimal transformation.

When useful, include lightweight metadata such as:

- date / covered period;
- harness/product;
- conversation/session title or topic;
- completeness: `full` or `partial`;
- source/export method when provenance matters.

If the available transcript is incomplete, mark it explicitly as `partial`; do not silently present a partial export as the full conversation.

### Role in project memory

Chat dumps are **historical evidence / raw context**, not current structured project memory and not a replacement for:

- `STATE.md / Now`;
- `TASKS.md / Decided / Open`;
- task journals under `_ai/journal/`;
- decision records `D-###`;
- historical project-state snapshots under `_ai/archive/state/`.

Ordinary startup should not load chat dumps.

Read a chat dump only when deeper historical reconstruction is needed — for example, to recover detailed rationale, intermediate discussion, wording, or context that was intentionally condensed out of the current summaries/journals.

When a chat dump contains durable information that becomes operationally relevant again, promote/reconcile that information into the appropriate current structured memory rather than making ordinary project operation depend on repeatedly reading the raw transcript.

### References and source registration

A task journal, decision record, or historical-state snapshot may link to a relevant chat dump when that improves traceability.

Do not register every dump in `SOURCES.md` automatically. Register one only when it has become an important provenance/evidence source for the project.

### Rationale

Structured project memory should remain compact and operational, but long-running projects may occasionally require access to the original conversation to reconstruct reasoning that summaries necessarily compress. A manual raw-transcript archive provides that recovery path without forcing every agent to ingest chat history or turning the repository into an automatic conversation log.

---

## F-28 — Параллельные агенты, форки и дочерние сессии пишут в одну память

**Decision:** ACCEPT WITH SIMPLIFICATION

### Accepted

Any agent working with shared project state must assume that the canonical project state may have changed since it was last read, regardless of who is considered the main project coordinator.

Before modifying shared project-memory/runtime files:

- read the current canonical version;
- do not treat an earlier local copy or remembered chat context as current state;
- preserve intervening changes made by other actors;
- if the new changes cannot be reconciled confidently, do not silently overwrite them.

This applies to the main coordinator as well as any other agent.

### Subagents

If an agent launches subagents, forks, child sessions, or delegated workers, coordination of those workers and reconciliation of their results remains the responsibility of the launching/parent agent.

Project Infrastructure does not need a separate orchestration protocol for those internal subagents by default.

### Simplification relative to the pilot proposal

Do not standardize detailed mechanics such as mandatory surgical edits, push-after-every-change, or a special fork/child-session concurrency model.

The durable rule is simply that no agent should assume it is the only writer to project state.

### Rationale

The user's normal workflow does not intentionally run multiple independent coordinators against the same project at once. A lightweight optimistic-concurrency assumption is therefore sufficient: always ground writes in current canonical state, while leaving subagent coordination to the agent that created those subagents.

---

## F-29 — Временный checkout может исчезнуть вместе с непубликованной работой

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

A harness-provided temporary / ephemeral checkout is disposable and may disappear or become unusable without warning.

Do not treat unpushed commits or working-tree changes that exist only in such a checkout as durable project state.

Work may remain local while a logical step is actively in progress, but once a result needs to survive the current work session / checkpoint, publish it to the canonical repository.

A persistent local clone is not subject to the same assumption of immediate disposability, but the canonical repository remains the durable project store.

### Modification to the pilot proposal

Do **not** require commit + push after every small edit.

The durability boundary is a completed logical step / checkpoint or any point where losing the local workspace would cause loss of work that is expected to persist.

If an ephemeral checkout is lost or damaged:

- recreate it from the canonical repository;
- treat the repository as authoritative;
- reconcile any surviving unpersisted working files into the fresh checkout when useful;
- do not treat the damaged/partial checkout as canonical.

### Rationale

Current G2 already defines GitHub as the permanent canonical control/state store and allows Mode B to use an ephemeral checkout. This finding makes the durability consequence explicit: an ephemeral checkout is execution state, not a safe long-term location for the only copy of completed work.

---

## F-30 — `AGENTS.md` слишком велик, а главное — не в начале

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

`AGENTS.md` should function primarily as the project's runtime entry point, not as a complete infrastructure encyclopedia.

Order and placement should favor information needed in ordinary work:

- startup / where to begin;
- current project-memory workflow;
- common working rules;
- rules for maintaining project memory and documents;
- end-of-work synchronization;
- ordinary scenario-specific runtime rules.

Rare or special-case procedures may move to support files when that makes the main runtime easier to use.

A rule may be moved out of `AGENTS.md` only if `AGENTS.md` still contains:

- a concise mandatory summary of the rule when needed for safe behavior;
- an explicit pointer to the support file;
- a clear trigger explaining when that support file must be read.

Compact runtime/infrastructure identity should remain easy to find near the beginning, for example scenario, project-memory profile/language, canonical control/store, and installed standard metadata. There is no requirement to move all Infrastructure metadata to the bottom.

Remove accidental duplication such as repeated `Project-memory language` fields.

### Adaptive structure

The exact layout of `AGENTS.md` is not fixed permanently.

As the project evolves, content may move between `AGENTS.md` and support files according to actual use:

- frequently needed guidance may be promoted closer to the runtime entry path;
- rarely needed or bulky guidance may be moved to a support file;
- moved content must remain discoverable through an explicit trigger/pointer;
- restructuring should improve progressive disclosure without making important rules invisible.

### Modification to the pilot proposal

Do not standardize one rigid section order or require `Infrastructure` to be physically last.

The standard should define the information hierarchy and progressive-disclosure principle, while allowing project-specific ordering to evolve with observed usage.

### Rationale

The pilot showed that a technically complete `AGENTS.md` can become harder to use when rare infrastructure cases dominate the entry path. At the same time, over-aggressive extraction can hide rules that agents need. An adaptive progressive-disclosure model preserves both fast startup and discoverability.

---

## F-31 — Нет места для устойчивых правил работы с конкретным пользователем

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

Projects may keep a dedicated **Working with the user** section in `AGENTS.md` for durable project-wide interaction rules that should affect ordinary work across many tasks and future sessions.

Typical examples include:

- do not interpret silence or an unanswered question as approval;
- do not proactively remind about parked/deferred work unless asked;
- preserve rather than delete when the project has an established archive workflow;
- do not modify an artifact that the user has explicitly said they are currently reviewing;
- other durable interaction rules that materially affect work throughout the project.

When a user clearly establishes a durable project-wide working rule, record it in project memory so it survives future sessions.

### Scope boundary

This section is **not** a general profile of the user.

Keep only rules that materially affect work in this project.

Task-specific, document-specific, tool-specific, source-specific, or one-off instructions should remain close to the relevant task/artifact/tool/support file rather than being promoted into the project-wide user-working section.

Do not treat every casual phrasing or one-time request as a durable rule. Promote it when the user explicitly indicates future applicability or when the durable project-wide intent is otherwise clear.

### Progressive disclosure

If `Working with the user` grows large over time, it may move to a support file under the F-30 adaptive-structure principle, provided `AGENTS.md` retains a concise pointer and a clear trigger to read it.

### Rationale

Long-running projects accumulate interaction rules that are neither project facts nor task decisions. Without a durable project-wide home, those rules become scattered across journals and chat history and are repeatedly rediscovered. A bounded `Working with the user` layer preserves continuity without turning project memory into a general personal profile.

---

## F-32 — Правила ведения рабочих документов и `SOURCES.md`

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

Working documents should primarily expose their **current state**. Superseded material should not accumulate in the main body merely to preserve chronology.

Historical context may be preserved through the mechanism that best fits the artifact:

- an explicit history/revision section when useful;
- the task journal;
- Git history;
- project/state archives;
- another project-defined historical layer.

`SOURCES.md` is a **source/canonical-artifact registry**, not a work log. It should describe what the source/artifact is, where it lives, its canonical/provenance status, modification restrictions, purpose, and other durable source metadata. Chronological work notes should live elsewhere.

For generated/derived artifacts, identify the source of truth. When the artifact is reproducible from that source, the normal workflow is to modify the source and regenerate the derived artifact rather than manually editing the generated output.

Open questions maintained inside a working document should remain consistent with the relevant task's `Open` summary.

Distinguish facts, decisions, assumptions, estimates, and recommendations where that distinction materially affects interpretation or continuation of the work.

### Modification to the pilot proposal

Do not impose one mandatory document format across all artifact types.

In particular, do not require every working document to have a fixed header such as `Revision N, date — change` or an embedded `Revision history` section. Those are useful patterns for some documents, but the standard should define the semantics rather than one universal presentation template.

Do not treat every Excel/PDF/DOCX or script-produced file as permanently non-editable merely because it was generated once. The regeneration rule applies when the file is truly **derived and reproducible** from another source of truth. If a generated artifact later becomes a canonical manually maintained deliverable, its role must be treated accordingly rather than forcing regeneration semantics that no longer match reality.

Dates on individual `Decided` items are optional and should be added when they materially help provenance or interpretation; the task journal already carries the detailed chronology.

### Rationale

The pilot showed the same failure mode in working documents and source records as in `STATE.md` / `TASKS.md`: current information became buried under accumulated chronology. Separating current content from history keeps working artifacts usable while preserving provenance in the appropriate historical layer. Keeping `SOURCES.md` declarative also prevents it from becoming a second task journal.

---

## F-33 — Operational know-how и «подводные камни» теряются в контексте чата

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

Durable operational know-how discovered during project work should not remain only in chat context or compaction summaries.

When a finding is **local to the current project** and is clearly useful for future work, record it promptly in the project in the place closest to the affected area, for example:

- `tools/README.md` or a tool-specific README for scripts/tooling behavior;
- a workflow/support file for a specific project workflow;
- `AGENTS.md` when the rule affects ordinary work across the project;
- the relevant task journal when the finding is still task-scoped;
- another domain-specific project file when that is the natural canonical home.

Typical durable findings include non-obvious tool quirks, failure modes, dangerous/repeat-prone mistakes, ordering constraints, API/application behavior, site-specific limitations, and other knowledge that materially improves reproducibility or prevents future errors.

### Local findings: write directly

If the finding is clearly project-local and belongs in the current project's existing write scope, record it **in the same session once its durable value is clear**. Do not postpone it merely because the current chat still remembers the context.

Do not document every incidental observation; promote findings that are likely to recur, prevent a real mistake, or materially affect continuation/reproducibility.

### Potentially reusable findings: propose promotion

If a finding appears to be broader than the current project — for example:

- general cross-project operational knowledge;
- reusable agent workflow;
- model-routing lesson;
- harness/product-specific guidance;
- candidate reusable skill or common Project Infrastructure rule;

do **not** silently promote/copy it into `ai-workflow` or another project.

Instead, surface an explicit proposal to the user / project coordinator to preserve or promote it in the appropriate shared area, such as:

- `ai-workflow` general notes/rules;
- `skills/`;
- a harness/product-specific directory such as `claude-desktop/`;
- model-routing materials;
- Project Infrastructure, when the finding is genuinely infrastructure-wide.

The current project may keep a local note/reference meanwhile when needed for continuity.

### Placement principle

Store operational know-how as close as practical to the area where it is used. `tools/README.md` is a useful pattern, not a mandatory universal destination.

If a local rule later proves broadly reusable, it may be promoted through the explicit proposal/review path rather than duplicated indefinitely across projects.

### Rationale

The pilot showed that valuable operational knowledge disappears when it lives only in chat history. Writing project-local findings promptly preserves continuity. Requiring an explicit promotion proposal for broader findings keeps shared repositories curated and prevents agents from expanding cross-project guidance or harness rules without user review.

---

## F-34 — Словарь обозначений и проектной терминологии

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

When a project develops non-trivial internal terminology, abbreviations, part labels, mode names, stage names, or other project-specific notation, keep a durable **Terminology / Словарь** section.

Default placement:

- keep a compact glossary in `PROJECT.md` while it remains small;
- if it grows enough to reduce usability, move it to a dedicated support file such as `TERMINOLOGY.md` and keep an explicit pointer from the project entry/memory layer.

A glossary is required when project-specific terminology has become materially important for correct continuation, not merely because the project uses the Standard profile.

The glossary should explain project-specific meanings and non-obvious notation that a fresh coordinator may otherwise misunderstand. It should not become a dictionary of ordinary domain terms that are already unambiguous in context.

`STATE.md / Now` may point to the glossary when terminology is important for understanding the current work, but such a pointer is not mandatory for every project/session.

### Unknown terminology

When an agent encounters an important project term or notation whose meaning is not known with sufficient confidence:

1. first look for an authoritative explanation in the project's canonical/current documents or registered sources;
2. if the meaning is still unclear, ask the user rather than guess;
3. if asking is not currently appropriate or the user defers the question, record it in the relevant `Open` summary until resolved.

Once clarified and likely to matter again, add the durable definition to the glossary.

### Modification to the pilot proposal

Do not make a glossary mandatory for every Standard-profile project. Introduce it when the project's terminology is non-trivial enough to create continuity or interpretation risk.

Do not require a permanent glossary pointer in `Now`; use one when it materially improves startup for the current work.

### Rationale

The pilot showed that a fresh agent can understand project state yet still misinterpret the work because internal abbreviations and notation are undocumented. A lightweight, need-driven glossary closes that gap without creating empty infrastructure in projects where terminology is already obvious.

---

## F-35 — Проверка cold-start через независимого fresh agent

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

Independent fresh-agent validation is a useful acceptance test for project memory, especially after bootstrap, migration, or a substantial restructuring of the memory layer.

When proportionate and available, run a genuinely independent agent/session with no originating-chat context and ask representative questions such as:

- where the project currently stands;
- what has already been decided;
- what remains open;
- what the immediate next step is;
- where key current artifacts/sources live;
- which runtime/project constraints materially affect the next work.

The fresh agent should:

- answer only from project files and scenario-defined canonical resources;
- cite or identify where each answer was found;
- say `not found` / equivalent rather than guess;
- avoid asking the user during the test, because that would hide memory gaps;
- surface contradictions, unclear wording, broken references, and missing durable information as findings.

The requesting/coordinating agent should know the expected answers or otherwise have a reliable comparison basis and evaluate the result after the run.

Findings discovered during the test should be treated as ordinary project-memory defects to fix or explicitly leave open.

### Modification to the pilot proposal

Do not require one specific product mechanism such as a child session. Any genuinely independent fresh agent/session is acceptable.

Do not standardize a fixed number of questions such as 13; use a representative set appropriate to the project's complexity and current risks.

Do not require every validation to create a dedicated report file. A durable report is useful when the validation is substantial, diagnostic, or needs later auditability, but a lightweight recorded result may be sufficient for smaller checks.

Re-run independent validation after **substantial memory restructuring or migration**, not after every ordinary project-memory edit.

When an independent run is unavailable or disproportionate, the existing `checklist/simulated-fresh` method remains valid, provided it is reported honestly and exercises the real startup path.

### Relationship to Project Infrastructure 0.8.10

This finding extends the existing COMMON §15 model rather than replacing it. The existing distinction between `independent-agent`, `checklist/simulated-fresh`, `partial`, and `not run` remains useful.

F-35 adds a practical protocol for the strongest `independent-agent` form of validation.

### Rationale

The pilot demonstrated that an independent fresh agent can reveal defects that are difficult for the authoring coordinator to notice: the agent tested actual discoverability, found settled answers without chat history, and exposed contradictions between memory and working documents. This makes fresh-agent validation a practical acceptance test for whether project memory truly supports continuity.

---

## F-36 — Upgrade стандарта с учётом фактически сложившихся правил проекта

**Decision:** ACCEPT WITH MODIFICATION

### Accepted

A Project Infrastructure upgrade is a **review and adaptation process, not a template reapplication**.

Before proposing changes, the agent must first inspect the project's actual current runtime and memory structure, including relevant files such as:

- `AGENTS.md`;
- infrastructure metadata / manifest;
- project-memory files;
- support/runtime guidance that materially affects ordinary work.

Existing project-specific rules, ordering, workflows, and conventions must be treated as potentially intentional and valuable, even when they are not formally recorded as a local deviation.

The agent must also inspect the new standard/version and determine which changes are actually useful for this project.

### Upgrade proposal before modification

Do not make the upgrade by mechanically replacing or regenerating managed files.

Instead, prepare an explicit upgrade proposal that distinguishes:

- what should be added from the new standard;
- what should be changed;
- what should remain as-is;
- where the new standard conflicts with or overlaps existing project practice;
- which existing project-specific rules should intentionally be preserved.

Present that proposal to the user / project owner and obtain approval **before modifying project runtime or project-memory files**.

Only the approved subset should then be applied.

### Current project state is authoritative input

Recorded local deviations in `MANIFEST.md` or equivalent infrastructure metadata are useful inputs, but they are not the only source of truth.

The actual current project may contain intentional rules or workflows that evolved after installation and were never formally classified as deviations. Upgrade review must therefore inspect the real project state rather than relying only on the manifest.

### Reconciliation principle

The target of an upgrade is not “make the project match the newest template”.

The target is:

> current project practice + useful improvements from the new standard + explicit user approval → reconciled project runtime

If the new standard and current project practice conflict and the correct choice is not obvious, preserve the current behavior until the user decides.

A mandatory universal three-way merge protocol is not required. Git history, installed-standard snapshots, manifests, diffs, and other evidence may be used when they help reconstruct intent.

### After approval and application

After the approved upgrade is applied:

- update infrastructure metadata to identify the installed standard/version;
- preserve or document intentional project-specific behavior where doing so will help future upgrades;
- verify that the resulting runtime still reflects the approved project-specific workflow rather than merely the upstream template.

### Rationale

Project Infrastructure evolves together with real projects. A project may develop better local rules, different ordering, or deliberate exceptions after the original installation. Treating an upgrade as mechanical template replacement risks destroying that accumulated design. A review-first, user-approved adaptation preserves project intent while still allowing useful improvements from the evolving standard to propagate.


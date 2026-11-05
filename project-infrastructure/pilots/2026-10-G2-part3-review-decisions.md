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


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

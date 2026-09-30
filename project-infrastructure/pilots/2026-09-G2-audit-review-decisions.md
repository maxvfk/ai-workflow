# Review decisions: G2 pilot audit 2026-09

Status: temporary working file for review of `2026-09-G2-SP-LAB-GRANT.md`.
Branch: `claude/g2-pilot-report-sp-lab-grant`.
Purpose: record decisions on F-01…F-16 before applying accepted changes to the standard in thematic batches.

This file is not part of the standard and does not itself change Project Infrastructure behavior.
After the audit is fully reviewed, its accepted decisions should be implemented in the standard and this file may be archived, condensed, or removed.

## Decision statuses

- `ACCEPT` — accept the finding and implement the agreed change.
- `MODIFY` — accept the underlying issue, but implement a different solution.
- `ALREADY ADDRESSED` — the issue is already sufficiently covered by later work.
- `REJECT` — do not change the standard for this finding.
- `NEEDS MORE EVIDENCE` — keep under observation before standardizing.

---

## F-01 — Control-plane-only / cloud-agent mode

Status: **ACCEPT**

### Decision

Add an optional capability-based control-plane-only mode to G2 for agents that can access the canonical GitHub control plane but cannot access the canonical artifact root.

Do not create a new G2 scenario or project type. This is a session/access mode within an ordinary G2 project.

The implementation already piloted in `SP-LAB-GRANT` is the preferred baseline.

### Default behavior

When the mode is enabled for a project, its canonical `AGENTS.md` must contain the operational rules for such agents.

Default permissions:

- project memory and other available control-plane context: read;
- approved snapshots, when configured: read-only;
- existing project-memory/control files: do not modify;
- handoff: create one new report per task under `_ai/inbox/`;
- artifact-root content not actually seen by the agent must not be treated as verified.

A full-access G2 agent later reconciles the report, updates canonical project memory as needed, and handles promotion/registration of artifacts.

### External incoming artifact area

A writable external incoming area is **optional**, not a required part of G2 or of control-plane-only mode.

It is configured only when the user wants cloud/control-only agents to create artifacts that cannot or should not live in the GitHub control repository.

The standard must be provider-neutral. Google Drive is one valid implementation, not a requirement.

If configured:

- its exact locator/configuration is recorded in the project's canonical `AGENTS.md`;
- files created there are noncanonical until reconciliation/promotion;
- the full G2 agent understands how to process them during reconciliation;
- destructive cleanup of the external incoming area is not automatic unless the project explicitly defines otherwise.

If no incoming area is configured, the mode can still be enabled for analysis and GitHub-side handoff, but the cloud agent must not invent another writable artifact store.

### Installation / enablement

Ordinary G2 bootstrap must **not** automatically create an external Drive folder or other third-party storage.

The full G2 agent should know from the standard that this optional mode exists and should enable/configure it when the user asks to use cloud/control-only agents for the project.

Enabling the mode may involve:

- adding the cloud/control-only section to canonical `AGENTS.md`;
- creating/configuring `_ai/inbox/` and its report template;
- optionally configuring an external incoming artifact area at the user's request;
- optionally installing snapshots and thin product adapters, subject to the decisions for F-02 and F-13.

### Rationale

The strict read-only project-memory policy from the `SP-LAB-GRANT` pilot is preferred as the default because a control-only agent cannot verify the second canonical G2 plane. Proposed state changes should flow through the inbox report and be reconciled by an agent with full access.

Explicit user-directed exceptional edits to control-plane files remain possible, but are not the default behavior of this fallback mode.

### Implementation batching

Implement together with the related cloud/control-only findings, especially F-02, F-13 and F-15, rather than patching the standard immediately after F-01 alone.


---

## F-02 — Snapshots for agents without artifact-root access

Status: **ACCEPT**

### Decision

Add an optional `_ai/snapshots/` mechanism to G2 for bounded read-only representations of selected canonical artifact-root text documents, primarily for control-plane-only/cloud-agent sessions.

Snapshots are derived context, not a second canonical artifact store and not a mirror of the artifact root.

### Snapshot requirements

Each snapshot should clearly record at least:

- read-only / derived status;
- canonical source path relative to the artifact root;
- capture date;
- full source fingerprint (SHA-256) for the original at capture time;
- explicit statement that the canonical original remains in the artifact root.

Optional metadata may include source record ID and source revision.

### Behavior

Control-plane-only agents:

- may read snapshots;
- must not edit them;
- must not present a snapshot as the current original;
- must account for snapshot age/provenance in conclusions.

Full G2 agents:

- create snapshots only from the actual canonical original;
- may compare the recorded source fingerprint during reconciliation;
- replace stale snapshots as a whole rather than editing them as independent documents;
- keep snapshot selection deliberate and bounded rather than mirroring the artifact root.

Snapshots are not registered as independent sources in `SOURCES.md` when the canonical original is already the source of record.

### Index

If snapshots are enabled, `_ai/snapshots/README.md` should act as the index and explain the rules.

A derived project-parameter summary inside that README is optional. If present, it is also derived context and may be stale; source snapshots outrank the summary, and canonical originals outrank snapshots.

The index does not need a second authoritative abbreviated hash representation; the full fingerprint in snapshot metadata is sufficient.

### Relationship to F-01

Snapshots are optional. Enabling control-plane-only mode does not automatically create snapshots or copy artifact-root documents.

The full G2 agent may recommend adding/removing snapshots when repeated cloud-agent work would benefit, but snapshot composition should remain deliberate and bounded.

### Implementation batching

Implement with the F-01 cloud/control-only package rather than as an independent scenario or mandatory G2 component.


---

## F-03 — Verified redundant/stale copies

Status: **MODIFY**

### Decision

Accept the underlying issue, but do not standardize a sync-provider-specific concept such as “provable synchronizer duplicate”.

Instead, add a general G2 rule for **verified redundant/stale copies**: a suspicious additional file does not need to block work when exact-content comparison proves that it contains no new competing state.

### Classification criteria

A suspicious additional copy may be treated as redundant/stale only when all of the following are true:

1. the canonical target is unambiguously identified;
2. the current canonical target has been checked and remains intact;
3. the suspicious copy is proven by exact-content comparison (e.g. SHA-256 or direct byte comparison) to be identical either to:
   - the verified current canonical artifact, or
   - a specific known prior/archive revision;
4. the comparison was actually performed; matching name, size, timestamp, revision suffix, or visual similarity alone is insufficient;
5. there is no evidence that the copy contains independent user work or otherwise represents a distinct state.

Two useful cases:

- **exact duplicate of current** — content-identical to the current canonical artifact;
- **proven stale copy** — content-identical to a known prior/archive revision while the current canonical artifact remains intact.

### Behavior

When the above criteria are satisfied:

- the copy is not treated as an unresolved competing version;
- work on the verified canonical target may continue;
- the duplicate/stale copy may be recorded or reported when material;
- the agent must not automatically delete it merely because redundancy was proven.

Cleanup/deletion requires explicit authority because deletion in a synchronized filesystem may propagate to other machines.

### Unresolved competing state

If the suspicious copy is not content-identical to a verified current or known prior state, or the canonical target itself is uncertain/damaged, the existing conservative G2 rule remains unchanged:

- do not choose a winner silently;
- do not overwrite or delete competing copies;
- reconcile or ask the user.

### Migration hygiene

Do not make “check every other machine” a mandatory G2 rule.

Add only a short migration recommendation: after moving an existing synchronized tree, account for the possibility that another device may later publish an older location/state; when practical, verify that other relevant devices have synchronized or no longer publish the old state.

### Implementation batching

Implement in the G2 synchronization/conflict-handling package together with related operational findings rather than as a standalone version bump.


---

## F-04 — Registry registration/update request

Status: **MODIFY**

### Decision

Accept the underlying issue, but do **not** allow child projects to directly modify the registry-owned `PROJECTS/PROJECTS.md`.

Preserve the existing ownership boundary:

- child project owns and is authoritative for its own runtime/manifest/project metadata;
- `PROJECTS-REGISTRY` owns the workspace catalog `PROJECTS.md`;
- child projects do not receive a special bootstrap exception for writing another project's canonical artifact.

### Handoff mechanism

When a project in a workspace with a configured Project Registry is created, adopted, migrated, renamed/moved, archived, or otherwise changes registry-relevant metadata, its full/bootstrap agent may create a **GitHub Issue in the registry control repository** as a registration/update request.

For the current reference implementation:

`maxvfk/projects-registry`

The issue is a handoff/trigger, not authoritative registry state.

Suggested minimal fields:

- requested operation: add / update / move-or-rename / scenario migration / archive;
- Project ID;
- human-readable project name;
- GitHub repository when applicable;
- scenario/profile;
- local path hint when known;
- short reason/context when useful.

### Registry processing

The registry agent must not blindly copy issue fields into `PROJECTS.md`.

When processing a request it should:

1. read the authoritative child runtime/manifest/project metadata needed to verify identity;
2. re-read the current `PROJECTS.md`;
3. verify Project ID, repository, scenario and other relevant metadata;
4. verify the local path against the connected workspace when available;
5. add/update the registry entry only after verification;
6. update any registry-owned derived routing metadata when applicable;
7. close the request with a concise result or leave it open when required verification is unavailable.

If the local workspace is unavailable, the request may remain pending rather than inventing/assuming a verified local path.

### Bootstrap behavior

When the active workspace is known to use a configured Project Registry, project bootstrap should check whether registry registration is already satisfied.

If not, and the registry repository is known and writable, creating the issue is an appropriate completion handoff and does not require direct catalog modification.

If the request cannot be created, bootstrap remains valid; report registry registration as pending.

Do not guess a registry repository when it is not explicitly configured/discoverable.

### Rationale

This preserves:

- one canonical writer/owner for `PROJECTS.md`;
- child-project authority over its own identity;
- no cross-project direct writes;
- optimistic/concurrent safety around the shared catalog;
- a lightweight, auditable lifecycle for pending registry work.

The issue mechanism also generalizes beyond initial registration to later rename/move/migration/archive events.

### Related registry-derived metadata

Child projects should not directly edit registry-owned routing files such as `CLOUD_PROJECTS.md`.

When relevant, the registry agent updates those derived/maintained representations as part of processing the verified request.


---

## F-13 — Workspace-level cloud routing/adapters

Status: **NEEDS MORE EVIDENCE / locally addressed**

### Decision

The architectural gap is real: a cloud/workspace-level agent may need a GitHub-visible routing entry point before it can determine which child project runtime to enter, while the local `PROJECTS.md` registry artifact is unavailable to that agent.

However, do not generalize this into a mandatory Project Infrastructure feature yet.

The current workspace need is already handled locally by:

`maxvfk/projects-registry/CLOUD_PROJECTS.md`

which acts as a thin routing index from workspace-level cloud agents to the selected child repository and its canonical `AGENTS.md`.

### Current policy

- keep and use `CLOUD_PROJECTS.md` in the registry control repository;
- treat `projects-registry` as its natural owner;
- do not put a parent runtime or adapter into the local `PROJECTS/` root;
- do not move workspace-level routing into an arbitrary child project;
- do not standardize a general workspace-adapter hierarchy until another real use case appears.

Package A may contain only a light allowance that thin product/workspace adapters are permitted when useful, without defining a required structure or lifecycle.

### Rationale

This follows the standard's preference for codifying repeated real patterns rather than designing infrastructure in advance.

Revisit F-13 if a second distinct workspace-level adapter/routing need appears.

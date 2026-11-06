# Review decisions — G2 pilot part 2

Date started: 2026-11-06  
Source review: `maxvfk/SP-Lab-Grant/_ai/research/infrastructure-pilot-findings-part2.md`  
Scope: F-17…F-24  
Status: in progress (F-17 agreed; F-18…F-24 pending)

This is the separate record of project-owner review decisions. The original pilot report remains unchanged as evidence. Decisions are recorded here as they are agreed; changes to the Project Infrastructure source standard are a separate later implementation step.

## F-17 — Совместное редактирование бинарных артефактов человеком и агентом

**Decision:** ACCEPT WITH MODIFICATION  
**Agreed:** 2026-11-06  
**Implementation:** pending (to be included in a later scoped standard change; no runtime upgrade authorized by this decision)

### Accepted

1. **Canonical relationship may evolve.** Determine whether the authoritative source is the generator/script, the editable artifact, or another documented source; do not infer that a script stays authoritative forever merely because it created the first version. When a user starts manually modifying an artifact, reassess the relationship. Do not run a destructive full regeneration over manual changes unless preservation of those changes is ensured or the user has explicitly agreed on how to proceed. The first manual edit does **not** automatically turn a generator into historical-only material.
2. **Coordinate non-trivial shared editing with the user.** Treat the workflow like collaboration between people: surface ambiguity about source of truth, ownership of current work, or destructive changes, and agree on the approach when necessary. No rigid universal protocol can describe all CAD/application states. Routine safe local edits should remain autonomous.
3. **Protect active/unsaved user work.** An agent must not silently close, discard, save over, replace, or otherwise jeopardize documents or application sessions with user work in progress. Before potentially conflicting automated actions, check available application/file state; where safety cannot be established and a real risk remains, defer or ask. Do not demand user confirmation for every harmless operation.
4. **Preserve dependencies and identities.** For CAD assemblies and other linked/project formats, account for internal object IDs, external references, component relationships and dependent artifacts. Prefer in-place editing when it is demonstrably safer than replacing an artifact, without imposing a blanket ban on new versions or replacement files.
5. **Proportionate recovery and verification.** Before potentially destructive work, ensure an appropriate path to recover the prior state. After modifying complex artifacts, verify material properties/invariants using suitable tools. Concrete SolidWorks checks (geometry, dimensions, assembly references, interference checks, etc.) remain project-local rather than universal infrastructure mandates.

### Scope and deliberate simplifications

- The general shared-editing, canonical-source transition, unsaved-work, and dependency-preservation principles belong in `COMMON.md`; only genuine synchronization-specific additions, if needed, belong in G2.
- Keep SolidWorks COM/API specifics, in-place feature operations, and tool-specific validation in the project-local runtime/support documentation.
- Do **not** add mandatory file locks, a universal manual turn-taking/ownership handshake before each operation, an automatic change report after every user edit, or a snapshot before every save.
- Existing G2 sync-sanity, conflict, direct-edit, and publish/reconciliation rules continue to apply; this finding should not duplicate or replace them.
- Detailed snapshot naming, retention, and archival strategy are reserved for **F-18**. F-17 requires only a recovery approach proportionate to the operation's risk.
- This decision is a review outcome, not authorization to rewrite installed project runtimes or migrate existing projects.

### Rationale

In the SP-Lab-Grant pilot, the original SolidWorks generation scripts could overwrite subsequent user edits, automation interacted with the same open application session as the user, and replacing component files could break assembly dependencies. These are real generalizable hazards, but a detailed universal CAD-style coordination procedure would be burdensome and brittle. Instead use explicit collaboration and risk-proportionate safeguards where the situation is ambiguous, preserving agent autonomy for low-risk actions.

### Evidence

- `maxvfk/SP-Lab-Grant/_ai/research/infrastructure-pilot-findings-part2.md` — F-17, P1.
- `maxvfk/SP-Lab-Grant` — D-007 and project-specific SolidWorks workflow.
- Existing standard: `project-infrastructure/COMMON.md` (canonical sources and derived artifacts, external edits, concurrent writes); `project-infrastructure/G2_GITHUB_SYNCED_LOCAL_FOLDER.md` (§§ 13–19).

---

## Review queue

F-18…F-24 remain pending, without implied acceptance, rejection, or implementation. Next: **F-18 — Binary artifact snapshots/versioning and retention**.

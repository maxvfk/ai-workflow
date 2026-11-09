# Review decisions — G2 pilot part 2

Date started: 2026-11-06  
Source review: `maxvfk/SP-Lab-Grant/_ai/research/infrastructure-pilot-findings-part2.md`  
Scope: F-17…F-24  
Status: in progress (F-17 and F-18 agreed; F-19…F-24 pending)

This is the separate record of project-owner review decisions. The original pilot report remains unchanged as evidence. Decisions are recorded here as they are agreed; each finding's implementation status distinguishes source-standard changes from installed project-runtime upgrades.

## F-17 — Совместное редактирование бинарных артефактов человеком и агентом

**Decision:** ACCEPT WITH MODIFICATION  
**Agreed:** 2026-11-06  
**Implementation:** included in source-standard `COMMON.md` and G2 scenario through PR #25 (installed project runtimes remain unchanged)

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

## F-18 — Версионирование и хранение точек восстановления бинарных артефактов

**Decision:** ACCEPT WITH MODIFICATION  
**Agreed:** 2026-11-09  
**Implementation:** included in source-standard `COMMON.md` and G2 scenario through PR #25 (no automatic installed-runtime upgrade)

### Accepted

1. **Risk-proportionate recovery, not mandatory per-edit snapshots.** Before a potentially destructive or hard-to-reverse change to important binary/linked artifacts, ensure a sufficiently reliable recovery method. Prefer an existing suitable application version history, backup or version-control mechanism where available. Create an explicit snapshot when no adequate recovery point otherwise exists. Routine bounded/reversible edits do not require a fresh snapshot each time.
2. **Autonomous safe snapshot creation.** An agent may create an ordinary, safe, authorized recovery snapshot as a preparatory measure **without asking the user for approval each time**. Creation must still respect existing permissions, scope, protected data, storage/security boundaries and application state. If a backup method itself requires an unapproved environment or access change, obtain approval for that boundary change.
3. **Coherent restoration set.** Include the minimum sufficient dependent files, drawings, linked parts and other materials necessary to restore the affected artifact set coherently. Validate or document practical recovery constraints; a copied CAD assembly may retain absolute references to the live project and must not be assumed safe to open or edit in isolation.
4. **Location and identity.** Store recovery points in a suitable project-defined location (adjacent archive, separate backup area, application-native version store, etc.), not necessarily inside the synchronized artifact root. Prefer identifiable date/time plus purpose naming where applicable. An archived copy is **not another canonical working artifact**. Avoid inadvertent competing copies or editing live files through archive references.
5. **Discoverability.** Record the location/identifier and recovery conditions for **meaningful** snapshots where a later agent or user would otherwise struggle to find or restore them (e.g., in a relevant task or support file). No universal registry entry for every incidental backup is required.
6. **Adaptive retention.** Project policy may preserve a bounded rolling history plus significant milestones, but do not impose a universal fixed `N`, storage location or expiry period. Review accumulation proportionately. Do not automatically delete user-owned recovery snapshots merely because they are old or exceed a count; destructive cleanup requires appropriate authorization and care with synchronized deletion propagation.

### Scope and constraints

- A snapshot may provide rollback for a mistaken edit without being a complete disaster-recovery backup. A copy on the same drive does not by itself protect against physical drive failure.
- Keep **binary artifact recovery snapshots** in the artifact/backup domain distinct from G2 control-only text/context `_ai/snapshots/`, historical project-state `_ai/archive/state/`, and installed-standard snapshots. Do not treat them as interchangeable or canonical mirrors.
- The general recovery/risk rule can extend `COMMON.md`; add only synchronization-specific implications to G2 where useful. Actual CAD backup/restore commands, relative/absolute reference handling, and local retention policy belong to project-specific procedures.
- No mandatory scheduled snapshots, snapshots after every save, universal archive format, per-file live checksums, required Git inclusion, or blanket requirement to confirm each safe snapshot with the user.
- Do not conflate safe snapshot **creation** with potentially destructive archive **deletion**.
- Review outcome only: source standard implementation and installed-runtime upgrades remain separate tasks.

### Rationale

The SP-Lab-Grant G2 pilot accumulated seven ~50-file model snapshots within a week. They made rollback possible but consumed synchronized storage and contained SolidWorks references that could point back to live model components. The standard needs an explicit recovery strategy while leaving risk, project tooling, storage cost and retention to the particular project. User-approved autonomy for safe backup creation avoids unnecessary interruptions; archive deletion and sensitive boundary changes remain controlled.

### Evidence

- `maxvfk/SP-Lab-Grant/_ai/research/infrastructure-pilot-findings-part2.md` — F-18, P2.
- Existing G2 scenario: §§ 13–14 (sync-sanity/conflicts), §17 (direct edit versus temporary copy), §19 (binary artifact versioning is separate from GitHub history).
- F-17 review decision in this file: proportional recovery and protection of shared work.

---

## Review queue

F-19…F-24 remain pending, without implied acceptance, rejection, or implementation. Next: **F-19 — Retiring artifacts: deletion versus archival**.

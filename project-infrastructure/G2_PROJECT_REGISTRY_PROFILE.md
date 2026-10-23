# G2 Profile — Project Registry

**Status:** Draft  
**Extends:** [G2 — GitHub + Synced Local Folder](G2_GITHUB_SYNCED_LOCAL_FOLDER.md)  
**Depends on:** [COMMON.md](COMMON.md)  
**Standard version:** inherit from [../PROJECT_INFRASTRUCTURE.md](../PROJECT_INFRASTRUCTURE.md)

Use this profile for a small personal multi-project workspace where one dedicated GitHub repository maintains the workspace catalog `PROJECTS/PROJECTS.md`.

Recommended control repository:

```text
maxvfk/projects-registry
```

Recommended stable registry Project ID:

```text
PROJECTS-REGISTRY
```

This is a **G2 profile**, not a new scenario.

## 1. Purpose

The registry project maintains a lightweight catalog/resolver for the user's projects without turning the whole `PROJECTS/` tree into one project.

Its responsibilities are intentionally narrow:

- maintain `PROJECTS/PROJECTS.md`;
- add/update catalog entries when projects are created, moved, renamed, archived, or migrated between infrastructure scenarios;
- periodically reconcile the catalog against the projects actually visible under `PROJECTS/`;
- use each child project's own runtime/manifest/project memory as authoritative evidence;
- preserve project boundaries and avoid modifying child projects during registry maintenance;
- receive and verify child-project registration/update requests through the configured registry handoff mechanism when one is installed.

The registry is not a portfolio-management system, dependency database, or parent runtime for all projects.

## 2. Canonical stores

### GitHub control/state plane

The dedicated registry repository is canonical for:

- `AGENTS.md`;
- `PROJECT.md`;
- `STATE.md`;
- `TASKS.md`;
- `SOURCES.md` when useful;
- infrastructure manifest/snapshot;
- maintenance decisions/plans when they are actually needed.

### Local artifact plane

The registry project's only normal canonical local artifact is:

```text
PROJECTS/PROJECTS.md
```

The other folders/files below `PROJECTS/` belong to their own projects or are ordinary workspace content. They are **external sources** to the registry project, not registry-owned artifacts.

## 3. Critical G2 profile override: no parent AGENTS.md

Do **not** create a registry `AGENTS.md`, `CLAUDE.md`, `STATE.md`, `TASKS.md`, `_ai/`, or other registry-runtime files in the local `PROJECTS/` root.

Reason: `PROJECTS/` contains independent projects whose tools may discover or inherit parent instruction files. A parent registry runtime could accidentally affect child-project behavior.

For this profile:

- the canonical full runtime exists only in the GitHub control repository;
- the local registry artifact `PROJECTS.md` is the workspace entry/resolver artifact, not an agent instruction file;
- launch/configure the registry agent with access to both the control repository and the local/synchronized `PROJECTS/` workspace;
- ordinary child projects retain their own independent `AGENTS.md` and scenario runtime.

This rule intentionally overrides the normal G2 expectation of a local bootstrap `AGENTS.md` in the artifact root.

Because this profile deliberately has no local parent bootstrap, the ordinary G2 artifact-only fallback does **not** define a standalone registry-maintenance mode. If the registry GitHub control/runtime is unavailable, do not perform autonomous registry reconciliation from `PROJECTS.md` alone. A user may still manually edit `PROJECTS.md`, after which the registry project can reconcile it when full access is restored.

## 4. PROJECTS.md contract

`PROJECTS.md` is a maintained convenience catalog and resolver. It is **not canonical project state** for any child project.

Recommended fields:

| Field | Meaning |
|---|---|
| Project ID | Stable cross-project identifier |
| Project | Human-readable name |
| Group | Organizational folder/group such as `Tokamak` |
| Local path | Path relative to `PROJECTS/` |
| Scenario | Installed scenario observed from project runtime/manifest |
| GitHub | Dedicated project repository when applicable |
| Lifecycle | Lightweight catalog state such as `active` or `completed` |

Keep the file compact. Do not copy child `STATE.md`, task lists, assumptions, detailed dependencies, or project history into the catalog.

When `PROJECTS.md` disagrees with the child project's own runtime/manifest/project memory, the **child project wins** and the registry should be repaired.

A useful header is:

```markdown
# Projects

Registry Project ID: PROJECTS-REGISTRY
Control repository: maxvfk/projects-registry
```

## 5. Registry maintenance operations

### Add a project

When the user creates or adopts a project:

1. identify the project folder;
2. inspect only the project entry/runtime/manifest files needed to establish its Project ID, name, scenario, repository, and lifecycle;
3. preserve an existing stable Project ID;
4. if no Project ID exists, do not silently rewrite the child project solely for registry convenience; use a user-established ID when available, otherwise surface the missing ID as registry follow-up;
5. add/update one catalog row;
6. verify the path resolves from the `PROJECTS/` root.

### Update after migration, rename, or move

When a project changes scenario, repository, path, or lifecycle:

1. read the current child runtime/manifest first;
2. update only the affected catalog fields;
3. do not duplicate migration details into `PROJECTS.md`;
4. verify the updated resolver entry.

### Periodic reconciliation

On requests such as “проверь все проекты”, “обнови реестр”, or equivalent:

1. inventory `PROJECTS/` and its organizational folders using bounded discovery;
2. identify likely project roots from explicit project markers/runtime/manifest files;
3. compare observed projects with `PROJECTS.md`;
4. detect missing entries, stale paths, changed scenarios/repositories/lifecycle, duplicate Project IDs, and catalog entries whose target can no longer be resolved;
5. inspect deeper only where needed to resolve a concrete discrepancy;
6. update clear discrepancies;
7. preserve unresolved ambiguity instead of guessing;
8. report anything requiring user/project-level action separately.

Do not recursively ingest CAD trees, reports, datasets, archives, dependency folders, or other child artifacts merely to reconcile the registry.

## 6. Registration/update requests from child projects

A child project does **not** directly edit the registry-owned `PROJECTS.md` merely because it is being created, adopted, migrated, moved/renamed, archived, or has registry-relevant metadata changes.

When the workspace is known to use this Project Registry profile and the registry control repository is explicitly configured and writable, the child project's full/bootstrap agent may create a **GitHub Issue in the registry control repository** as a registration/update request.

The reference implementation uses:

`maxvfk/projects-registry`

The issue is a handoff/trigger, not authoritative registry state.

Suggested request fields:

- operation: add / update / move-or-rename / scenario migration / archive;
- Project ID;
- human-readable project name;
- GitHub repository when applicable;
- scenario/profile;
- local path hint when known;
- concise reason/context when useful.

Do not guess the registry repository when it is not explicitly configured/discoverable. If a request cannot be created, project bootstrap remains valid; report registry registration/update as pending.

### Processing a request

The registry agent must not blindly copy issue fields into `PROJECTS.md`.

For each request:

1. read the authoritative child runtime/manifest/project metadata needed to verify identity;
2. re-read the current `PROJECTS.md`;
3. verify Project ID, repository, scenario/profile, lifecycle, and other relevant metadata;
4. verify the local path against the connected workspace when available;
5. add/update the catalog only after verification;
6. update registry-owned derived routing metadata when applicable;
7. close the issue with a concise result, or leave it open when required verification is unavailable.

If the local workspace is unavailable, leave path-dependent registration pending rather than inventing a verified local path.

Child projects also do not directly edit registry-owned derived routing files such as a cloud routing index; the registry agent updates those representations after verifying the request.

## 7. Child-project access policy

Registry maintenance is read-only toward child projects by default.

The registry agent may read child:

- `AGENTS.md`;
- infrastructure manifest;
- `PROJECT.md`;
- `STATE.md` only when lightweight lifecycle/status resolution actually requires it;
- other project-memory files only when needed to resolve a catalog discrepancy.

The registry agent must **not** modify child:

- project memory;
- artifacts;
- repositories;
- source registrations;
- IDs;
- folder structure;

unless the user's task explicitly includes that child project as a separate modification target.

Visibility of the whole `PROJECTS/` tree does not grant cross-project write authority.

## 8. Cross-project relationships

Do not maintain a central dependency graph in `PROJECTS.md`.

Follow `COMMON.md`:

- a consuming project records meaningful project-level relationships in its own `PROJECT.md`;
- concrete consumed artifacts from another project are recorded in the consumer's `SOURCES.md`;
- durable references use `Project ID + source-relative path`.

The registry only resolves Project IDs to current project locations/repositories.

## 9. Registry project memory

The registry project's own state should remain small.

`STATE.md` may track:

- whether the catalog is currently reconciled;
- date/scope of the last maintenance pass;
- unresolved catalog ambiguities;
- current registry-format decisions.

`TASKS.md` may track:

- missing Project IDs;
- unresolved duplicate IDs;
- missing/unreachable project folders;
- requested migrations or catalog repairs that require project-level action.

Do not mirror ordinary child-project tasks into registry `TASKS.md`.

## 10. Sources

If `SOURCES.md` is installed, register at minimum the catalog artifact:

```markdown
## S-001 — Project workspace catalog
Storage: G2 registry artifact root
Path: PROJECTS.md
Canonical: yes
Modification: editable
Purpose: Maintained project catalog and Project-ID/location resolver
```

Child projects themselves normally do not need one source entry each; `PROJECTS.md` is the compact resolver.

## 11. Runtime requirements

The canonical GitHub `AGENTS.md` for the registry must make these rules discoverable:

- Profile: G2 / Project Registry;
- Project ID: `PROJECTS-REGISTRY`;
- canonical control repository identity;
- local workspace root is the connected/synchronized folder containing `PROJECTS.md`;
- only `PROJECTS.md` is registry-owned in the local workspace by default;
- no registry `AGENTS.md` or other runtime files are created at `PROJECTS/`;
- child projects are authoritative for their own metadata and read-only by default;
- maintenance uses bounded discovery and does not recursively scan child artifacts;
- `PROJECTS.md` is repaired from child project evidence when stale;
- unresolved identity/path ambiguity is surfaced rather than guessed;
- configured child registration/update requests are treated as handoff evidence to verify, not as authoritative catalog state.

## 12. Bootstrap

Follow `COMMON.md` and base G2 rules except where this profile explicitly overrides the local-bootstrap model.

Bootstrap steps:

1. create/select the dedicated private GitHub control repository;
2. use Project ID `PROJECTS-REGISTRY`;
3. connect the existing local/synchronized `PROJECTS/` workspace;
4. verify or create only `PROJECTS/PROJECTS.md` on the local artifact plane;
5. **do not** create local parent instruction/runtime files;
6. initialize GitHub runtime/project memory/manifest/snapshot;
7. perform bounded discovery of current child projects;
8. populate/reconcile `PROJECTS.md`;
9. when the registry control repository supports child registration/update issues, materialize that handoff rule in the registry runtime so child/bootstrap workflows can use it without direct catalog writes;
10. cold-start validate from GitHub runtime + connected `PROJECTS/` workspace.

## 13. Cold-start validation

A fresh registry agent must be able to determine:

- that its active project is `PROJECTS-REGISTRY`, not any child project;
- that GitHub is canonical for registry control/state;
- which connected folder is the `PROJECTS/` workspace;
- that `PROJECTS.md` is the local canonical registry artifact;
- how to resolve a Project ID from the catalog;
- that child projects are authoritative and read-only by default;
- how to run bounded catalog reconciliation without traversing all child artifacts.

## 14. Completion reporting

After registry maintenance, report only material outcomes:

- entries added/updated/removed;
- unresolved Project-ID/path/repository ambiguities;
- projects discovered but not yet registered;
- stale catalog entries that could not be reconciled safely;
- whether `PROJECTS.md` was verified after writing;
- registration/update requests processed, left pending, or blocked by missing verification.

Do not report unchanged child projects one by one unless the user asks for a full audit table.

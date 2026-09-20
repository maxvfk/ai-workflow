# Scenario G0 — GitHub Repository

**Status:** Draft  
**Depends on:** [COMMON.md](COMMON.md)  
**Standard version:** inherit from [../PROJECT_INFRASTRUCTURE.md](../PROJECT_INFRASTRUCTURE.md)

Use this scenario when one GitHub repository is the canonical home of both:

- project runtime/project memory; and
- the project's ordinary Git-suitable text/code/config/documentation artifacts.

Local clones/checkouts and agent workspaces are access/execution paths, not additional canonical stores.

## 1. Core model

```text
                 G0 project
                     │
              GitHub repository
           canonical project store
                     │
       ┌─────────────┴─────────────┐
       │                           │
 remote API/connector         local checkout
  addressed operations       code/diff/build/test
       │                           │
       └─────────────┬─────────────┘
                     │
              publish to GitHub
```

The repository is the single canonical store for project memory and ordinary repository artifacts.

Do not create a second canonical project-state copy merely because an agent has a local clone.

## 2. Use G0 when

G0 is appropriate when:

- the project is naturally Git-first;
- normal durable artifacts are suitable for Git;
- no separate Google Drive/artifact service or synchronized non-Git artifact root is required for ordinary operation;
- local clones may come and go without changing canonical identity.

If a project later acquires a substantial non-Git artifact plane, reassess against G1 or G2 instead of stretching G0.

## 3. Canonical repository structure

Typical structure:

```text
repo/
├── AGENTS.md
├── CLAUDE.md            # temporary pre-pilot compatibility adapter
├── PROJECT.md           # when justified
├── STATE.md
├── TASKS.md
├── ASSUMPTIONS.md       # when justified
├── SOURCES.md           # when provenance/source tracking matters
├── README.md
├── [project code/text/config/artifacts]
└── _ai/
    ├── infrastructure/
    │   ├── MANIFEST.md
    │   └── standard/
    │       ├── COMMON.md
    │       └── G0_GITHUB_REPOSITORY.md
    ├── plans/
    ├── decisions/
    ├── research/
    └── archive/
```

Create only files/directories with a real role.

Temporary work normally belongs in a harness/local workspace or an ignored `_ai/work/` area when that is the simplest safe option.

## 4. Repository access modes

Use the simplest safe mode for the task.

### Mode A — remote/API/connector

Prefer for:

- reading/updating project memory;
- small text/config/documentation changes;
- issue/task/reference operations;
- bounded edits where the current file SHA/revision can be verified.

Before a write:

1. read the current target/revision;
2. use SHA/revision/ETag-style conditional-write semantics when exposed;
3. if the target changed or the write is rejected, refresh and reconcile;
4. never force-overwrite stale repository content.

### Mode B — local checkout

Prefer when code, tests, build tools, many files, or Git-native diff/merge workflows materially help.

Rules:

- a clone/check-out is an execution/access path to the canonical repository;
- its machine-specific absolute path is not project state;
- fetch/update before substantial work according to repository policy;
- publish through the repository's existing branch/PR/direct-write policy;
- if push/merge is rejected, refresh and reconcile;
- do not force-push/destructively rewrite history unless explicitly requested and appropriate.

G0 does not invent a branching model. Preserve the repository's established contribution policy. If none exists, use the simplest safe path proportionate to the task.

## 5. Project-memory and source locators

Profile/language selection follows `COMMON.md`.

Use repository-relative paths for artifacts tracked in `SOURCES.md`.

Example:

```markdown
## S-001 — Infrastructure standard entry point
Storage: GitHub repository
Path: PROJECT_INFRASTRUCTURE.md
Canonical: yes
Modification: editable
```

Do not register every repository file. Apply the common source-registration criteria.

Commit/blob IDs may be recorded when provenance requires an immutable version, but ordinary mutable project files should normally be referenced by repository-relative path plus the active repository/branch policy rather than manually maintained hashes.

## 6. Infrastructure manifest

Create/update:

```text
_ai/infrastructure/MANIFEST.md
_ai/infrastructure/standard/COMMON.md
_ai/infrastructure/standard/G0_GITHUB_REPOSITORY.md
```

Recommended manifest:

```markdown
# Project infrastructure manifest

Scenario: G0
Project-memory profile: Minimal | Standard
Project-memory language: ru
Agent namespace: _ai/

GitHub repository: <owner/repo>
GitHub default branch: <branch>

Standard source: maxvfk/ai-workflow or local bootstrap bundle
Standard version: <installed version>
Standard lifecycle: <Draft/Pilot/Stable>
Standard commit/ref: <exact commit/ref when known>
Initialized: YYYY-MM-DD
Last infrastructure update: YYYY-MM-DD
Runtime entry point: ../../AGENTS.md
Local standard snapshot: ./standard/
```

Do not store credentials, local clone paths, or transient session/tool capability observations in the manifest.

## 7. Git and temporary-work rules

Preserve the repository's existing `.gitignore` and contribution conventions.

When needed, temporary agent paths may be ignored through a managed block, for example:

```gitignore
# project-infrastructure:start
_ai/work/
_ai/generated/
# project-infrastructure:end
```

Omit `_ai/generated/` when generated outputs are intentionally reviewed/versioned in Git.

Do not ignore durable `_ai/infrastructure/`, decision, plan, research, or archive records merely because they are agent-owned.

## 8. G0 runtime additions to canonical `AGENTS.md`

In addition to the common runtime baseline from `COMMON.md`, G0 must materialize:

- `Scenario: G0`;
- canonical GitHub repository identity/default branch and infrastructure-manifest path;
- the GitHub repository is the single canonical project store for runtime/state and ordinary tracked artifacts;
- local clones/checkouts/workspaces are access/execution paths, not separate canonical stores;
- remote/API and local-checkout modes are both valid; select proportionately to the task **after** grounding the canonical repository target;
- for repository artifacts/project memory, prefer an available identity-preserving GitHub operation rather than creating a workspace/local substitute; use checkout/workspace only when the task materially requires it;
- repository-relative paths are the default artifact locators;
- before shared writes, re-read/fetch current repository state and reconcile concurrent changes;
- preserve existing branch/PR/contribution policy;
- rejected writes/pushes must refresh/reconcile rather than force stale content;
- ordinary work does not require the external infrastructure-standard repository.

## 9. G0 bootstrap/reconcile additions

Follow the common bootstrap/reconcile flow from `COMMON.md`.

G0-specific additions:

- ground the one canonical GitHub repository;
- classify existing non-empty repositories as brownfield even when project memory is not yet installed;
- inspect repository root and relevant paths using the common bounded-discovery rules;
- create/update project memory and infrastructure **inside that repository**;
- keep artifact/source locators repository-relative when possible;
- respect existing Git history, branches, contribution rules, and repository structure;
- choose remote/API or local-checkout access based on the actual task;
- verify that installed runtime can continue from repository access alone, without the originating chat or external standard.

Already initialized G0 reconciles only what is needed. Greenfield starts Minimal unless known complexity justifies Standard.

## 10. G0 cold-start additions

Apply the common cold-start validation from `COMMON.md`.

A fresh G0 agent with repository access must additionally be able to determine:

- the exact canonical GitHub repository/default branch policy;
- that repository files, not an arbitrary local clone, define canonical state;
- which access mode is appropriate for the requested work;
- how to locate important artifacts using repository-relative paths;
- how concurrent/rejected GitHub writes are reconciled.

## 11. G0 completion-report additions

For G0 infrastructure work or substantial repository changes, add to the common handoff when relevant:

- canonical repository grounded;
- remote/API or local-checkout path used;
- branch/PR/direct-write route used;
- canonical repository write verification result;
- any rejected/conflicting write that remains unresolved.

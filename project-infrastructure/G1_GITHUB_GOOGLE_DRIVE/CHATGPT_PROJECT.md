# G1 Profile — ChatGPT Project

**Status:** Draft  
**Scenario:** G1 — GitHub + Google Drive  
**Depends on:** [`BASE.md`](BASE.md) and [`../COMMON.md`](../COMMON.md)  
**Standard version:** inherit from [`../../PROJECT_INFRASTRUCTURE.md`](../../PROJECT_INFRASTRUCTURE.md)

Use this profile when one logical project is intentionally organized as:

```text
1 ChatGPT Project
        ↕
1 GitHub repository
        +
1 Google Drive root folder
```

This profile does **not** create a third canonical store. The ChatGPT Project is the interaction/context shell. GitHub remains the G1 control/state plane and Google Drive remains the artifact plane.

## 1. Recommended topology

Default mapping:

- one ChatGPT Project;
- one dedicated GitHub repository;
- one dedicated Google Drive root folder.

The repository and Drive folder may already contain meaningful project material. Apply all G1 brownfield-first and preservation rules.

Do not duplicate project state into ChatGPT Project memory, chat history, or Drive merely for convenience.

## 2. ChatGPT Project role

The ChatGPT Project provides:

- a stable user-facing workspace for project chats;
- project-scoped instructions;
- project-scoped sources/connectors where available;
- continuity of interaction around the same canonical GitHub/Drive project.

It is **not** authoritative for current project state.

When chat history, remembered context, or Project Instructions conflict with current GitHub project-memory files, follow the installed runtime/project-memory unless the user explicitly changes the project.

## 3. Project Instructions are a product adapter

Project Instructions are a concise ChatGPT-specific bootstrap/runtime adapter. They must not become a second copy of `AGENTS.md`, `STATE.md`, `TASKS.md`, or `SOURCES.md`.

They should contain only durable information needed for a new project chat to enter the project correctly.

At minimum, Project Instructions should:

- identify the project;
- identify the canonical GitHub repository;
- identify the Google Drive root folder in a stable way when practical;
- instruct ChatGPT to read the repository `AGENTS.md` before substantial work;
- state that GitHub project-memory is authoritative over chat history;
- state that Drive holds canonical document/large-file artifacts;
- preserve the installed project-memory language;
- include only genuinely durable project-specific working rules/preferences;
- instruct the agent to check current-session capabilities before assuming writes are possible;
- point to the G1 completion/publish-back discipline through `AGENTS.md`.

Do **not** put volatile state into Project Instructions, including:

- active task lists;
- current status snapshots;
- latest conclusions likely to change;
- large source registries;
- copied Drive inventories;
- duplicate runtime rules already maintained in `AGENTS.md`.

## 4. Canonical copy of Project Instructions

The canonical text for the ChatGPT Project instructions must live in GitHub:

```text
_ai/infrastructure/chatgpt/PROJECT_INSTRUCTIONS.md
```

The text installed in ChatGPT Project settings is a deployed copy of this canonical file.

The repository copy exists so instructions can be reviewed, versioned, migrated, compared, and reconstructed without relying on the ChatGPT UI.

When updating Project Instructions:

1. re-read the canonical repository copy;
2. revise it deliberately;
3. update the ChatGPT Project settings to match;
4. verify the deployed instructions when practical;
5. record any unresolved mismatch as pending synchronization.

Do not silently edit only one side and assume the other matches.

## 5. Manifest additions

A G1 project using this profile should add to `_ai/infrastructure/MANIFEST.md`:

```markdown
Scenario: G1
Scenario profile: ChatGPT Project
Product adapter: ChatGPT Project
Project instructions canonical copy: _ai/infrastructure/chatgpt/PROJECT_INSTRUCTIONS.md
```

When a stable ChatGPT Project identifier is unavailable, do not invent one. A human-readable project name may be recorded as context.

Session-dependent ChatGPT connector/tool capabilities do not belong in the manifest.

## 6. Instruction-design step

Bootstrap must include **Instruction Design** after the project has been inspected and its canonical state reconstructed.

The bootstrap agent should derive Project Instructions from:

- project purpose and scope;
- canonical-store identities;
- installed `AGENTS.md` runtime;
- stable project-specific constraints;
- recurring domain/workflow rules;
- stable user preferences relevant inside this project.

The agent must distinguish:

1. **global/runtime infrastructure rules** → belong in `AGENTS.md`;
2. **current project state** → belongs in `STATE.md`, `TASKS.md`, `SOURCES.md`, etc.;
3. **ChatGPT-specific durable entry behavior** → belongs in Project Instructions.

Project Instructions should normally remain short enough to review as configuration rather than project documentation.

## 7. Google Drive project source

When ChatGPT supports adding the selected Drive folder as a Project Source, use the project root folder rather than uploading duplicate copies of its contents.

The Drive Project Source is an access/discovery convenience, not a new canonical copy.

For fresh or mutable data, use live Drive access/actions when available rather than relying on stale conversation excerpts.

Do not add unrelated Drive roots to the project merely because they are accessible through the same account.

## 8. GitHub access

The ChatGPT Project should use the configured project GitHub repository as the runtime/state source.

If the current ChatGPT session has direct GitHub write capability, G1 project-memory synchronization may be performed in the same chat.

If GitHub is read-only in the current session:

- perform useful read/analysis work normally;
- do not claim project-memory synchronization completed;
- produce the exact pending change/handoff needed for a write-capable session;
- follow the base G1 incomplete-synchronization rules.

## 9. ChatGPT-oriented execution preference

For this profile, prefer the simplest safe ChatGPT-native path:

1. connected GitHub/Drive actions for discovery and addressed reads/writes;
2. built-in analysis/file workspace when iterative processing is needed;
3. other supported ChatGPT execution surfaces only when they materially improve the task;
4. never introduce a local-materialization workflow merely because the generic base supports one.

The base G1 capability check and fallback ladder still apply.

## 10. Bootstrap procedure

Ground:

1. the target ChatGPT Project;
2. one project GitHub repository;
3. one Google Drive root folder.

Then:

1. read `PROJECT_INFRASTRUCTURE.md`, `COMMON.md`, G1 `BASE.md`, and this profile;
2. inspect GitHub and Drive according to G1 bounded brownfield rules;
3. reconstruct/project-bootstrap the canonical GitHub runtime and memory;
4. create/update the G1 manifest with both canonical stores and this profile;
5. create `_ai/infrastructure/chatgpt/` when needed;
6. run the Instruction Design step;
7. save the canonical Project Instructions to `_ai/infrastructure/chatgpt/PROJECT_INSTRUCTIONS.md`;
8. install the same instructions into the ChatGPT Project settings when the current environment permits it;
9. add the Drive root as a ChatGPT Project Source when supported and useful;
10. verify GitHub/Drive mappings and any deployed Project Instructions;
11. perform the profile cold-start validation.

If ChatGPT cannot directly change Project settings or add a Project Source, complete all canonical repository work and return the exact final Project Instructions plus the minimal manual UI actions still required.

## 11. Cold-start validation

Open or simulate a **new empty chat inside the same ChatGPT Project**.

Without using the originating bootstrap conversation, the new chat should be able to:

- identify the project from Project Instructions;
- identify the correct GitHub repository and Drive root;
- read `AGENTS.md` as the runtime contract;
- restore current state/tasks from canonical project-memory;
- find important Drive artifacts through `SOURCES.md` and/or the configured Drive source;
- understand that chat history is non-authoritative;
- check actual session capabilities before writes;
- follow G1 publication and synchronization rules.

A failure here means the ChatGPT adapter is incomplete even if base G1 files are structurally valid.

## 12. Completion report

After bootstrap, report:

- ChatGPT Project / GitHub repository / Drive root mapping;
- selected project-memory profile/language;
- project-memory files created/updated;
- canonical sources established;
- canonical Project Instructions path;
- whether Project Instructions were deployed to ChatGPT settings;
- whether the Drive root was added as Project Source;
- remaining manual UI steps, if any;
- cold-start validation result;
- any pending canonical publication or project-memory synchronization.

## 13. Minimal invocation

With authorized access to the standard repository:

> Apply **G1 / ChatGPT Project** to this ChatGPT Project using GitHub repository `<owner/repo>` and Google Drive folder `<folder URL or ID>` from `https://github.com/maxvfk/ai-workflow/blob/main/PROJECT_INFRASTRUCTURE.md`.

Without standard-repository access, provide:

- `PROJECT_INFRASTRUCTURE.md`;
- `project-infrastructure/COMMON.md`;
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/BASE.md`;
- `project-infrastructure/G1_GITHUB_GOOGLE_DRIVE/CHATGPT_PROJECT.md`;

and ask the same bootstrap request using the provided standard files.

# G2 — Selected text copies for remote collaboration

**Status:** agreed mechanism; proposed standard wording in PR #24  
**Date:** 2026-11-09  
**Scope:** optional small set of project-important texts in the existing GitHub repository; no new scenario or canonical store.

## Goal and restraint

A G2 agent with both GitHub and local artifact-root access should **know that it can publish selected key texts in GitHub** when a remote agent would benefit from reading or working on them. It may propose which files are useful, publish when explicitly requested or when an established project policy authorizes publication, and maintain selected copies at meaningful work checkpoints.

Examples: project schedule, key requirements, a currently drafted report, or the Markdown source from which a DOCX report is generated. **Do not** export every file or insist on a representative CAD/XLSX/PDF set, a conversion pipeline, a background watcher, or an additional pilot before ordinary use.

Use the existing `_ai/snapshots/` area (or an existing project-defined equivalent) and its index. Keep current snapshots unchanged unless a specific file is selected for updating or collaboration.

## One source of truth, two practical uses

For each selected text identify the canonical source (artifact-root-relative path or a GitHub source, if the project intentionally makes GitHub canonical) and choose one of two working arrangements:

1. **Read-only copy** — for reference, analysis, and discussion. Remote agents read it and make suggested edits elsewhere (e.g., a comment, task/report, or proposed patch). The copy is not the original.
2. **Collaborative text copy** — a named Markdown/text file in GitHub that an **authorized GitHub-writing agent** may edit. If the local Markdown remains canonical, these GitHub edits are **pending proposed updates** until an artifact-capable agent compares them against the current local source, reconciles concurrent edits, and applies them. Editing the GitHub copy never silently changes the local original or the DOCX built from it.

A project may explicitly designate GitHub Markdown as canonical for a particular document instead. In that case updates happen in GitHub and local DOCX/PDF are regenerated derivatives; do not impose this change on an existing local-source workflow without user agreement.

Agent's **GitHub write authority** is independent of whether it has access to the local artifact root. The existing restricted control-only mode remains default; authorized remote agents may edit GitHub-canonical files and specifically designated collaborative text copies, using normal project rules. This does not authorize writes to an unseen local original.

## Minimal copy record

In `_ai/snapshots/README.md` or adjacent to each copy, record only what is needed to avoid confusion:

- original canonical relative path (and source ID, if useful);
- when/from which revision the GitHub copy was last made or synchronized;
- whether it is `read-only` or `collaborative`;
- for collaborative copies, how to identify unapplied GitHub edits and who reconciles them.

An exact hash, extraction tool version, rich structured manifest, or mandatory multi-file folder is **not** required for every ordinary text. When verification matters, store a full measured hash or known revision. A timestamp alone does **not** prove the original remains current.

For documents with non-text content, state the important omissions. Avoid claiming a partial extraction reproduces the whole source. Only publish content to GitHub if its repository visibility, confidentiality, and existing access rules permit it.

## Lightweight lifecycle

1. **Select.** The full-access agent notices a key local text useful to other agents, suggests publication when appropriate, or follows the user's direct request. Existing project policies may authorize subsequent updates without repeated approval.
2. **Publish.** Copy relevant text with a minimal origin/mode/last-sync note to the existing GitHub snapshots area. No automatic folder mirroring.
3. **Work remotely.** An authorized GitHub-only agent reads the published text, discusses it, and (for a `collaborative` copy) edits that GitHub file or contributes a patch. It does not claim that the local artifact changed.
4. **Reconcile.** When the local source is accessible, the full G2 agent checks the **current** original and GitHub changes. If only one side changed, apply or refresh as appropriate. If both changed, do not overwrite either blindly: compare and merge or ask when intent is ambiguous. Track pending/unapplied remote edits until resolved.
5. **Continue.** Once the local source is updated, rebuild dependent outputs (e.g., the DOCX report), verify them as needed, and refresh the GitHub copy or last-sync marker. Do not force reconciliation after each sentence or every file save; use request or logical checkpoints.

For a read-only copy, refresh from the original; remote agent proposals are handled as proposals. For a collaborative copy, never refresh from the original by overwriting pending GitHub edits.

## Example: report

- Local synchronized folder: `Отчёт/report.md` (canonical source) and `Отчёт/report.docx` (generated output).
- GitHub: `_ai/snapshots/Отчёт/report.md`, indexed as **collaborative**, with local source path and last sync.
- A trusted remote agent edits the GitHub Markdown text on request. This is a proposed source change, not a modification of local `report.md` or `report.docx`.
- A full-access agent later compares local and GitHub text, incorporates approved edits safely, rebuilds `report.docx`, verifies output, and updates sync status.

This is an illustration of the workflow, **not** a requirement to name or create that directory in each project.

## Scope of PR #24

Update G2's optional snapshot and control-only guidance so the mechanism is **discoverable to full-access agents** and available on request. Do not copy actual `SP-Lab-Grant` artifact data, require a broad extraction pilot, create extra canonical stores, change installed runtimes automatically, or block this lightweight mechanism on support for binary formats.

Work on F-19…F-24 remains tracked separately in T-018.

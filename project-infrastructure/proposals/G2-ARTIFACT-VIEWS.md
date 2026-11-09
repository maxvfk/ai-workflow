# G2 Artifact Views and trusted remote collaborators — draft design

**Status:** implementation proposal / pilot pending  
**Started:** 2026-11-09  
**Scope:** G2 synchronized artifact root + GitHub control repository  
**Relationship:** extends existing G2 control-plane-only fallback and `_ai/snapshots/`; does **not** add a scenario, canonical store, or automatic mirroring.

## Goal

An authorized agent with GitHub access but without the synchronized local artifact root should be able to perform substantive project work: read high-value source-derived context, edit GitHub-canonical code/project memory within its granted scope, record decisions, develop calculations, and prepare artifact-change proposals. Its lack of physical access to local artifacts limits direct artifact operations and verification, **not necessarily GitHub write authority**.

An Artifact View is a bounded, GitHub-hosted **read-only derived representation** of a selected local canonical artifact. It may expose extracted text, structured facts/data, and/or a semantic overview. It must never be silently treated as the current original.

## Architecture and permission separation

- **Artifact root:** canonical for editable CAD, Office, PDF, binary datasets, measurement files and other project-owned artifacts that remain local.
- **GitHub:** canonical for project memory, instructions, Git-friendly code, decisions and plans. `_ai/snapshots/` contains *noncanonical* Artifact Views derived from selected originals.
- **Full G2 agent:** GitHub + artifact-root access; may generate/update views and apply/verify local artifact changes under normal rules.
- **Restricted control-only agent (existing default):** GitHub only, project memory read-only by default, task report in `_ai/inbox/` unless given an explicit bounded edit.
- **Trusted GitHub collaborator (new, opt-in):** GitHub only, may perform authorized GitHub-canonical edits with normal concurrency/contribution rules. Can use Artifact Views as evidence and record decisions. Must not claim direct knowledge of unobserved local changes.
- **Artifact-only agent:** local artifact root, no GitHub; unchanged fallback/report rules.

Project-level policy in the installed canonical `AGENTS.md` must make the permitted mode explicit. Actual GitHub permissions and user instruction remain authoritative. No automatic inference of elevated permissions merely because an agent is a known product/model. A trusted remote collaborator does not require blanket approval for each ordinary authorized GitHub edit. Risky or scope-expanding operations still use established project rules.

### Mutations and handoff

A trusted remote collaborator may:
- update `STATE.md`, `TASKS.md`, decisions, plans, GitHub-canonical code, and supporting text as warranted, with last-read revision checks;
- develop analyses from captured views, always stating capture date and coverage when material;
- stage a proposed CAD/Office/other local-artifact change as a patch, script, instructions, or task-specific report for later application and verification by an artifact-capable agent.

It must not:
- edit a derived view as though that edit changed the canonical original;
- assert that an artifact-root file is still current solely from a past capture hash;
- claim a direct local write, physical CAD verification, or completed artifact deployment without actual access;
- expand its own write scope beyond the configured project/user permissions.

Use `_ai/inbox/` for tasks that require deferred artifact-root validation/promotion or for restricted-agent handoff; do **not** force a handoff report for each ordinary authorized GitHub-canonical edit.

## Artifact Views layout

Retain the installed `_ai/snapshots/` path and existing files; no migration or duplication required for legacy snapshots.

Suggested layout when selected artifacts benefit from richer representations:

~~~text
_ai/snapshots/
  README.md                  # discoverable index + usage/staleness rules
  artifacts/
    S-034/
      overview.md            # metadata + meaningful description
      components.csv         # optional, tool-derived
      parameters.json        # optional, tool-derived
      dependencies.md        # optional
    S-038/
      extracted.md           # optional extracted text
~~~

Names and number of views are adaptive, not a mandatory directory skeleton. One plain Markdown file is sufficient for simple sources. Reuse `S-###` references to the **original** source in `SOURCES.md`; do not register each derivative as a new canonical source.

### Required provenance per published view

Each view (or its linked manifest, when multi-file) must make these available without relying on chat:
1. `derived / read-only` designation and canonical artifact-root-relative source path, plus existing `S-###` when known;
2. UTC capture date/time and source version/revision if applicable;
3. full SHA-256 fingerprint of the **exact original input(s)** at capture time, or an explicit explanation that fingerprinting was unavailable (then never label the view verified);
4. extractor/method and version where they affect interpretation;
5. representation type, coverage/completeness, and known omissions (e.g. CAD geometry and mates, PDF figures, XLSX calculation cache);
6. freshness semantics: `captured at <time>` is not the same as `currently verified`; evidence of revalidation must include time and source-access path.

For dependency-sensitive files (CAD assemblies, linked spreadsheets), record a bounded relevant input/dependency set and fingerprint/limitations for it; a single assembly-file hash does **not** prove the entire model assembly is unchanged.

Short index entries may point to the detailed provenance instead of repeating it. Unlike a live-source register, these are fingerprints of a particular **captured version**, not mutable checksums maintained in `SOURCES.md`.

Example (illustrative, not a real capture):

~~~markdown
# S-034 — CAD model overview

> Derived Artifact View; read-only. Canonical artifact is in the G2 synchronized root.
> Source: `Токовводы/Модель_макета/Макет токовводов — общая сборка.SLDASM`
> Captured (UTC): <actual timestamp>
> Source SHA-256: <full, measured hash>
> Relevant dependent inputs: <actual measured manifest or explicit limitation>
> Extractor: <name/version>
> Coverage: component list and selected geometry; complete 3D model NOT represented
> Freshness: valid for the captured revision only; present-day original not verified

## Exported facts
<actual measured or extracted facts only>
~~~

Never fabricate or backfill a missing historical hash from the derived view itself.

## Representation selection

Choose only material, authorized source artifacts and the smallest useful representation:

| Original | Useful derived view | Caveats |
|---|---|---|
| Existing Markdown/text | scoped text copy when needed | preserve original content, encoding, provenance; avoid redundant copies of GitHub-canonical text |
| DOCX/PDF | extracted text with headings/tables, source references | report omitted images, layout, embedded math or unreadable pages |
| XLSX | workbook/sheet inventory, meaningful cells with values **and** formulas, units/types | distinguish formula source from cached/evaluated result, dynamic links/macros and calculation state |
| CAD/SolidWorks | component/BOM, dimensions, units, materials, references, validation outcomes | no equivalence to actual 3D geometry; preserve identifiers and reference graph; use appropriate CAD tooling |
| Data tables | bounded CSV/JSON, schema, units, row/column scope | data sampling/truncation and provenance must be clear |

Do not run generic AI summarization as a substitute for faithful extraction of critical numeric, formulaic, or structural content. Semantic summaries may complement, never silently override, extracted source evidence.

## Publication and freshness lifecycle

1. **Select:** owner/project configuration selects useful artifacts; check repository visibility, confidentiality, third-party rights, sensitive content, and GitHub size/storage impact **before publishing**.
2. **Capture:** full-access agent reads verified canonical originals; perform normal G2 sync-sanity/target checks; materialize exact tool-derived representations and provenance.
3. **Validate:** check critical values, units, formulas, components, source links and known omissions against originals. Reject partial/ambiguous conversion unless explicitly flagged as partial.
4. **Publish:** commit views and index to GitHub as a coherent logical checkpoint; follow branch/concurrency rules. Views remain read-only derived context.
5. **Refresh:** update at relevant local-artifact milestones or explicit reconciliation, not every save. When a known source change affects a view, refresh or mark the view potentially stale. Manual/third-party edits between checkpoints may remain undiscovered.
6. **Consume:** remote agent checks capture date, coverage and dependencies. If the task depends on more recent/complete information than the view can establish, flag the limitation and request targeted verification from an artifact-capable agent.
7. **Reconcile:** proposals touching local artifacts remain pending until original is changed and verified. Original artifacts always outrank views in source-of-truth conflicts.

No mandatory filesystem watcher, continuous mirror, whole-folder scan, or forced user approval for each ordinary authorized capture. Avoid silently replacing legacy snapshots; migrate progressively by source when access is available.

## Pilot: SP-LAB-GRANT

The project already has a working `_ai/snapshots/README.md` and selected Markdown snapshots, plus a local `AGENTS.md` rule that explicitly permits the cloud collaborator to write confirmed project-memory decisions. This is real pilot evidence, **not proof that local originals are currently represented**.

Observed legacy limitations in the index: a single overall `Снято` date is used despite later listed captures; index hashes are shortened (16 hex characters); status/coverage are not consistently exposed; snapshot contents may be outdated. Do not relabel these as fresh/verified or invent full SHA-256.

**Pilot phase A (GitHub-side, without artifact-root access):**
- establish this design and opt-in trusted-GitHub permissions separately from visibility of local files;
- inventory existing snapshot metadata and mark unknown freshness where appropriate; preserve historical files;
- choose an initial 3–5 important source IDs and desired view types, without creating fake derived facts.

**Pilot phase B (requires authenticated local artifact-root access):**
- publish a small mixed-format sample with actual source hashes and extraction/validation notes (prefer Markdown, one spreadsheet, one CAD assembly, plus PDF/DOCX if useful);
- exercise a remote GitHub-only agent on a representative analytical/project-memory task, without origin-chat context;
- measure missing information and stale-data handling; verify that local-artifact changes are staged for reconciliation rather than falsely declared applied.

**Pilot phase C:**
- compare findings, simplify schema if too expensive, implement final reusable runtime text, decide standard version and merge;
- adapt the installed SP-LAB-GRANT runtime only with explicit approved upgrade/reconciliation; do not automatically mutate other G2 projects.

## Acceptance criteria

- An authorized remote agent can find GitHub project memory and selected views, explain source/capture/completeness boundaries, and make an allowed GitHub-only edit safely.
- A restricted control-only agent remains restricted by default.
- No source-of-truth confusion: changing a view does not constitute changing its original.
- At least one source-change checkpoint produces a correct refreshed view and the remote agent correctly handles an unverified/stale view.
- Sensitive/irrelevant data are not mirrored wholesale; old snapshots continue to work.
- A fresh agent can identify the task that requires an artifact-capable collaborator and leave an actionable handoff.

**Non-goals:** full binary artifact replication, CAD editing through Markdown, autonomous remote modification of local originals without access, automatic entire-folder indexing, and instant consistency after unobserved manual edits.

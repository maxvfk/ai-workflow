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

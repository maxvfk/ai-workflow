---
name: risk-gated-development
description: Vendor-neutral risk-based design, implementation and independent review workflow for AI coding agents.
---

# Risk-gated development

**Status: pilot (2026-11-02).** Applies to Codex, Claude Code and other coding agents. Roles are stable; choose vendor/model/effort separately using model routing. Follow the target project's current main, AGENTS.md and local rules first. This skill does not authorize paid reviews, code changes, merges or subsequent milestones.

## Risk classification

- **Low:** local documentation/UI fix; unchanged invariants and easy rollback. Relevant tests + CI; no mandatory external review.
- **Medium:** bounded new behavior or state. Brief risk checklist, negative tests, optional focused independent code review.
- **High:** parsers and formats, date/evidence interpretation, false confidence, provenance/IDs, auth/sync/conflicts, backup/migration, publishing, security or trust boundaries. Perform an independent *read-only design review before implementation*, then tests and cost-efficient preliminary code review followed by independent final merge-safety review.

Use impact and uncertainty, not file count. Do not reopen already approved architecture without new evidence. Project coordinator may explicitly adjust gates and record why; a coding agent must not initiate other reviewers or paid calls autonomously.

## Roles and gates

1. **Coordinator:** authorize scope, risk tier, reviewer budget and acceptance of design contract.
2. **Design Reviewer:** before high-risk coding, challenge assumptions and cross-layer interfaces. Deliver four bounded items: invariants/negative guarantees; realistic failure-mode matrix with severity; discriminative positive and negative acceptance tests; unresolved product decisions. Separate reproduced facts, code-derived risks and hypotheses. Do not redesign the project speculatively.
3. **Implementer:** implement the accepted contract in a short task branch/PR, preserve compatibility, test negative cases, run prescribed project checks and provide exact commit/CI/evidence handoff.
4. **Preliminary Reviewer:** inspect code read-only for concrete counterexamples; report file/line, actual vs expected, severity and smallest fix, not style-only refactors.
5. **Final Reviewer:** independently evaluate the stabilized exact head for previously missed failure modes. Green tests/CI do not prove correctness. Prefer a reviewer independent of implementation and preliminary review when practical.

For a confirmed blocker, make bounded corrections and use *focused re-review*. Repeat a full audit only if core design or risk boundaries materially change.

## Handoff contract

Persist accepted invariants/tests in the target repository's task/spec or linked PR discussion. Record current main and PR head SHAs, actual vs reported test execution, CI links, protected artifact parity, unresolved risks, and next concrete step. Keep review read-only when specified; never silently change source data or claim unsupported results. Merge only with authorized decision and necessary checks. Do not automatically start the next milestone.

## Pilot evaluation

Test on several future high-risk milestones. Observe missed defects, repeat review rounds, false positives, rework and usage when actually measurable. Do not promise that pre-design review saves tokens before evidence supports it.

This skill is independent of the versioned Project Infrastructure standard.
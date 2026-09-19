# Project Infrastructure Roadmap

This file records **deferred ideas**, not active or planned scenarios.

The pre-pilot standard is intentionally scoped to the implemented Draft scenarios:

- **G0 — GitHub Repository**
- **L1 — Local Folder**
- **G1 — GitHub + Google Drive**
- **G2 — GitHub + Synced Local Folder**

Do not treat anything below as part of the current scenario-selection model, bootstrap contract, or promised implementation work.

## Deferred ideas

### Provider-specific remote storage workflows

A future project may require behavior that depends materially on a storage provider's remote API/MCP/cloud semantics rather than on an ordinary synchronized local folder.

The original placeholder **Y1 — GitHub + Yandex Disk** is retired. Ordinary Yandex Disk desktop synchronization is covered by **G2**. Revisit a provider-specific design only if a real project demonstrates requirements that G2 cannot express, such as:

- remote-only Yandex Disk API/MCP access;
- provider-specific revision/version semantics;
- provider-specific identity-preserving publish-back;
- provider-specific conflict/recovery behavior that materially affects project correctness.

If such a need appears, first determine whether it belongs in:
- a small G2 profile/adapter;
- a cross-cutting remote-storage rule;
- or a genuinely new scenario.

Do not assume a separate Yandex-specific scenario in advance.

### Remote-only agent access

The original placeholder **R1 — Remote Agent** is retired.

Current G0/L1/G1/G2 scenarios already describe canonical-store roles and may be used from different execution surfaces when those surfaces can access the required stores. Revisit remote-only behavior only after a real project exposes a gap that cannot be expressed through the active scenario plus its access mode/profile.

Likely questions, if this becomes necessary:
- remote discovery and bounded retrieval;
- temporary materialization into an agent workspace;
- provenance for remote-only sources;
- safe publication when no direct local filesystem is available.

Prefer adding a cross-cutting access rule or product profile over creating a new scenario unless the canonical-store model itself changes.

### Multi-agent coordination

The original placeholder **H1 — Hybrid Multi-Agent** is retired.

The current standard already contains optimistic concurrency, one-canonical-copy rules, stable task IDs, shared-state re-read/reconcile behavior, and scenario-specific publication rules.

Revisit stronger multi-agent coordination only if pilot projects demonstrate concrete needs such as:

- explicit task ownership/leases;
- merge/validation gates between agents;
- durable coordination state;
- cross-agent review requirements;
- stronger locking/conflict protocols.

Prefer extending `COMMON.md` with proven cross-cutting rules before introducing a separate multi-agent scenario.

## Roadmap discipline

Before promoting any deferred idea into the active standard:

1. identify a real project/use case that is not adequately covered by G0/L1/G1/G2;
2. document the concrete failure/gap;
3. prefer the smallest compatible extension: common rule → scenario delta → profile/adapter → new scenario;
4. avoid adding placeholder scenario files before implementation is justified;
5. validate the change on a representative project before treating it as part of the production model.

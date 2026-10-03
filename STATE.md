# Текущее состояние

Last updated: 2026-10-01

## Статус

Project Infrastructure: **0.8.9 Draft**, pilot-review.

Первый dogfood выявил отсутствующий GitHub-only canonical-store case; на этом основании добавлен сценарий **G0 — GitHub Repository**. G0 установлен на самом `maxvfk/ai-workflow`, а cold-start simulation по installed runtime прошла успешно.

## Текущая конфигурация

- Canonical repository: `maxvfk/ai-workflow`
- Default branch: `main`
- Project-memory profile: `Standard`
- Project-memory language: `ru`
- Active infrastructure scenarios: G0, L1, G1, G2
- Claude compatibility policy: project-level `CLAUDE.md` imports `@AGENTS.md`; shared rules live only in `AGENTS.md`

## Что уже сделано

- Общие infrastructure rules централизованы в `COMMON.md`.
- Scenario files сокращены до environment-specific deltas.
- Y1/R1/H1 removed from active scope and retained only as deferred ideas in `ROADMAP.md`.
- G0 создан после реального dogfood gap, а не заранее.
- Repository self-application G0 завершён: установлены `AGENTS.md`, `CLAUDE.md`, Standard project memory, manifest и local standard snapshot.
- Cold-start simulation без исходного чата/внешнего стандарта прошла; в ходе проверки уточнены temporary/generated-work и branch-policy discovery rules в runtime.
- Тест из ChatGPT app/Work выявил, что доступный connector может не выбираться автоматически при двусмысленной цели. В 0.8.1 добавлено общее canonical-target-first tool routing: сначала определить authoritative store/artifact, затем выбирать connector/filesystem/browser/workspace.
- Проведены две реальные L1 brownfield-установки для связанных токамак-проектов; аудит подтвердил работоспособность базовой L1-структуры и выявил пограничные проблемы вокруг соседних проектов и межпроектных ссылок.
- В 0.8.2 принят упрощённый cross-project layer: stable Project ID, optional `PROJECTS/PROJECTS.md` catalog, plain organizational groups, consumer-owned dependencies и `Project ID + source-relative path` для внешних project artifacts.
- В 0.8.3 уточнена active-project boundary: агент может видеть whole `PROJECTS/` workspace, но по умолчанию работает только с одним active project; остальные проекты read-only external sources, а `PROJECTS.md` служит resolver/catalog.
- В 0.8.4 добавлено manual/external/delegated artifact reconciliation: пользователь, приложения и локальные агенты могут менять canonical artifacts напрямую; project memory допускается синхронизировать позже отдельным bounded reconciliation pass.
- В 0.8.5 добавлен профиль **G2 / Project Registry**: отдельный GitHub control repo ведёт `PROJECTS/PROJECTS.md`, а в корне `PROJECTS/` намеренно нет parent `AGENTS.md`; дочерние проекты используются как authoritative read-only evidence.
- В 0.8.6 добавлен G2 artifact-only fallback: локальный/delegated агент без GitHub может выполнять явно заданную bounded работу с artifacts, не имитируя полный project runtime, и оставляет scoped `_LOCAL_AGENT_REPORT.md` для последующего reconciliation.
- В 0.8.7 по результатам реального G2 pilot добавлен complementary control-plane-only fallback: режим включается только при реальной потребности, default project-memory boundary read-only, handoff идёт через `_ai/inbox/`, selected artifact texts могут передаваться через provenance-aware `_ai/snapshots/`, external incoming area опциональна, а full reconciliation проверяет не только результат, но и premises задачи.
- В 0.8.8 реализован Package B G2 pilot audit: child→registry lifecycle идёт через verified GitHub Issue handoff без прямой записи в `PROJECTS.md`; cross-project durable identity остаётся `Project ID + source-relative path` без обязательного дублирования каждой embedded link; single-project session рекомендуется root-ить на active project, а auto-loaded external instructions не расширяют write authority.
- В 0.8.9 реализован Package C: exact-content verified redundant/stale copies не блокируют intact canonical и не удаляются автоматически; artifact-only reproducibility при необходимости сохраняется минимальным `_LOCAL_AGENT_HANDOFF/`; legacy temp-leftover hygiene ограничена brownfield/migration; local-agent report трактуется как scope-limited evidence из-за отсутствия GitHub control-plane context.

## В работе

- Независимо перепроверить dogfood/runtime и исправления по открытым audit issues перед закрытием.

## Ближайшие следующие шаги

1. Провести независимый re-review установленного G0 runtime и последних corrective изменений.
2. Продолжить разбор G2 pilot audit пакетом D и внедрить только согласованные изменения.
3. После завершения аудита оценить, какие Draft правила требуют дополнительного упрощения или повторной проверки на реальном проекте.
4. Отдельно решить оставшиеся repository-level вопросы: private bootstrap и граница между infrastructure/model-routing workstreams.

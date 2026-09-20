# Текущее состояние

Last updated: 2026-09-20

## Статус

Project Infrastructure: **0.8.1 Draft**, pre-pilot.

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

## В работе

- Независимо перепроверить dogfood/runtime и исправления по открытым audit issues перед закрытием.

## Ближайшие следующие шаги

1. Провести независимый re-review установленного G0 runtime и последних corrective изменений.
2. Провести первый representative real-project pilot (приоритетно G2 или L1).
3. После пилота решить, какие Draft правила требуют упрощения/изменения.
4. Отдельно решить оставшиеся repository-level вопросы: private bootstrap и граница между infrastructure/model-routing workstreams.

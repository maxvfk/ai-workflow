# Текущее состояние

Last updated: 2026-09-19

## Статус

Project Infrastructure: **0.8.0 Draft**, pre-pilot.

Первый dogfood выявил отсутствующий GitHub-only canonical-store case; на этом основании добавлен сценарий **G0 — GitHub Repository**. Сейчас G0 применяется к самому `maxvfk/ai-workflow`.

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
- Repository self-application переведён из blocked state к установке G0 runtime/project memory.

## В работе

- Завершить self-application G0 и cold-start validation без исходного чата.
- Независимо перепроверить исправления по открытым audit issues перед закрытием.

## Ближайшие следующие шаги

1. Завершить и проверить G0 dogfood.
2. Провести первый representative real-project pilot (приоритетно G2 или L1).
3. После пилота решить, какие Draft правила требуют упрощения/изменения.
4. Отдельно решить оставшиеся repository-level вопросы: private bootstrap и граница между infrastructure/model-routing workstreams.

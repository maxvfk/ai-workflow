# Текущее состояние

Last updated: 2026-11-13

## Статус

`ai-workflow` — активный personal knowledge/workflow repository для организации работы с AI-агентами и AI-harnesses.

Project Infrastructure source standard: **0.9.0 Draft** в `main` (PR #15 merged 2026-11-05; F-25…F-36). Установленный G0 runtime самого `ai-workflow` остаётся **0.8.10** до отдельного review/adaptation upgrade. PR #13 с разбором F-01…F-16 merged в `main`.

Project Infrastructure остаётся отдельным версионируемым workstream внутри более широкого `ai-workflow`.

## Текущая конфигурация

- Canonical repository: `maxvfk/ai-workflow`
- Default branch: `main`
- Project-memory profile: `Standard`
- Project-memory language: `ru`
- Active infrastructure scenarios: G0, L1, G1, G2
- Claude compatibility policy: project-level `CLAUDE.md` imports `@AGENTS.md`; shared rules live only in `AGENTS.md`

## Текущие области

- **Project Infrastructure** — source standard 0.9.0 Draft в `main` (PR #15 merged); установленный runtime этого репозитория 0.8.10; G0/L1/G1/G2; первый G2 audit F-01…F-16 разобран и merged.
- **Model routing** — `AI_MODEL_ROUTING_MEMO.md`, `AI_MODEL_CURRENT_STATE.md`, `skills/model-router/`.
- **Skills** — canonical area `skills/`; сейчас зарегистрированы `model-router` и `codex-delegate`.
- **Claude Desktop** — `claude-desktop/`; сейчас есть Remote Control keepalive и guidance по ведению сессий.
- **Machines** — `machines/` (с 2026-11-13): профиль `RAIDERMAX` — инструменты, MCP-серверы Claude Code и Codex, особенности; указатели в глобальных инструкциях агентов на этой машине.
- **SolidWorks** — `solidworks/` (с 2026-11-11): правила для агентов, установка MCP-сервера `soheil-mp/solidworks-mcp` с правкой под SW 2023, приёмы COM API по опыту SP-LAB-GRANT и PIKAPOMP, скрипты осмотра на PowerShell.
- **Codex Cloud** — `codex-cloud/`; настройка environment, GitHub CLI, network permissions, диагностика PATH и cold-start smoke test по real-project опыту 30.10.2026.
- **G2 pilot follow-up** — F-25…F-36 реализованы в source standard 0.9.0 через PR #15; F-17/F-18 согласованы и реализованы в source `COMMON.md`/G2 через PR #25; F-19…F-24 остаются на разбор в T-018.

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
- В 0.8.10 реализован Package D: для новых Project ID принят uppercase ASCII hyphenated convention без переименования стабильных IDs; bootstrap prose следует Project-memory language; cold-start отчёты различают independent-agent и checklist/simulated-fresh; escape-sensitive programmatic writes проверяют persisted result. F-12 признан разовой environment setup проблемой и не меняет G2.
- PR #13 merged: Project Infrastructure 0.8.10 стал canonical на `main`.
- Scope `ai-workflow` расширен до общей системы организации работы с AI-агентами/harnesses; Project Infrastructure больше не трактуется как весь проект.
- Зарегистрированы reusable `skills/codex-delegate/`, Claude Desktop keepalive/session guidance и локальные индексы тематических областей.
- По G2 pilot part3 F-25…F-36 последовательно согласованы review decisions; через merged PR #15 опубликован source standard Project Infrastructure 0.9.0: layered current/history memory, adaptive AGENTS, Working with the user, document/source rules, operational know-how promotion, terminology, fresh-agent validation, G2 ephemeral-checkout durability и review-first standard upgrade.

## В работе

- T-018 — завершить follow-up review: F-25…F-36 реализованы (PR #15), F-17/F-18 реализованы в source standard (PR #25), F-19…F-24 ожидают разбора.
- T-017 — решить, какие общие правила нужны для delegated executors.
- T-002 — независимый re-review стандарта остаётся открытым.

## Ближайшие следующие шаги

1. Перейти к F-19…F-24 в T-018; F-17/F-18 уже реализованы в source standard и не требуют повторного рассмотрения.
2. Разобрать T-017 delegated executors с учётом реального `codex-delegate` workflow.
3. Провести независимый re-review установленного G0 runtime и отдельно решить, нужен ли самому `ai-workflow` upgrade с 0.8.10 на 0.9.0 по review/adaptation процедуре.

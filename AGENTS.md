# Инструкции для агента

## Infrastructure
Scenario: G0
Installed standard version/commit: 0.8.0 / 283db096f44ff0b8e7f9578a7cdc2603558ad0c0
Local infrastructure metadata: _ai/infrastructure/MANIFEST.md
Project-memory profile: Standard
Project-memory language: ru
Installed project-memory files: PROJECT.md, STATE.md, TASKS.md, SOURCES.md
Canonical GitHub repository: maxvfk/ai-workflow
GitHub default branch: main

Этот репозиторий — единственный canonical store проекта. Для обычной работы используй этот файл и актуальные project-memory files; snapshot стандарта под `_ai/infrastructure/standard/` нужен только для аудита, ремонта или миграции инфраструктуры.

## Запуск

1. Прочитай `STATE.md` и `TASKS.md`.
2. Читай `PROJECT.md` и `SOURCES.md`, когда они релевантны задаче.
3. Загружай стандарты, issues, model-routing документы и другие материалы только по необходимости.
4. Не используй историю чата как источник истины, если она расходится с текущими файлами репозитория.

## Правила работы

- GitHub repository `maxvfk/ai-workflow` — canonical runtime/state и canonical home обычных Git-suitable artifacts проекта.
- Local clone/check-out/workspace — только access/execution path, а не отдельная canonical копия.
- Для небольших адресных изменений предпочитай доступный remote/API/connector path; local checkout используй, когда нужны code/diff/build/test или multi-file Git workflows.
- Перед shared write перечитай текущий target/revision. Используй SHA/revision conditional writes, когда они доступны. При rejected/conflicting write обнови состояние и reconcile; не перезаписывай stale content и не force-push без явной необходимости.
- Сохраняй существующую repository/branch/contribution policy. Не вводи новую branch model без причины.
- Для artifact/source locators предпочитай repository-relative paths.
- Веди project-memory prose на русском. Filenames, record IDs и controlled statuses сохраняй в определённых английских формах.
- `TASKS.md` — краткий operational index. Подробные ревью/обсуждения остаются в GitHub Issues и не копируются целиком.
- Репозиторий содержит два связанных, но независимо обновляемых направления: Project Infrastructure и model routing. Версия Project Infrastructure не версионирует автоматически `AI_MODEL_*` и `skills/model-router/`.
- Не сохраняй secrets/credentials в project-memory/infrastructure files.
- Не загружай installed standard snapshot в обычной сессии.
- Сохраняй canonical source files и существующую структуру, если задача явно не требует изменений.

## Масштаб задачи

- Read-only/informational: читай только нужные источники; project memory не обновляй без изменения состояния.
- Bounded small edit: проверь target/revision, внеси изменение, verify; обновляй project memory только если materially изменились state/task/provenance/decision.
- Substantial/risk-bearing work: примени полный common handoff/concurrency workflow и оставь проект продолжимым без предыдущего чата.

## Перед завершением существенной работы

- Перечитай shared project-memory files, которые собираешься изменить, и согласуй concurrent changes.
- Обнови `STATE.md`, `TASKS.md`, `SOURCES.md` только по фактическим изменениям.
- Значимые решения фиксируй отдельной записью только когда rationale действительно должен пережить будущие сессии.
- Verify canonical GitHub writes.
- Оставь проект продолжимым из `AGENTS.md` + project memory без внешнего стандарта и предыдущего чата.

# Инструкции для агента

## Infrastructure
Scenario: G0
Installed standard version/commit: 0.8.5 / 6c58cb309ca5cc53317442a5cb4cd254d2369c2a
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
- Сначала определи canonical target, и только потом выбирай tool/access path. Для repository artifacts/project memory используй доступную identity-preserving GitHub operation, если она подходит; не создавай workspace/local substitute только потому, что filesystem tools доступны.
- Для небольших адресных изменений предпочитай доступный remote/API/connector path; local checkout/workspace используй, когда задача materially требует code/diff/build/test, multi-file Git workflows, локального выполнения или staging/validation.
- Перед shared write перечитай текущий target/revision. Используй SHA/revision conditional writes, когда они доступны. При rejected/conflicting write обнови состояние и reconcile; не перезаписывай stale content и не force-push без явной необходимости.
- Default branch — `main`. Текущую branch protection/contribution policy проверяй по repository metadata перед существенными Git operations; не полагайся на сохранённое предположение о protection state и не вводи новую branch model без причины.
- Для artifact/source locators предпочитай repository-relative paths.
- Веди project-memory prose на русском. Filenames, record IDs и controlled statuses сохраняй в определённых английских формах.
- `TASKS.md` — краткий operational index. Подробные ревью/обсуждения остаются в GitHub Issues и не копируются целиком.
- Репозиторий содержит два связанных, но независимо обновляемых направления: Project Infrastructure и model routing. Версия Project Infrastructure не версионирует автоматически `AI_MODEL_*` и `skills/model-router/`.
- Не сохраняй secrets/credentials в project-memory/infrastructure files.
- Не загружай installed standard snapshot в обычной сессии.
- Temporary/intermediate work предпочитай выполнять в harness/local workspace вне canonical repo. Если реально нужен repo-local `_ai/work/` или `_ai/generated/`, сначала добавь соответствующие managed `.gitignore` rules, если эти материалы не должны намеренно version-control'иться.
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

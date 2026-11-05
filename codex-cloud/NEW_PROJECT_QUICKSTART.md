# Codex Cloud: запуск нового проекта без повторения ошибок

**Назначение:** минимальный порядок действий для нового репозитория: сначала долговременные инструкции проекта в `AGENTS.md`, затем настройка опубликованной Codex Cloud environment, затем независимый cold-start. Подробности, подтверждённые кейсы и диагностика — [ENVIRONMENT_SETUP.md](ENVIRONMENT_SETUP.md). Не копировать пути, версии, список команд и Git refspec из `game-calendar` в другие проекты без проверки.

## Шаг 1. Подготовить `AGENTS.md` целевого репозитория

Проверить актуальный `main` и существующий `AGENTS.md`. Если файл уже есть, **дополнить недостающие правила**, а не заменять его общей заготовкой. Если файл отсутствует, создать краткий project-specific вариант.

Убедиться, что в проектных инструкциях отражены:

- **Источник истины и контекст:** где находится canonical код/состояние, какие документы и проверки нужно читать при старте; прошлый чат не выше текущего `main`.
- **Scope и Git workflow:** ветка от актуального `main`, продолжение существующего PR в его ветке, правила commit/PR/merge, ограничения для изменений production и данных.
- **Verification:** точные команды установки зависимостей, typecheck/test/build и дополнительные обязательные проверки данного проекта; не заявлять о прохождении того, что не запускалось.
- **Автономность:** агент самостоятельно решает небольшие локальные технические препятствия в пределах задачи; не требует разрешения на каждую команду и не превращает конкретный workaround в обязательное правило.
- **Границы:** не менять без полномочий published environment, credentials, системные настройки, сетевые разрешения, защищённые данные и принятые архитектурные решения; не скрывать fallback и не ослаблять проверки; соблюдать `read-only`.
- **Передача результата:** фиксировать PR/commit, выполненные проверки, блокеры и следующий concrete step; для прерванных задач сохранять восстановимое состояние.

Пример **только недостающего общего фрагмента**, который можно адаптировать к существующему `AGENTS.md` (не заменяет проектные правила):

```markdown
## Технические препятствия и автономность

При небольших локальных препятствиях самостоятельно диагностируй и
применяй минимальное безопасное, обратимое исправление в рамках текущей
задачи. Не запрашивай отдельное одобрение каждой технической мелочи.

Не изменяй без соответствующего разрешения published environment,
глобальную/системную конфигурацию, credentials или сетевые права.
Не скрывай смену workflow, не обходи значимые проверки и границы задачи.
Если препятствие нельзя исправить безопасно — сообщи о блокере.
Повторяющиеся проблемы и применённые решения отмечай в handoff.
Явный read-only режим запрещает любые изменения, включая git config.
```

**Не складывать в `AGENTS.md`** подробную историю ошибок, install script, абсолютные пути из одного Cloud-образа, все исследовательские заметки и длинные шаблоны промптов. Их место — в operational guide. Создание/правка `AGENTS.md` — изменение репозитория: выполнять в пределах разрешённого write-scope и проверять сохранённый diff. Наличие `AGENTS.md` не гарантирует, что конкретная Cloud-задача получила актуальную версию: проверить checkout и применимые инструкции в новой задаче.

## Шаг 2. Промпт в чат подготовки Codex Cloud environment

Заменить только `OWNER/REPO` и уточнить разрешённые действия, если они отличаются. Промпт **самодостаточен**: создавать новую среду можно даже если чат не имеет доступа к `ai-workflow`.

```text
Prepare a reusable Codex Cloud environment for OWNER/REPO.

This is an ENVIRONMENT SETUP task, not feature implementation.

FIRST — REPOSITORY CONTRACT
- Inspect CURRENT main, repository AGENTS.md (if present), README,
  manifests/lockfiles, CI workflows and applicable project docs.
- Identify the authoritative repository, project-specific runtime,
  required checks, development workflow and any external dependencies.
- Check that AGENTS.md records the project's real test commands,
  scope/merge rules, autonomous recovery of small local tooling
  problems, safety boundaries, and recoverable handoffs.
- If essential guidance is missing, propose a minimal AGENTS.md
  addition. Do not silently replace or modify repository instructions.
  If repo writing is separately authorized, use a scoped PR, not an
  unrelated application-code change.

ENVIRONMENT PREPARATION
- Inspect existing installed tools before installing anything.
- Design a minimal, reproducible, idempotent install_script and only
  necessary startup/readiness behavior.
- Make runtimes available to both non-login and login task shells.
  Do not assume a PATH export in setup or .bashrc persists.
- Do not modify platform-managed system profile scripts.
- Use project-specific versions and package-lock consistency.
- Avoid live source refresh, deployment, production changes, or
  unrequested secrets/network access during setup.
- Configure only justified network domains; include api.github.com
  if native GitHub CLI REST access is needed.
- Distinguish domain allowlist from per-task sandbox network permission.
- Test existing GitHub authentication before proposing a PAT or
  gh auth login; never display tokens.
- Diagnose proxy CONNECT failures separately from GitHub API
  authentication/authorization failures.

VALIDATION
- Run the project's required commands from AGENTS.md.
- Check runtime availability with both bash -c and bash -lc.
- Check Git and gh availability and read-only GitHub API access
  where permitted; report untested operations as NOT TESTED.
- Explain which actions need a user to Save, Publish/Republish,
  grant network permission, or approve a credential. Do not
  claim you performed UI actions that you could not perform.
- Do not assume the setup session is proof of a fresh task.

AFTER PUBLISH
- Supply a short separate cold-start task prompt for the user to
  run in a NEW Cloud task using the published environment.
- That test must check runtime, Git, GitHub CLI, auth, API, and
  project checks without installing or repairing tools.
- If native PR publication is part of the workflow, optionally
  verify branch -> harmless docs commit -> push -> draft PR ->
  PR/API checks -> CI; do not merge, close after verification.
- Do not preemptively change remote.origin.fetch. For existing
  feature branches, diagnose actual checkout tracking and use
  the smallest safe task-local Git operation.

FINAL REPORT
Give actual versions/paths, install/startup configuration, checks
with outcomes, access limitations, required manual actions and the
exact next step. Explicitly distinguish VERIFIED, UNVERIFIED and
BLOCKED. Do not begin a feature milestone.
```

## Шаг 3. После Publish — обязательная независимая проверка

**В новой Cloud-задаче** проверить, что нужные команды доступны без переустановки, оба shell находят runtime, Git и GitHub CLI доступны, `gh api` работает при разрешённом сетевом доступе, а проверки проекта проходят. Публикация новой конфигурации не доказывает, что прежние задачи автоматически её получили. Проверку нативного PR workflow выполнять на безопасной отдельной ветке, только если действительно нужна запись в GitHub.

Если fresh task выявил дефект, сначала диагностировать слой отказа, затем исправить published setup и выполнить **ещё один fresh cold-start**. Завершать настройку только по доказанным результатам новой задачи. Подробный runbook: [ENVIRONMENT_SETUP.md](ENVIRONMENT_SETUP.md).

## Чего не нужно делать

Не копировать `game-calendar`-specific Bun 1.3.14 и абсолютные пути как универсальный рецепт; не добавлять автоматически PAT, глобальный fetch всех веток, ненужные скрипты или повторяемые текстовые блоки в каждый task prompt. **Поведение агента — в `AGENTS.md`; runtime и доступы — в Cloud environment; опыт и процедура настройки — в `ai-workflow`.**

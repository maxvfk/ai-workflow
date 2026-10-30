# Codex Cloud: подготовка среды и проверка GitHub workflow

Практическая памятка по настройке **reusable Cloud environment** для разработки с Codex. Основана на проверках `maxvfk/game-calendar` **30.10.2026**; конкретные версии, пути, поведение shell и UI — **наблюдения одного окружения, не универсальные гарантии Codex**.

## 1. Перед публикацией

1. Выбрать правильный GitHub repository и `main`; проверить `AGENTS.md`, runtime и обязательные команды проекта.
2. В environment setup / `install_script` идемпотентно подготовить нужные инструменты и зависимости. Убедиться, что они **доступны новым задачам**, а не только процессу подготовки.
3. В `start_skill` держать только необходимые действия запуска сервисов и readiness checks; не скрывать в нём исправление базового `PATH` или повторную установку runtime.
4. Настроить минимальный сетевой доступ: package registries для dependencies, отдельные проверенные домены для остальных задач. Для GitHub REST API при необходимости разрешить `api.github.com`. В поле добавления домена **нажать Enter перед Save**.
5. Не создавать PAT, не запускать `gh auth login` и не добавлять secrets «на всякий случай». Проверять уже предоставленные механизмы GitHub authentication, не печатая токены.
6. Сохранить и **Publish** (или **Republish** после изменений). Текущая выполняющаяся задача не обязана получить новые настройки: подтверждать результат в **новой Cloud-задаче, выбрав актуальную опубликованную среду**.

## 2. Обязательный cold-start preflight в новой задаче

Выполнить без установки или ремонта runtime специально для этой проверки:

```bash
pwd
git status --short --branch
git remote -v
command -v git && git --version
command -v gh && gh --version
command -v bun && bun --version  # если Bun нужен проекту
bash -c  'command -v bun && bun --version'
bash -lc 'command -v bun && bun --version'
```

Если проект использует другой runtime, заменить Bun на соответствующие команды. Проверить `git fetch` / `git ls-remote` и свежесть `main`; не предполагать, что открытая рабочая копия автоматически актуальна.

Для `gh` **отдельно** проверить сетевой путь и авторизацию (при наличии разрешения на выполнение сетевых операций):

```bash
gh auth status --hostname github.com
curl -sS -o /dev/null -w '%{http_code}\n' \
  https://api.github.com/repos/OWNER/REPO
gh api repos/OWNER/REPO
```

Ожидаемый HTTP-ответ публичного repository endpoint — `200`. Никогда не выводить значения `GH_TOKEN`, PAT или credentials. `gh auth status` не заменяет проверку работающего запроса.

Затем выполнить **команды из конкретного `AGENTS.md`**, например для `game-calendar`:

```bash
bun install --frozen-lockfile
bun run typecheck
bun test
bun run build
```

Отдельно фиксировать, какие проверки были реально выполнены, и не объявлять готовность среды до успешного запуска **в новой задаче**.

## 3. Разбор подтверждённых проблем

### Runtime установлен, но `command not found` (game-calendar, 30.10.2026)

- Bun **1.3.14** физически был в `/workspace/.tools/bin/bun` (ссылка на `/workspace/.tools/bun/node_modules/@oven/bun-linux-x64/bin/bun`).
- `PATH` задачи не включал `/workspace/.tools/bin`.
- Login shell загружал `/etc/profile.d/codex-primary-runtime.sh`, **перезаписывавший** `PATH` фиксированным набором каталогов. Временный `export PATH=...` не переживал такой shell.
- Постоянное исправление, сохранённое в `install_script`: идемпотентные ссылки в уже присутствующем в обоих `PATH` каталоге `/home/agent/.local/bin`:

```bash
mkdir -p /home/agent/.local/bin
ln -sfn /workspace/.tools/bin/bun /home/agent/.local/bin/bun
ln -sfn /workspace/.tools/bin/bun /home/agent/.local/bin/bunx
```

Это **пример для подтверждённой структуры данного образа**, а не готовый универсальный install script. Перед применением проверить действительные пути, наличие target и то, что launcher `bunx` допустимо вызывать через этот бинарный файл. Не править системные runtime-скрипты платформы и не считать одну запись в `.bashrc` достаточной. После Republish оба `bash -c` и `bash -lc` в **новой** задаче увидели Bun 1.3.14.

### `gh api` возвращает `Forbidden` (game-calendar, 30.10.2026)

- В старой Cloud-задаче запросы к `api.github.com` прерывались **proxy CONNECT 403**; сообщение `gh auth status` о `GH_TOKEN` вводило в заблуждение. GitHub не успевал проверить токен.
- После добавления `api.github.com` в allowlist, Republish и получения **поддерживаемого разрешения на сетевое исполнение** в новой задаче HTTPS endpoint вернул **200**, `gh auth status` показал пользователя `maxvfk`, `gh api` сработал.
- **Domain allowlist и sandbox network permission — разные барьеры**. Даже разрешённый домен может быть недоступен из процесса без сетевого разрешения.
- Отличать `proxy CONNECT 403` от HTTP `401/403`, полученного **от GitHub после успешного соединения**. Не выдавать новый PAT или не объявлять токен неверным, пока сетевой путь не подтверждён.
- `git fetch/push` через `github.com` может работать при недоступном `api.github.com`: Git transport и REST API проверять раздельно.

### Ограничение исполнения или timeout

Не путать медленную операцию с отсутствующей возможностью. Перед обходом проверять ошибку, живой процесс, частично созданный checkout, состояние Git и доступный поддерживаемый network-permission mode. **О нестандартном fallback сообщать явно**, особенно если он меняет метод публикации, проверок или качество результата. GitHub connector может быть корректной альтернативой `gh`, но не должен скрывать реальную причину отказа CLI.

## 4. End-to-end GitHub smoke test

После cold-start, без вмешательства в production:

1. Проверить чистый checkout и свежий `main`, создать отдельную временную ветку.
2. Внести один безвредный Markdown-файл и пройти обязательные проверки проекта.
3. `git commit` и **native `git push`**; отдельно проверить права записи.
4. Создать **Draft PR** через `gh pr create --draft` и проверить `gh pr view` и `gh api repos/OWNER/REPO/pulls/NUMBER`.
5. Убедиться, что diff ограничен тестовым файлом и PR **не слит**; проверить CI там, где он настроен.
6. После проверки **закрыть без merge и удалить временную ветку**. Не использовать реальный production PR для эксперимента.
7. Записать выявленные ограничения, ссылку на PR, commit SHA и результаты. Не оставлять лишние ветки.

Новый PAT не нужен, если `gh` уже авторизован. При отказе GitHub CLI возможен явный connector fallback, но smoke test **именно native CLI** надо остановить и диагностировать, а не подменять.

## 5. Проверенный результат и границы обобщения

В `maxvfk/game-calendar` 30.10.2026 после исправления среды и Republish новая задача без ручной установки Bun выполнила обе shell-проверки, frozen install, typecheck, **1398 tests passed / 3 skipped / 0 failed**, build; нативно выполнила branch, commit, push, `gh pr create`, `gh pr view` и `gh api`. [Smoke PR #153](https://github.com/maxvfk/game-calendar/pull/153) — **closed without merge**, [CI run 41108129973](https://github.com/maxvfk/game-calendar/actions/runs/41108129973) — success. В production-коде изменений не было.

Ранее [C0 PR #152](https://github.com/maxvfk/game-calendar/pull/152) показал полезный fallback: локальный Git push работал, а PR/CI операции были выполнены через connector из-за отказа `gh api`. Два случая вместе демонстрируют, зачем нужен отдельный preflight.

Это **доказательство для данного runtime и конфигурации на указанную дату**, а не обещание, что все будущие образы, environments или аккаунты будут иметь те же пути, версии, network permissions и credentials.

**Критерий завершения настройки:** новый Cloud task проходит runtime/shell/network preflight, проектные проверки и — при необходимости — безопасный тест native GitHub PR workflow **без незаявленных обходных путей**.

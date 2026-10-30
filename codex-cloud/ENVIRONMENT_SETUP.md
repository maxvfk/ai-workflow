# Codex Cloud: настройка среды и GitHub workflow

Проверено на примере `maxvfk/game-calendar`, 30.10.2026. Цель — чтобы новая Cloud-задача **без ручного восстановления инструментов** могла проверить исходный код, выполнить тесты и создать PR. Это operational guide, **не** универсальная спецификация Codex.

## 1. Создание и публикация

1. Создать environment Codex Cloud с нужным GitHub-репозиторием и default branch.
2. Проверить предлагаемые `install_script` и `start_skill`: они должны соответствовать проекту, не запускать ненужный source refresh, не менять production-данные и не требовать лишних secrets. `install_script` — место для воспроизводимой подготовки runtime/dependencies; `start_skill` — для действительно нужного запуска сервисов, а не для маскировки ошибок установки.
3. Установить project-specific runtime и зависимости (для `game-calendar` — Bun 1.3.14 и `bun install --frozen-lockfile`). Версия Bun **не является общей рекомендацией** для других проектов.
4. Проверить предписанные проектом команды из `AGENTS.md`. В `game-calendar`: `bun install --frozen-lockfile`, `bun run typecheck`, `bun test`, `bun run build`.
5. Ограничить доступ к интернету и секретам минимально необходимым набором. Не включать unrestricted internet и не создавать PAT «про запас».
6. Сохранить настройки и `Publish`. После изменения конфигурации — `Republish`.
7. Обязательно провести **cold-start validation в новой Cloud-задаче** с опубликованной конфигурацией. Успешный прогон внутри preparation session не заменяет эту проверку. Старые выполнявшиеся задачи и продолжения прежнего окружения не следует считать проверкой новой конфигурации.

## 2. История реального дефекта: runtime есть, но команда не находится

В `game-calendar` подготовка показывала Bun 1.3.14, 1398 прошедших тестов / 3 штатных пропуска, успешные typecheck и build. Однако новая тестовая задача получила `bun: command not found` (exit 127).

Диагностика в **той** среде установила:

- Bun реально существовал как `/workspace/.tools/bin/bun` (ссылка на `/workspace/.tools/bun/node_modules/@oven/bun-linux-x64/bin/bun`); `~/.bun/bin/bun` отсутствовал.
- `/workspace/.tools/bin` отсутствовал в effective `PATH` задачи.
- `/etc/profile.d/codex-primary-runtime.sh` сбрасывал `PATH` в login shell. Однократный `export PATH="/workspace/.tools/bin:$PATH"` в процессе или `.bashrc` не обеспечивал оба режима.
- Установленный Bun сохранялся между задачами; повторная установка **не требовалась**.

Проверенное исправление для этой конфигурации: сохранить в `install_script` идемпотентное создание ссылок в `/home/agent/.local/bin`, который уже присутствовал в `PATH` обоих shell:

```bash
# Только пример для среды, где эти пути действительно существуют.
test -x /workspace/.tools/bin/bun
mkdir -p /home/agent/.local/bin
ln -sfn /workspace/.tools/bin/bun /home/agent/.local/bin/bun
ln -sfn /workspace/.tools/bin/bun /home/agent/.local/bin/bunx
```

В `start_skill` убрали временный `PATH` workaround. Системный `codex-primary-runtime.sh` не меняли. **Не копировать пути вслепую**: сначала проверить расположение runtime, пользователя, `PATH` обоих shell и то, что выбранный каталог персистентен.

Обязательные тесты после `Republish` в **новой** Cloud-задаче:

```bash
bash -c 'command -v bun && bun --version'
bash -lc 'command -v bun && bun --version'
```

В нашем cold-start оба вызова без ремонта/переустановки нашли `/home/agent/.local/bin/bun`, версию `1.3.14`. После этого прошли все четыре проверки проекта.

## 3. GitHub: не смешивать разные каналы доступа

| Канал | Назначение | Что проверять |
| --- | --- | --- |
| Обычный Git | `clone/fetch`, branch, commit, push | `git fetch`, фактический remote, доступ для `push` |
| GitHub CLI (`gh`) | GitHub REST API, PR и CI | `gh --version`, `gh auth status --hostname github.com`, `gh api` |
| GitHub connector | Отдельная API-интеграция | Доступные read/write operations и их scope |

Успешный `git push` **не доказывает** работоспособность `gh api`, а доступный connector не означает, что CLI получил те же credentials. Неизвестное состояние `GH_TOKEN` нельзя определять по одной ошибке proxy.

### Интернет и сетевые разрешения

В первоначальной конфигурации `game-calendar` работали Git и connector, но `gh api` получал `403 Forbidden` на этапе proxy CONNECT к `api.github.com`. Это была **сетевая блокировка до GitHub**, а не подтверждение недействительного токена.

Проверенный путь в нашем случае:

1. В environment settings явно разрешить `api.github.com` в доменном allowlist, не открывая без необходимости весь интернет. В поле списка доменов **нажать Enter** для добавления значения, затем сохранить настройки и `Republish`.
2. В самой новой задаче разрешить поддерживаемый режим выполнения с network permission, если sandbox блокирует соединение. Изменение списка доменов и разрешение сети на выполнение — **разные уровни контроля**.
3. Повторно проверить соединение и авторизацию. В нашем тесте после разрешения сети HTTPS endpoint вернул HTTP 200, `gh auth status` подтвердил `maxvfk` через уже существующий `GH_TOKEN`, `gh api` прошёл.

`Proxy CONNECT 403`, `401 Unauthorized` от GitHub, `403` от GitHub с авторизованным ответом и локальная `gh auth status` failure — **не одно и то же**. В отчёте фиксировать точный шаг и слой отказа; не объявлять токен неверным до проверки сетевого пути. Никогда не выводить токены в логах, не запрашивать PAT и не выполнять `gh auth login` без доказанной необходимости и безопасного пути авторизации.

### Минимальная read-only диагностика

```bash
git --version
gh --version
gh auth status --hostname github.com
curl -sS -o /dev/null -w '%{http_code}\n' https://api.github.com/repos/OWNER/REPO
gh api repos/OWNER/REPO --jq '.full_name'
```

Не помещать токены в командную строку, URL, commit, PR или текст чата. При отказе от network/sandbox permission остановиться и сообщить, какие операции останутся недоступными.

## 4. Обязательный preflight, прежде чем менять код

- Определить authoritative repository, текущий `main`, `AGENTS.md` и статус локальной рабочей копии. Не начинать работу на stale base.
- Проверить нужный runtime **без установочных workaround**, работу dependency manager и наличие инструментов.
- Определить **доступный способ публикации**: обычный `git push` + `gh pr create` либо GitHub connector. Выбирать самый прямой поддерживаемый путь; connector допустим как fallback, но это нужно обозначить.
- При ошибке/timeout проверить состояние процесса, рабочую копию, network permission, proxy и credentials по отдельности. Не трактовать timeout как запрет `git clone` и не переключаться молча на сложный API-workaround.
- Если ограничение ухудшает проверки, publication workflow или увеличивает объём ручной работы — **сообщить о нём и предложить исправление** до продолжения.
- Выполнить проверки, требуемые `AGENTS.md`; после публикации проверить remote commit SHA, diff, статус PR и CI. Не заявлять «всё готово», если значимая проверка не выполнена.

## 5. End-to-end smoke test для НОВОЙ среды

Проводить после initial Publish или существенного Republish, на безопасном тестовом изменении, **не** в production-коде:

1. В новой Cloud-задаче проверить login/non-login shell, версии runtime и `gh`; не чинить инструменты временно в той же задаче.
2. Проверить `gh auth status` и read-only `gh api` с нужным network permission.
3. Сделать `git fetch`, создать краткоживущую branch от текущего `main`.
4. Добавить безвредный Markdown-файл; выполнить обязательные project checks.
5. Сделать native `git commit` → `git push` → `gh pr create --draft` → `gh pr view` → `gh api repos/OWNER/REPO/pulls/NUMBER`.
6. Сверить base/head SHA, содержимое diff и CI. **Не сливать** smoke PR; закрыть его без merge и удалить временную ветку после проверки.

Итоговый успешный тест `game-calendar`: Bun 1.3.14 находился обоими shell; Git 2.52.0; `gh` 2.46.0; авторизация/API/fetch/push/PR работали; четыре проверки проекта прошли (1398 pass, 3 skip, 0 fail). [Тестовый PR #153](https://github.com/maxvfk/game-calendar/pull/153) был создан нативным `gh pr create`, проверен через `gh`, его CI прошёл, затем PR **закрыт без merge**. Это доказывает указанные операции **для проверенного environment на дату теста**, но не гарантирует будущую доступность credentials/сети или всех GitHub API permissions.

## 6. Разбор ограничений и безопасный fallback

| Симптом | Сначала проверить | Не делать автоматически |
| --- | --- | --- |
| `bun: command not found` | `command -v`, absolute path, `PATH` обоих shell, install script | Переустанавливать runtime в каждой задаче |
| `gh api`: proxy `CONNECT 403` | Allowlist `api.github.com`, permission на сеть, proxy layer | Менять/выдавать `GH_TOKEN` |
| `gh auth status` показывает ошибку | Сначала сеть, затем реальный authentication failure | Считать любой `Forbidden` плохим токеном |
| `git clone` «завис»/timeout | Состояние процесса, локальный каталог, транспорт | Объявлять Git недоступным без диагностики |
| `gh pr create` недоступен | Сеть, `gh` auth, permissions, существование head branch | Молча публиковать другим способом |

Если среда действительно блокирует нативный `gh`, можно использовать авторизованный GitHub connector, когда это безопасно и соответствует scope, но **с явным сообщением о причине fallback**. Не ослаблять тесты, правила репозитория или защиту секретов ради обхода.

## Проверенное свидетельство и границы

- [C0 implementation PR #152](https://github.com/maxvfk/game-calendar/pull/152) — разработка с Git и работающим connector; нативный `gh api` первоначально был заблокирован сетью.
- [Cloud GitHub CLI smoke PR #153](https://github.com/maxvfk/game-calendar/pull/153) — точный воспроизводимый холодный запуск после `Republish`, commit/push/PR через native Git/`gh`; закрыт без merge, GitHub Actions CI прошёл.
- Конкретные пути `/workspace/.tools`, `/home/agent/.local/bin`, поведение `codex-primary-runtime.sh`, версии Git/Bun/gh и сообщение proxy относятся к исследованной среде 30.10.2026 и могут измениться. Для другой среды повторить preflight, не копировать механически настройки.

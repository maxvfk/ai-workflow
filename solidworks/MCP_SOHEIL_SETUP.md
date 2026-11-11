# MCP-сервер `soheil-mp/solidworks-mcp`: установка и подводные камни

Проверено 2026-11-11 на Windows 11 + SOLIDWORKS Premium 2023 SP1 (31.1.0), проект
`PIKAPOMP`. Сервер — C#/.NET 10, официальный COM API, 161 инструмент
(репозиторий: <https://github.com/soheil-mp/solidworks-mcp>, MIT, 0.1.0 pre-release;
автор проверял на SW 2025 SP1.2).

Проверенная версия исходников: коммит `fd03a7f78eba1071eb5b60ce809811db99a8137e`
(2026-11-05) + `patches/soheil-mcp-sw2023.patch`.

## 1. Что нужно

- Windows 10/11 x64, установленный и активированный SolidWorks.
- git.
- .NET 10 SDK (рантайма недостаточно).
- Python 3 — только для ручной проверки через клиент из репозитория сервера (не
  обязательно).

Проверка:

```powershell
dotnet --list-sdks            # нужна строка 10.x
git --version
dir "C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS\api\redist\SolidWorks.Interop.sldworks.dll"
```

Установка SDK (пакет Microsoft, может спросить права администратора):

```powershell
winget install --id Microsoft.DotNet.SDK.10 --exact --silent --accept-package-agreements --accept-source-agreements
```

## 2. Исходники

Клонировать **вне** синхронизируемых папок и папок проектов, например в
`%LOCALAPPDATA%\solidworks-mcp\src`, и закрепить проверенный коммит:

```powershell
$src = Join-Path $env:LOCALAPPDATA 'solidworks-mcp\src'
git clone https://github.com/soheil-mp/solidworks-mcp.git $src
git -C $src checkout fd03a7f78eba1071eb5b60ce809811db99a8137e
```

Перед сборкой новой версии — прочитать `tools/install.ps1`, `*.csproj` (зависимости) и
поискать сетевые вызовы (`HttpClient`, `WebRequest`, `Process.Start`) в `src/`. В
проверенном коммите их нет; зависимости — `ModelContextProtocol` 2.3.0 и
`Microsoft.Extensions.*`.

## 3. Сборка под свою версию SolidWorks

Проект собирается против interop-DLL **установленного** SolidWorks
(`<SolidWorks>\api\redist\`; путь ищется в реестре для 2026…2023, можно задать
`SOLIDWORKS_DIR`). Если в коде есть вызовы API новее установленной версии, сборка падает
с `CS1061`/`CS0117`.

**SolidWorks 2023:** две ошибки — `InsertUntrimSurface2` и
`swCustomInfoType_e.swCustomInfoEquation`. Применить правку:

```powershell
git -C $src apply <путь к ai-workflow>\solidworks\patches\soheil-mcp-sw2023.patch
```

Что в ней: `InsertUntrimSurface2(..., true, false)` → `InsertUntrimSurface(..., true)`
(старый вариант метода, есть в 2023); ветка `swCustomInfoEquation` убрана (в 2023 такого
значения нет — свойство-уравнение будет называться `unknown`).

Для другой версии SolidWorks: собрать, посмотреть ошибки, проверить, что есть в своей
interop-DLL (PowerShell):

```powershell
$a = [Reflection.Assembly]::LoadFrom('C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS\api\redist\SolidWorks.Interop.sldworks.dll')
$a.GetType('SolidWorks.Interop.sldworks.IFeatureManager').GetMethods() | ? Name -like '*Untrim*' | % Name
```

Сборка и публикация в версионированную папку без регистрации:

```powershell
$env:DOTNET_CLI_TELEMETRY_OPTOUT = '1'
powershell -ExecutionPolicy Bypass -File "$src\tools\install.ps1" -NoRegister
```

Ожидаемый вывод: `CATALOG: 161 tools` и `CATALOG: ok`; exe —
`%LOCALAPPDATA%\solidworks-mcp\bin\0.1.0-<дата-время>\solidworks-mcp.exe`.

Если Smart App Control блокирует свежесобранный exe («An Application Control policy has
blocked this file»), установщик сам переходит на `dotnet <путь>\solidworks-mcp.dll`;
регистрировать тогда команду `dotnet` с аргументом-путём к DLL.

## 4. Регистрация

Сервер — stdio. В конфиг пишется путь к exe из шага 3. Рекомендуемая переменная:
`SWMCP_VBA=off` (запуск произвольного VBA выключен).

**Claude Code, для всех проектов (user scope).** С CLI:

```powershell
claude mcp add --scope user solidworks --env SWMCP_VBA=off -- "C:\Users\<user>\AppData\Local\solidworks-mcp\bin\<версия>\solidworks-mcp.exe"
```

Без CLI (Claude Code внутри Claude Desktop, команды `claude` в PATH нет) — сделать копию
`%USERPROFILE%\.claude.json` и добавить в его верхний объект `mcpServers`:

```json
"solidworks": {
  "type": "stdio",
  "command": "C:\\Users\\<user>\\AppData\\Local\\solidworks-mcp\\bin\\<версия>\\solidworks-mcp.exe",
  "args": [],
  "env": { "SWMCP_VBA": "off" }
}
```

Только для одного проекта — `--scope local` (или запись в `projects["<путь проекта>"].mcpServers`).

**Claude Desktop (чат):** `%APPDATA%\Claude\claude_desktop_config.json`, ключ `mcpServers`,
та же запись без `"type"`.

**Codex (CLI / Desktop):** `%USERPROFILE%\.codex\config.toml`:

```toml
[mcp_servers.solidworks]
command = 'C:\Users\<user>\AppData\Local\solidworks-mcp\bin\<версия>\solidworks-mcp.exe'
env = { SWMCP_VBA = "off" }
```

(Регистрация в Codex на этой конфигурации не проверялась. В SP-LAB-GRANT прямой COM из
песочницы Codex давал `MK_E_UNAVAILABLE` — если сервер не видит SolidWorks, проверить, не
запускается ли он в песочнице.)

Инструменты появляются **в новой сессии**. Работают, только когда SolidWorks запущен;
иначе инструменты отвечают, что SolidWorks не найден.

## 5. Проверка

В новой сессии агента: «проверь статус SolidWorks» → `sw_status`: `attached: true`,
`revision` = версия SolidWorks.

Без агента — клиентом из репозитория сервера (Python, только стандартная библиотека):

```python
import sys, os, glob
sys.path.insert(0, os.path.join(os.environ['LOCALAPPDATA'], 'solidworks-mcp', 'src', 'tools'))
sys.stdout.reconfigure(encoding='utf-8')
from mcp_client import McpClient
exe = sorted(glob.glob(os.path.join(os.environ['LOCALAPPDATA'], 'solidworks-mcp', 'bin', '*', 'solidworks-mcp.exe')))[-1]
with McpClient(exe, env={'SWMCP_VBA': 'off'}) as c:
    print(c.call('sw_status'))
    print(c.call('doc_list'))
```

Проверено на реальной сборке (131 компонент): `doc_open {readOnly:true}`, `model_info`,
`asm_component_list`, `model_review`, `asm_interference`, `view_screenshot` — работают.

Встроенный `tools/mcp_smoke.py` сервера **создаёт и сохраняет** документы — запускать
только при закрытых документах пользователя.

## 6. Обновление

```powershell
git -C $src fetch; git -C $src checkout <новый коммит>
git -C $src apply <...>\soheil-mcp-sw2023.patch   # если не применяется — разбирать ошибки сборки заново
powershell -ExecutionPolicy Bypass -File "$src\tools\install.ps1" -NoRegister
```

Затем поменять путь к exe в конфиге клиента (каждая сборка — новая папка `bin\<версия>`;
старые можно удалить, когда сервер не запущен).

## 7. Подводные камни

- **Запись файлов** — только в профиль пользователя и `%TEMP%`; относительные пути — в
  `Documents\solidworks-mcp`. Чтобы сохранять чертежи/экспорт в папки проектов, задать
  `SWMCP_WRITE_ROOTS` (например `C:\Yandex.Disk\PROJECTS`) в `env` записи сервера.
  Сетевые пути запрещены.
- **Документы пользователя** — `foreign`, только чтение. Править — после
  `doc_activate {doc, allowEdit:true}` (сервер делает резервную копию в
  `%LOCALAPPDATA%\solidworks-mcp\backups`).
- **Сборка сразу после открытия помечается изменённой** (наблюдалось дважды на одной
  модели — вероятно, внешние ссылки/перестроение при загрузке). `doc_close` без `discard`
  отказывает; `discard` в Claude Code автоматический режим может запретить как
  разрушительное действие. Тогда оставить документ открытым и попросить пользователя
  закрыть его без сохранения (открыт только для чтения — файл не изменится).
- **Интерференция** находит и условности модели: резьбы ISO-крепежа в гайках, макеты
  (лента в зажимах), винты в отверстиях. Сравнивать с исходным числом пересечений модели,
  а не ждать нуля.
- **Один агент на один SolidWorks**: несколько серверов сериализуются блокировкой, но
  делят один экземпляр.
- **Каталог инструментов большой** (~230 КБ). Клиенты с отложенной загрузкой
  инструментов (Claude Code) подгружают их по необходимости; в остальных он занимает
  контекст.
- **Claude Code на Windows, инструмент Bash:** файлы, записанные из Bash за пределами
  рабочей папки (например, `git clone` в `%LOCALAPPDATA%`), могут оказаться в
  изолированном слое песочницы и не видны другим процессам. Установку делать из
  PowerShell.
- **Вывод с кириллицей** из Python в консоль Windows: `sys.stdout.reconfigure(encoding='utf-8')`
  или `PYTHONIOENCODING=utf-8`, иначе `UnicodeEncodeError` (cp1252/cp1251).

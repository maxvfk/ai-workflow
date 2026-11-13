# RAIDERMAX — профиль машины

Last verified: 2026-11-13 (проверено командами на машине).

## Система

- Windows 11 Pro 10.0.26200; Intel Core Ultra 7 255HX; 31 ГБ ОЗУ.
- Пользователь `maxvf`; профиль `C:\Users\maxvf`.
- Синхронизируемая папка: Яндекс.Диск `C:\Yandex.Disk`; проекты —
  `C:\Yandex.Disk\PROJECTS\` (`Pikapomp`, `SP-Lab-Grant`, `RSF-Levitation`, `Tokamak`,
  `_Сторонние`). Клоны управляющих репозиториев и временную работу держать вне неё.

## Агенты

| Агент | Конфиг MCP | Глобальные инструкции |
|---|---|---|
| Claude Code (внутри Claude Desktop, вкладка Code) | `~/.claude.json` → `mcpServers` | `~/.claude/CLAUDE.md` |
| Codex CLI 0.167.2 (`codex`, через npm) / Codex Desktop | `~/.codex/config.toml` → `[mcp_servers.*]`; песочница Windows `sandbox = "elevated"` | `~/.codex/AGENTS.md` |

- Команды `claude` в PATH нет: MCP для Claude Code регистрировать правкой
  `~/.claude.json` (с резервной копией), не `claude mcp add`.
- Новые MCP-серверы видны агенту только в новой сессии.

## MCP-серверы

| Сервер | Claude Code | Codex | Что это |
|---|---|---|---|
| `solidworks` | да (user scope, с 2026-11-11) | да (с 2026-11-13, из Codex не проверялся) | `soheil-mp/solidworks-mcp` — управление запущенным SolidWorks; см. ниже |
| `nethys` | да | да | `C:\Tools\oracle-of-nethys` (Node, ts-node) — правила Pathfinder 2e |
| `node_repl` | — | да | встроенный Node REPL Codex |

### solidworks (`soheil-mp/solidworks-mcp`)

- exe: `C:\Users\maxvf\AppData\Local\solidworks-mcp\bin\0.1.0-20261111-122550\solidworks-mcp.exe`;
  `SWMCP_VBA=off`; `SWMCP_WRITE_ROOTS` не задан (запись — только профиль и `%TEMP%`).
- Исходники: `%LOCALAPPDATA%\solidworks-mcp\src` — коммит `fd03a7f` +
  `solidworks/patches/soheil-mcp-sw2023.patch`. Резервные копии правок сервера —
  `%LOCALAPPDATA%\solidworks-mcp\backups`.
- Работает, только когда SolidWorks запущен.
- Установка, обновление, подводные камни: [`../solidworks/MCP_SOHEIL_SETUP.md`](../solidworks/MCP_SOHEIL_SETUP.md).
- Копии конфигов до регистрации: `~/.claude.json.bak-20261111-124309`,
  `~/.codex/config.toml.bak-20261113-164544`.

## Инструменты

| Инструмент | Версия / путь | Заметки |
|---|---|---|
| SOLIDWORKS Premium 2023 SP1 | 31.1.0; `C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS\` | interop-DLL — `api\redist\` |
| .NET SDK | 10.0.404 (+ runtime 8.0.31); `C:\Program Files\dotnet\` | нужен для сборки MCP-сервера |
| Python | 3.13 (по умолчанию в `py`), 3.12 (`python` в PATH) | **pywin32 нет** ни в одной — COM из Python не работает; для COM — PowerShell (`../solidworks/COM_NOTES.md`) |
| PowerShell | Windows PowerShell 5.1 (`powershell.exe`), PowerShell 7.7 (`pwsh`) | COM к SolidWorks проверен в 5.1 |
| Git | 2.55.0 | |
| GitHub CLI `gh` | 2.101.0 | авторизован для `maxvfk/*` |
| Node.js | 24.20.0, npm | |
| winget | есть | |
| uv / uvx | нет | |
| LibreOffice `soffice`, pandoc, PyMuPDF, python-docx, matplotlib | есть | использовались для сборки DOCX/PDF в PIKAPOMP |

## Известные особенности

- **Claude Code, инструмент Bash:** записи за пределами рабочей папки (например,
  `git clone` в `%LOCALAPPDATA%`) могут попадать в изолированный слой песочницы и не
  видны другим процессам — установки делать из PowerShell.
- **Codex:** прямой COM к SolidWorks из песочницы давал `MK_E_UNAVAILABLE`, с
  повышенными правами — работал (SP-LAB-GRANT, 30.10.2026).
- **Вывод кириллицы из Python:** `PYTHONIOENCODING=utf-8` или
  `sys.stdout.reconfigure(encoding='utf-8')`.
- **Автоматический режим Claude Code** может запретить действия с отбрасыванием изменений
  (например, `doc_close {discard:true}`) — тогда просить пользователя.

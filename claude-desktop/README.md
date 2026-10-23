# Claude Desktop

`claude-desktop/` — canonical home материалов `ai-workflow`, специфичных для Claude Desktop: operational guidance, проверенные workflows, особенности продукта, known issues и решения.

## Правила размещения

- Клади сюда материал, если он существенно зависит именно от Claude Desktop.
- При добавлении/удалении/переименовании durable материала обнови этот индекс.
- Если найденное правило на деле общее для разных harnesses или проектов, не дублируй его здесь навсегда: вынеси/повышай его в подходящую общую область отдельным решением.
- Не создавай новый product/harness top-level каталог только ради одного случайного файла; сначала должна появиться устойчивая потребность.

## Текущие материалы

### Remote Control keepalive

Path: `claude-desktop/REMOTE_CONTROL_KEEPALIVE.md`

Схема «диспетчер + сторож», позволяющая сохранять доступ к Claude Desktop sessions с телефона через Remote Control после перезапуска/обновления приложения.

### Ведение сессий

Path: `claude-desktop/SESSIONS.md`

Практика основной и дочерних сессий, fork vs child session, сжатие контекста, память Claude и reusable user-level guidance.

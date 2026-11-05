# Skills

`skills/` — canonical home reusable agent skills в `ai-workflow`.

## Правила размещения

- Каждый reusable skill по умолчанию живёт в собственном каталоге `skills/<skill-name>/`.
- Основная инструкция skill — `SKILL.md`; helper scripts/configs/templates, специфичные для skill, лежат рядом.
- Перед созданием нового skill проверь этот индекс и существующие каталоги, чтобы не дублировать уже имеющийся workflow.
- При добавлении, удалении или переименовании skill обнови этот индекс.
- Нахождение skill в `skills/` не означает автоматическую привязку его версии к Project Infrastructure или другому workstream. Явные зависимости документируются в самом skill или project memory.

## Текущие skills

### model-router

Path: `skills/model-router/`

Помогает выбрать подходящий vendor/model/environment/effort для задачи на основе routing memo и current-state snapshot.

Entry point: `skills/model-router/SKILL.md`.

### codex-delegate

Path: `skills/codex-delegate/`

Делегирование задач из Claude Code в OpenAI Codex через plugin/harness workflow: запуск, мониторинг, usage и проверка результата.

Entry point: `skills/codex-delegate/SKILL.md`.

Helper: `skills/codex-delegate/run-codex-task.sh`.

# Проект ai-workflow

## Цель

Поддерживать переносимую систему рабочих правил для AI-агентов, которая позволяет продолжать долгие проекты без зависимости от истории конкретного чата и выбирать подходящую модель/среду для задачи.

## Основные направления

### Project Infrastructure

Версионируемый стандарт project memory, canonical stores, bootstrap, handoff и agent-runtime поведения.

Canonical entry point: `PROJECT_INFRASTRUCTURE.md`.

Текущий lifecycle: `Draft`.

Активные сценарии:

- G0 — GitHub Repository;
- L1 — Local Folder;
- G1 — GitHub + Google Drive;
- G2 — GitHub + Synced Local Folder.

### Model routing

Практические правила выбора модели/вендора/режима и обновляемый снимок текущего состояния моделей.

Canonical files:

- `AI_MODEL_ROUTING_MEMO.md`;
- `AI_MODEL_CURRENT_STATE.md`;
- `skills/model-router/SKILL.md`.

Этот поток имеет собственный цикл обновления. Версия Project Infrastructure не означает версию model-routing материалов.

## Ограничения и принципы

- Репозиторий приватный, пока пользователь явно не решит иначе.
- Не хранить secrets/credentials в project memory.
- Existing content и Git history сохраняются non-destructively.
- External/project UI/chat memory может помогать, но canonical state находится в репозитории.
- Новые infrastructure scenarios добавляются только после подтверждённого real-project gap; сначала предпочитается smallest compatible extension.

## Критерии успеха

- Fresh agent может восстановить проект и продолжить работу из `AGENTS.md` и project memory.
- Infrastructure scenarios проверяются dogfood/real pilots до перехода из Draft.
- Общие правила не дублируются по scenario files без необходимости.
- Model-routing материалы остаются практически применимыми и обновляются независимо от infrastructure-version cadence.

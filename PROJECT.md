# Проект ai-workflow

## Цель

`ai-workflow` — личная система организации работы с AI-агентами и AI-harnesses.

Репозиторий собирает, проверяет и поддерживает всё, что помогает делать такую работу более удобной, воспроизводимой и переносимой между агентами, моделями и средами: project infrastructure, model routing, reusable skills, product/harness-specific guidance, рабочие правила и заметки, выявленные ошибки и anti-patterns, результаты экспериментов и проверенные практики.

Project Infrastructure — важная, но не единственная часть этого проекта.

## Карта репозитория

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
- reusable skill: `skills/model-router/`.

### Skills

`skills/` — canonical home reusable agent skills и связанных helper files.

Актуальный перечень и правила размещения: `skills/README.md`.

Новый reusable skill по умолчанию получает собственный каталог `skills/<skill-name>/`; индекс обновляется вместе с добавлением/удалением/переименованием skill.

### Harness- и product-specific guidance

Материалы, завязанные на конкретный AI harness/product, хранятся в соответствующих тематических каталогах.

Текущая область:

- `claude-desktop/` — практики, инструкции, известные особенности и решения для Claude Desktop; индекс — `claude-desktop/README.md`.
- `codex-cloud/` — проверенные практики настройки, диагностики и cold-start Git/GitHub workflow для Codex Cloud; индекс и памятка — `codex-cloud/README.md`.

Новый top-level product/harness каталог создаётся только когда появляется реальный устойчивый набор материалов, а не заранее.

### Notes, rules, errors and experiments

Полезные заметки, рабочие правила, выявленные ошибки/anti-patterns, результаты экспериментов и lessons learned также входят в scope `ai-workflow`.

Их следует хранить рядом с тематической областью, к которой они относятся. Отдельная новая верхнеуровневая категория создаётся только когда накопился самостоятельный устойчивый класс материалов.

Правило или вывод, ставший достаточно общим и проверенным, может быть отдельно повышен до reusable skill, Project Infrastructure rule, model-routing rule или другой canonical guidance.

## Версионирование областей

Каталоги и направления репозитория не обязаны иметь общий release cycle.

Версия **Project Infrastructure** версионирует только сам infrastructure standard и явно связанные с ним managed materials. Она не является общей версией всего `ai-workflow`.

Model routing, skills, harness-specific guidance и другие области обновляются по мере необходимости; явные зависимости между ними документируются там, где они действительно существуют.

## Размещение новых материалов

Перед созданием нового файла или каталога:

1. определи, к какой существующей области относится материал;
2. проверь root `README.md` и локальный `README.md` соответствующей области, если он есть;
3. используй существующий canonical home вместо нового top-level каталога, когда это естественно;
4. при добавлении нового элемента в индексируемую область обнови её локальный README/index;
5. не превращай Project Infrastructure в контейнер для любого AI-related материала только потому, что он находится в этом же репозитории.

## Ограничения и принципы

- Репозиторий приватный, пока пользователь явно не решит иначе.
- Не хранить secrets/credentials в project memory или operational guidance.
- Existing content и Git history сохраняются non-destructively.
- External/project UI/chat memory может помогать, но canonical state проекта находится в репозитории.
- Новые infrastructure scenarios добавляются только после подтверждённого real-project gap; сначала предпочитается smallest compatible extension.
- Новые верхнеуровневые тематические области также создаются по реальной потребности, а не для симметрии структуры.

## Критерии успеха

- Fresh agent может восстановить состояние `ai-workflow` из `AGENTS.md` и project memory и найти нужную тематическую область без предыдущего чата.
- Пользователь и агент могут быстро найти существующий skill, harness-specific guide, model-routing материал или infrastructure rule и понять, куда положить новый материал.
- Infrastructure scenarios проверяются dogfood/real pilots до перехода из Draft.
- Reusable знания по возможности оформляются один раз в подходящем canonical месте, а не размножаются по чатам и проектам.
- Независимые области могут развиваться с собственной скоростью без искусственной общей версии.

# Задачи

## T-001 — Завершить G0 dogfood
Status: done

G0 runtime/project memory установлен в `maxvfk/ai-workflow`. Cold-start validation выполнена в разрешённом simulated-fresh mode только по installed runtime/project memory и repository metadata; проверка выявила и устранила недостающие temporary-work/branch-policy runtime hints.

Evidence: GitHub issue #12.

## T-002 — Независимый re-review стандарта
Status: todo

После dogfood перепроверить corrective/refactor изменения и только затем решать, какие audit issues можно закрыть.

Evidence: GitHub issues #1, #3–#11.

## T-003 — Первый real-project pilot
Status: active

Две реальные L1 brownfield-установки выполнены и проаудированы. Базовая структура сработала; corrective cross-project rule принят в 0.8.2. До завершения pilot нужно разобрать оставшиеся существенные замечания аудита и проверить дальнейшую миграцию одного проекта L1 → G2.

Evidence: GitHub issue #2.

## T-004 — Решить private-bootstrap strategy
Status: todo

После сокращения стандарта повторно оценить цену private repository: оставить authorized/offline bootstrap, сделать compact bundle или изменить visibility.

Evidence: GitHub issue #8.

## T-005 — Уточнить границу infrastructure и model routing
Status: todo

Решить, достаточно ли явной независимости версий/циклов обновления внутри одного repo или model-routing материалы стоит вынести отдельно.

Evidence: GitHub issue #11, пункт 2.

## T-006 — Пересмотреть default CLAUDE.md adapter позже
Status: todo

После стабилизации native `AGENTS.md` support у Claude решить, оставлять ли default `CLAUDE.md -> @AGENTS.md` или выполнить явную миграцию к AGENTS-only.

Evidence: GitHub issue #4.


## T-007 — Canonical-target-first tool routing
Status: done

По результату теста ChatGPT app/Work добавлено правило: сначала определить canonical store/target по project infrastructure, затем выбирать доступный identity-preserving tool/access path. G0/G1/G2 получили scenario-specific runtime consequences; установленный G0 runtime синхронизирован с правилом.

Evidence: Project Infrastructure 0.8.1.


## T-008 — Разобрать L1 audit
Status: active

По результатам двух L1 brownfield-установок последовательно закрыть подтверждённые пограничные дефекты без расширения scenario scope. Cross-project workspace/catalog/reference rule уже закрыт в 0.8.2; остальные пункты аудита рассматривать отдельно и принимать только после обсуждения.

Evidence: L1 audit 2026-09-20; GitHub issue #2.


## T-009 — Active-project workspace boundary
Status: done

Зафиксировано, что workspace может включать весь `PROJECTS/`, но это не объединяет проекты. Один проект остаётся active по умолчанию; `PROJECTS.md` используется как resolver, а остальные видимые проекты считаются read-only external sources, если пользователь явно не включил их в write-scope.

Evidence: Project Infrastructure 0.8.3.


## T-010 — External artifact reconciliation
Status: done

Зафиксировано, что пользователь, domain applications и локальные/delegated agents могут выполнять bounded artifact-only edits без обязательного обращения к основному оркестратору. Project memory может временно отставать; по явной команде выполняется bounded change-focused reconciliation без автоматического признания нового/более свежего файла canonical replacement.

Evidence: Project Infrastructure 0.8.4.

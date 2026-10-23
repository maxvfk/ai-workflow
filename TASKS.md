# Задачи

## T-001 — Завершить G0 dogfood
Status: done

G0 runtime/project memory установлен в `maxvfk/ai-workflow`. Cold-start validation выполнена в разрешённом simulated-fresh mode только по installed runtime/project memory и repository metadata; проверка выявила и устранила недостающие temporary-work/branch-policy runtime hints.

Evidence: GitHub issue #12.

## T-002 — Независимый re-review стандарта
Status: todo

После dogfood перепроверить corrective/refactor изменения и только затем решать, какие audit issues можно закрыть.

Evidence: GitHub issues #1, #3–#11; G2 adversarial review (Codex + проверка Claude): `_ai/research/2026-10-20-g2-adversarial-review.md`.

## T-003 — Первый real-project pilot
Status: active

Две реальные L1 brownfield-установки выполнены и проаудированы. Representative G2 pilot на `SP-LAB-GRANT` дал F-01…F-16; согласованные Packages A/B/C/D внедрены в 0.8.7–0.8.10 и PR #13 merged. Pilot продолжается follow-up материалами F-17…F-36, которые разбираются отдельно в T-018.

Evidence: GitHub issue #2; S-012.

## T-004 — Решить private-bootstrap strategy
Status: todo

После сокращения стандарта повторно оценить цену private repository: оставить authorized/offline bootstrap, сделать compact bundle или изменить visibility.

Evidence: GitHub issue #8.

## T-005 — Уточнить границу infrastructure и model routing
Status: done

Решено расширить identity `ai-workflow`: это общий personal knowledge/workflow repository по организации работы с AI-агентами и harnesses. Project Infrastructure, model routing, reusable skills, product-specific guidance и другие тематические области могут жить в одном repo и иметь независимые циклы обновления. Версия Project Infrastructure не является общей версией репозитория.

Evidence: PROJECT.md; repository-map update 2026-10-23.

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


## T-011 — G2 Project Registry profile
Status: done

Добавлен профиль для обслуживания личного `PROJECTS/` workspace. Рекомендуемый control repository: `maxvfk/projects-registry`, Project ID: `PROJECTS-REGISTRY`. GitHub хранит runtime/state; локально профиль владеет только `PROJECTS/PROJECTS.md`. Parent `AGENTS.md` в `PROJECTS/` запрещён, чтобы не влиять на runtime дочерних проектов.

Следующее практическое действие вне стандарта: создать private repository `maxvfk/projects-registry` и применить к нему профиль.

Evidence: Project Infrastructure 0.8.5.


## T-012 — G2 artifact-only fallback
Status: done

Добавлен локальный fallback для G2 без GitHub: bounded artifact work + `_LOCAL_AGENT_REPORT.md`, без локальной копии project memory. Registry profile исключён из автономного fallback.

Evidence: Project Infrastructure 0.8.6.


## T-013 — G2 control-plane-only fallback
Status: done

По результатам representative G2 pilot стандартизирован complementary fallback для агента с доступом к GitHub control plane без artifact root. Режим опционален и включается только при реальной потребности; project memory по умолчанию read-only, handoff идёт одним новым отчётом на задачу через `_ai/inbox/`, selected artifact-root texts могут предоставляться как provenance-aware read-only `_ai/snapshots/`, а внешний incoming artifact area создаётся только по запросу пользователя. Full reconciliation проверяет результат, premises и влияние на project state.

Evidence: Project Infrastructure 0.8.7; G2 pilot audit F-01, F-02, F-15.


## T-014 — Multi-project workspace hardening
Status: done

По G2 pilot audit реализован Package B. Для workspace с Project Registry child-проекты не пишут `PROJECTS.md` напрямую, а отправляют registry-owned GitHub Issue handoff, который реестр проверяет по authoritative child metadata. Для значимых cross-project dependencies durable identity остаётся `Project ID + source-relative path`; embedded relative links остаются navigation hints и reconciled boundedly только при реальной реструктуризации. Для single-project local sessions рекомендован active-project root; auto-loaded external-project instructions не активируют соседний проект и не расширяют write scope.

Evidence: Project Infrastructure 0.8.8; G2 pilot audit F-04, F-05, F-16.


## T-015 — G2 operational hardening
Status: done

По G2 pilot audit реализован Package C. Exact-content verified redundant/stale copies могут быть отделены от неизвестного competing state при intact/unambiguous canonical, но не удаляются автоматически. Artifact-only агент обязан оставить воспроизводимый handoff; при необходимости exact helper files сохраняются минимальным noncanonical payload в `_LOCAL_AGENT_HANDOFF/` до full reconciliation. Brownfield/migration hygiene проверяет только обоснованные inherited execution leftovers, а `_LOCAL_AGENT_REPORT.md` трактуется как scope-limited evidence из-за отсутствия у reporting agent GitHub control-plane context.

Evidence: Project Infrastructure 0.8.9; G2 pilot audit F-03, F-06, F-07, F-08.


## T-016 — G2 audit small clarifications
Status: done

Реализован Package D G2 pilot audit. Для новых Project IDs принят рекомендуемый uppercase ASCII hyphenated format без автоматического переименования существующих IDs. Project-owned bootstrap/runtime prose следует установленному Project-memory language, а stable infrastructure keys остаются в English forms. Cold-start validation явно маркирует метод `independent-agent`, `checklist/simulated-fresh`, `partial` или `not run`. Для escape-sensitive programmatic/API text writes добавлена persisted-result verification. F-12 закрыт без изменения стандарта как разовая environment-specific Git configuration issue.

Evidence: Project Infrastructure 0.8.10; G2 pilot audit F-09, F-10, F-11, F-12, F-14.

## T-017 — Рассмотреть правило для delegated executors
Status: todo

Предложение на рассмотрение по опыту реального G2-проекта (2026-10-20): delegated executor (в текущем примере Codex через `skills/codex-delegate/`) работает с копией в отдельной рабочей папке и не пишет напрямую в synchronized artifact root или control repository; перенос результата и project-memory update выполняет оркестратор после проверки.

Описание и открытые вопросы — `project-infrastructure/ROADMAP.md`, раздел «Delegated executors without access to canonical stores».

ID note: задача первоначально появилась параллельно как ещё один `T-013`; после merge PR #13 обнаружена коллизия с уже установленным `T-013 — G2 control-plane-only fallback`. Для дальнейших ссылок используется `T-017`.

Evidence: project-infrastructure/ROADMAP.md; S-009.

## T-018 — Разобрать G2 pilot follow-up F-17…F-36
Status: todo

Первый пакет G2 pilot F-01…F-16 уже разобран, реализован в Project Infrastructure 0.8.7–0.8.10 и merged через PR #13.

Продолжение:
- F-17…F-24 — `maxvfk/SP-Lab-Grant/_ai/research/infrastructure-pilot-findings-part2.md`;
- F-25…F-36 — PR #15 и `infrastructure-pilot-findings-part3.md`.

Разбирать findings последовательно/тематическими пакетами: принять, модифицировать, отклонить или признать уже закрытыми; стандарт менять только после явного решения.

Evidence: S-012; PR #15; maxvfk/SP-Lab-Grant.

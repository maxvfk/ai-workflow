# Источники и canonical artifacts

## S-001 — Project Infrastructure index
Storage: GitHub repository
Path: PROJECT_INFRASTRUCTURE.md
Canonical: yes
Modification: editable
Purpose: версия, lifecycle, scenario selection, bootstrap contract и canonical invocation prompts.

## S-002 — Common infrastructure rules
Storage: GitHub repository
Path: project-infrastructure/COMMON.md
Canonical: yes
Modification: editable
Purpose: общие project-memory/runtime/bootstrap/concurrency/cold-start правила.

## S-003 — G0 scenario
Storage: GitHub repository
Path: project-infrastructure/G0_GITHUB_REPOSITORY.md
Canonical: yes
Modification: editable
Purpose: GitHub-only canonical-store semantics и dogfood runtime.

## S-004 — Human repository entry point
Storage: GitHub repository
Path: README.md
Canonical: yes
Modification: editable
Purpose: краткая карта репозитория для человека.

## S-005 — Model routing memo
Storage: GitHub repository
Path: AI_MODEL_ROUTING_MEMO.md
Canonical: yes
Modification: editable
Purpose: устойчивые правила model routing.

## S-006 — Current model state
Storage: GitHub repository
Path: AI_MODEL_CURRENT_STATE.md
Canonical: yes
Modification: editable
Purpose: периодически обновляемый snapshot моделей, лимитов и практических рекомендаций.

## S-007 — Model-router skill
Storage: GitHub repository
Path: skills/model-router/SKILL.md
Canonical: yes
Modification: editable
Purpose: reusable agent skill для применения routing memo/current-state.

## S-008 — Review and audit tracker
Storage: GitHub Issues
Location: repository issues for maxvfk/ai-workflow
Canonical: yes
Modification: editable
Purpose: подробные review findings, независимая перепроверка и обсуждение unresolved infrastructure вопросов.

## S-009 — Codex-delegate skill
Storage: GitHub repository
Path: skills/codex-delegate/SKILL.md; helper: skills/codex-delegate/run-codex-task.sh
Canonical: yes
Modification: editable
Purpose: reusable skill для делегирования задач из Claude Code в OpenAI Codex через плагин openai-codex; практический источник для T-017.

## S-010 — Claude Desktop: Remote Control keepalive
Storage: GitHub repository
Path: claude-desktop/REMOTE_CONTROL_KEEPALIVE.md
Canonical: yes
Modification: editable
Purpose: проверенная схема «диспетчер + сторож», чтобы сессии Claude Desktop оставались доступны с телефона после перезапуска/обновления приложения.

## S-011 — Claude Desktop: ведение сессий
Storage: GitHub repository
Path: claude-desktop/SESSIONS.md
Canonical: yes
Modification: editable
Purpose: основная и дочерние сессии, fork vs child session, сжатие контекста, память Claude и reusable user-level guidance.

## S-012 — Материалы G2 pilot SP-LAB-GRANT
Storage: GitHub repositories / pull requests
Location:
- PR #13 в maxvfk/ai-workflow — часть 1, F-01…F-16; merged, принятые изменения реализованы в Project Infrastructure 0.8.7–0.8.10;
- maxvfk/SP-Lab-Grant/_ai/research/infrastructure-pilot-findings-part2.md — часть 2, F-17…F-24;
- PR #15 в maxvfk/ai-workflow — часть 3, F-25…F-36; open на момент регистрации;
- исходные/проверочные материалы — maxvfk/SP-Lab-Grant/_ai/research/infrastructure-pilot-findings*.md и memory-check-2026-10-23.md.
Canonical: yes (pilot evidence); изменения стандарта принимаются отдельно
Modification: source-dependent; merged history не переписывать, open review materials editable до завершения review
Purpose: наблюдения real-project G2 pilot и follow-up предложения к стандарту; разбор продолжения — T-018.

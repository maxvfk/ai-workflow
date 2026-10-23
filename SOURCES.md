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
Path: skills/codex-delegate/SKILL.md; скрипт запуска — skills/codex-delegate/run-codex-task.sh
Canonical: yes
Modification: editable (установка на второй машине — PR #14)
Purpose: делегирование задач из Claude Code в OpenAI Codex через плагин openai-codex: надёжный запуск на Windows, мониторинг, расход, проверка результата; связано с T-013.

## S-010 — Claude Desktop: Remote Control keepalive
Storage: GitHub repository
Path: claude-desktop/REMOTE_CONTROL_KEEPALIVE.md
Canonical: yes
Modification: editable
Purpose: схема «диспетчер + сторож», чтобы сессии Claude Desktop оставались доступны с телефона после перезапуска приложения для обновления (2026-10-22).

## S-011 — Claude Desktop: как вести сессии
Storage: GitHub repository
Path: claude-desktop/SESSIONS.md
Canonical: yes
Modification: editable
Purpose: основная и дочерние сессии, форк против дочерней, сжатие контекста, где живёт память Claude; готовый раздел для `~/.claude/CLAUDE.md` (2026-10-23, PR #16).

## S-012 — Отчёты пилота G2 на проекте SP-LAB-GRANT
Storage: GitHub pull requests (не слиты в `main`)
Location: PR #13 (части 1–2, F-01…F-24; `project-infrastructure/pilots/2026-09-G2-SP-LAB-GRANT.md` и др.), PR #15 (часть 3, F-25…F-36, 13 предложений к стандарту; `project-infrastructure/pilots/2026-10-G2-SP-LAB-GRANT-part3.md`); исходники — `maxvfk/SP-Lab-Grant`, `_ai/research/infrastructure-pilot-findings*.md`
Canonical: yes (отчёты пилота); правки стандарта по ним — отдельно (T-014)
Modification: editable до слияния
Purpose: наблюдения реального G2-пилота и предложения к стандарту.


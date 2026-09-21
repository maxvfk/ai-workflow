# Project infrastructure manifest

Scenario: G0
Project-memory profile: Standard
Project-memory language: ru
Agent namespace: _ai/

GitHub repository: maxvfk/ai-workflow
GitHub default branch: main

Standard source: maxvfk/ai-workflow (self-hosted dogfood)
Standard version: 0.8.5
Standard lifecycle: Draft
Standard commit/ref: 6c58cb309ca5cc53317442a5cb4cd254d2369c2a
Initialized: 2026-09-19
Last infrastructure update: 2026-09-21
Runtime entry point: ../../AGENTS.md
Local standard snapshot: ./standard/

Notes:
- This repository is both the project being managed and the source repository of the Project Infrastructure standard.
- The installed snapshot below this manifest records the exact applied COMMON + G0 specification and is not loaded during ordinary runtime.
- Machine-specific clone paths and transient connector/tool capabilities are intentionally not recorded here.

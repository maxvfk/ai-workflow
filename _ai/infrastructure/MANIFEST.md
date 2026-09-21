# Project infrastructure manifest

Scenario: G0
Project-memory profile: Standard
Project-memory language: ru
Agent namespace: _ai/

GitHub repository: maxvfk/ai-workflow
GitHub default branch: main

Standard source: maxvfk/ai-workflow (self-hosted dogfood)
Standard version: 0.8.4
Standard lifecycle: Draft
Standard commit/ref: c9c9a46577d9828d4728bc3b98d6b9620e27d1c7
Initialized: 2026-09-19
Last infrastructure update: 2026-09-21
Runtime entry point: ../../AGENTS.md
Local standard snapshot: ./standard/

Notes:
- This repository is both the project being managed and the source repository of the Project Infrastructure standard.
- The installed snapshot below this manifest records the exact applied COMMON + G0 specification and is not loaded during ordinary runtime.
- Machine-specific clone paths and transient connector/tool capabilities are intentionally not recorded here.

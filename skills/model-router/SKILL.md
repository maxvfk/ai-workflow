---
name: model-router
description: Choose the best AI workflow, vendor, product surface, model, and reasoning effort for a concrete task using the user's ChatGPT Plus and Claude Pro subscriptions, current model-state snapshot, fresh delta checks, and task-relevant benchmark evidence.
---

# Model Router

Use this skill when the user asks which AI model, vendor, environment, or reasoning effort should be used for a task, or asks for the most efficient AI workflow across ChatGPT and Claude.

## Persistent context

Before making a recommendation, read the repository root files:

- `AI_MODEL_ROUTING_MEMO.md` — stable routing principles.
- `AI_MODEL_CURRENT_STATE.md` — latest maintained snapshot of models, subscription constraints, benchmarks, and practical recommendations.

Subscription assumptions unless the user explicitly says otherwise:

- ChatGPT Plus.
- Claude Pro, approximately $20/month.
- Treat Fable as a last-resort option because of its unfavorable usage/credit economics on Claude Pro; recommend it only when the expected quality gain clearly justifies the extra cost.

## Freshness rule

Read the `Last updated` date in `AI_MODEL_CURRENT_STATE.md`.

For an important or non-obvious routing decision, perform a short delta-check for developments since that date. Focus only on information that could materially change the recommendation, especially:

- model releases, replacements, or rollouts;
- availability on ChatGPT Plus or Claude Pro;
- usage limits, allowances, credits, and pricing;
- reasoning/effort options and behavior;
- changes to Work, Cowork, Codex, Claude Code, agentic or computer-use capabilities;
- new high-quality independent benchmarks, task-oriented evals, or direct A/B comparisons relevant to the task.

Prefer official vendor documentation for availability, limits, pricing, and product behavior. Prefer independent reproducible evaluations for capability comparisons. Use community reports as supporting practical evidence, not as the sole basis for an important recommendation.

Do not repeat a full market survey if the maintained snapshot is recent and only a narrow delta-check is needed.

## Routing procedure

### 1. Characterize the task

Estimate the task along these dimensions:

- reasoning depth;
- agentic horizon;
- required autonomy;
- context size and heterogeneity;
- verification burden;
- cost of an unnoticed error;
- tool and data-location fit;
- coding intensity;
- research/source-verification intensity;
- long-context synthesis requirements;
- computer-use requirements;
- expected usage/credit cost.

### 2. Choose the product surface before the model

Consider the whole workflow, not just model intelligence.

Typical surfaces include:

- ordinary ChatGPT Chat or Claude Chat for discussion, planning, isolated difficult reasoning, and prompt/goal design;
- ChatGPT Work or Claude Cowork for long autonomous multi-file/tool/research workflows;
- Codex or Claude Code when repository, terminal, git, tests, scripts, or code-centric execution dominate.

Do not spend expensive agentic allowance on work that can be solved efficiently in an ordinary chat.

### 3. Choose vendor and model

Compare ChatGPT/OpenAI and Claude/Anthropic based on the capabilities actually needed by the task.

Do not choose a model from a single overall leaderboard score. Match evidence to the task. Examples:

- coding benchmarks are strong evidence for coding tasks but weak evidence for scientific literature auditing;
- math benchmarks support formal reasoning claims but not browser/tool reliability;
- long-context recall does not by itself prove strong synthesis;
- browser benchmarks do not by themselves establish factuality or low hallucination rates.

### 4. Choose effort

Use the lowest effort level that is likely to solve the task reliably.

- Low: the procedure is mostly known and difficult reasoning is limited.
- Medium: default for serious autonomous work with substantial analysis and intermediate decisions.
- High: use when difficult reasoning is itself the main bottleneck, such as ambiguous physical/mathematical interpretation, hard debugging, or very costly errors.

Higher effort does not automatically mean a better result and may consume substantially more allowance.

For long-running Work/Cowork/agentic sessions, prefer choosing the appropriate effort before starting. Avoid recommending frequent effort changes inside an already large session unless there is strong current evidence that the product handles such changes efficiently and without adverse context/cache costs.

### 5. Consider cross-vendor verification

For important scientific, engineering, research, or high-cost decisions, consider using a second vendor for an independent adversarial review rather than merely increasing effort on the same model.

The reviewer should be instructed not to assume the first model's conclusions are correct and to search for missed errors, unsupported claims, and alternative interpretations.

## Benchmark evidence hierarchy

When benchmark evidence matters, prefer roughly this order:

1. task-relevant independent reproducible benchmarks;
2. real task-oriented or long-horizon agentic evaluations;
3. fresh direct A/B comparisons under comparable conditions;
4. official vendor benchmarks;
5. community reports as supplementary evidence.

Weight relevance more heavily than headline ranking.

## Required response format

Keep the routing answer concise but decision-oriented. Include:

1. **Primary recommendation** — vendor, product surface, model, and effort.
2. **Why** — the 2–4 task characteristics that drive the decision.
3. **Best quality/usage alternative** — when meaningfully different from the primary choice.
4. **Maximum-quality option** — only when useful; explain the additional cost or limitation.
5. **Why not the main alternatives** — only the most plausible alternatives.
6. **Benchmark evidence** — mention only fresh, genuinely relevant evidence; distinguish official from independent evidence.
7. **Second-model review** — recommend one when it materially improves reliability.

If the task description is sufficiently clear, do not ask unnecessary clarification questions. State reasonable assumptions and proceed.

## Example invocation

`Используй model-router для этой задачи: [описание задачи]`

A shorter request such as `Выбери модель по model-router: [задача]` should be treated the same way when the skill is available.

# AI Model Current State

**Last updated:** 2026-09-26  
**Previous snapshot:** 2026-09-20  
**Scope:** OpenAI + Anthropic, optimized for **ChatGPT Plus** and **Claude Pro (~$20/month)**.  
**Policy:** Treat **Claude Fable 5/5.1** as a last-resort option on Claude Pro because Anthropic explicitly bills them from pay-as-you-go usage credits rather than the normal Pro usage pool.

> Weekly snapshot, not permanent truth. Before an important routing decision, run a short delta-check after `Last updated` and only for capabilities relevant to the task.

## Executive summary

This week **does materially change routing**.

### 1. Claude Opus 5.5 is now the strongest practical Claude Pro option

Anthropic released **Claude Opus 5.5 on 2026-09-22**. It is available in Claude for **Pro, Max, Team and Enterprise** users and supports the normal Claude effort selector. Anthropic says it performs at roughly Fable 5.1 level on most work while being cheaper to run than Opus 5.

Independent Artificial Analysis results are stronger than that conservative launch wording:
- **Opus 5.5 max: Intelligence Index 58**
- **Astra max: 53**
- **Fable 5.1 max: 53**
- Opus 5.5 also leads AA-Briefcase, GDPval-AA, SciCode, HLE and several other components, while reaching practical parity with Astra on AutomationBench-AA / Terminal-Bench 4 at max effort.

Cognition's **FrontierCode 1.1 Main** also currently shows:
- **Opus 5.5 medium: 54.6%**
- **GPT-6 Astra max: 53.3%**
- **Fable 5.1 medium: 50.9%**

This means the old recommendation **"Claude Pro → Opus 5"** should be replaced by **"Claude Pro → Opus 5.5"** for difficult included-plan work.

### 2. OpenAI released GPT-6 Sol and GPT-6 Luna for Work and Codex

On **2026-09-22**, OpenAI added **GPT-6 Sol** and **GPT-6 Luna** to ChatGPT Work and Codex. They are separate from regular Chat models.

For this user's Plus plan, that changes the efficiency side of the router:
- **Astra** remains the high-end agentic option.
- **GPT-6 Sol** becomes the preferred efficiency/capability compromise for serious Work/Codex tasks when Astra is unnecessary.
- **GPT-6 Luna** becomes the preferred high-throughput / low-cost model for focused, repetitive Work/Codex tasks.
- GPT-5.6 Sol/Terra/Luna remain available in Work/Codex, but GPT-6 Sol/Luna should usually be considered first for new tasks.

Independent Artificial Analysis finds GPT-6 Sol roughly flat with GPT-5.6 Sol in overall capability but about **half the API cost**, with some agentic gains and some regressions. This is an efficiency release more than a raw-intelligence jump.

### 3. Fable becomes even harder to justify on Claude Pro

Fable 5/5.1 remain explicitly **usage-credit models from the first request on Claude Pro**. With Opus 5.5 now available on Pro and competitive with or stronger than Fable 5.1 on many relevant evaluations, the practical need to pay extra for Fable shrinks further.

**Current default routing for this subscription mix:**
- hardest long-horizon autonomous task → **ChatGPT Work/Codex + Astra Medium**
- difficult Claude knowledge/coding task → **Claude + Opus 5.5 High** (or xhigh for long agentic work)
- serious but allowance-sensitive Work/Codex task → **GPT-6 Sol Medium/High**
- high-volume simple Work/Codex task → **GPT-6 Luna**
- difficult single reasoning problem in ordinary ChatGPT Plus → **GPT-5.6 Sol High**
- Fable 5.1 → only when there is a specific reason and extra credits are justified

## Changes since 2026-09-20

### Material changes

#### Claude Opus 5.5 launched

Released: **2026-09-22**

Availability:
- Claude Pro
- Claude Max
- Team
- Enterprise
- Claude API / major cloud platforms

Anthropic describes Opus 5.5 as its strongest Opus model and says it performs at Fable 5.1 level on most work.

API pricing:
- input: **$4 / 1M tokens**
- output: **$20 / 1M tokens**
- cache reads: **$0.20 / 1M tokens**
- Fast mode: **$8 / $40** input/output

Anthropic estimates typical token-billed workloads cost about **40% less than Opus 5** overall.

For Claude Pro routing, the important point is product access, not API price: **Opus 5.5 is available to Pro users**, while Fable 5/5.1 remain separately documented as credits-only on Pro.

#### GPT-6 Sol and GPT-6 Luna launched

Released: **2026-09-22**

Availability:
- ChatGPT **Work**
- **Codex**
- OpenAI API
- available to eligible Plus users in Work/Codex
- **not regular Chat models**

API pricing:
- GPT-6 Sol: **$2 input / $10 output** per 1M tokens
- GPT-6 Luna: **$0.10 input / $0.50 output** per 1M tokens

Both support reasoning effort from none/low through medium/high/xhigh/max in the API. Work/Codex exposes model/reasoning choices according to plan and rollout.

**Important allowance caveat:** OpenAI's Astra usage-estimate article still publishes the old five-hour table for Astra and GPT-5.6 models; it does **not yet publish comparable Plus local-message estimates for GPT-6 Sol/Luna**. Do not invent an allowance multiplier for them. Check Settings → Usage for actual plan consumption until OpenAI publishes equivalent guidance.

### No material change

- ChatGPT Plus still does **not** include GPT-6 Pro/Astra in normal Chat.
- Plus still includes Astra in Work/Codex.
- Fable 5 and 5.1 remain credits-only on Claude Pro.
- Claude effort levels remain Low / Medium / High / xhigh / Max on supported models.
- Thinking cannot be turned off for **Opus 5.5** or **Fable 5.1**.
- Claude Chat/Cowork unified experience continues its gradual Pro/Max rollout.

## Subscription context

### ChatGPT Plus

#### Regular Chat

Primary high-quality model remains:
- **GPT-5.6 Sol**

For a difficult one-shot reasoning/review task:
- **Sol High** remains the normal-chat recommendation.

GPT-6 Sol/Luna are **not regular Chat models**.

#### Work / Codex

Current relevant family:
- **GPT-6 Astra**
- **GPT-6 Sol**
- **GPT-6 Luna**
- GPT-5.6 Sol
- GPT-5.6 Terra
- GPT-5.6 Luna
- older models where still exposed

OpenAI still documents the following five-hour Plus estimates for the models in its Astra usage table:

| Model | Estimated local messages / 5h |
|---|---:|
| GPT-6 Astra | 5-45 |
| GPT-5.6 Sol | 10-100 |
| GPT-5.6 Terra | 25-200 |
| GPT-5.6 Luna | 250-2,000 |

These are **not fixed message caps**. Weekly limits may also apply.

**GPT-6 Sol/Luna:** no directly comparable Plus five-hour estimates were found in the current official usage table as of 2026-09-26.

### Claude Pro (~$20/month)

- Price remains **$20/month in the US**.
- Includes Claude Code and the unified Claude/Cowork experience as rollout reaches the account.
- **Opus 5.5 is available on Pro**.
- **Sonnet 5** remains a lower-cost / higher-throughput option.
- **Fable 5 and Fable 5.1 are explicitly not part of the normal Pro allowance and consume pay-as-you-go usage credits from the start.**
- API usage is separate from the Pro subscription.

Current practical interpretation:
- strongest normal Claude Pro path → **Opus 5.5**
- efficient sustained path → **Sonnet 5**
- paid specialist frontier path → **Fable 5.1**, only when justified

## Current model landscape

### OpenAI

#### GPT-6 Astra

Best fit:
- hardest end-to-end autonomous work
- long-horizon research
- complex multi-tool execution
- hardest repository work
- computer/browser use
- high-error-cost artifact production

Default: **Astra Medium**

Use High/xhigh/max only when deep reasoning or verification is actually the bottleneck.

#### GPT-6 Sol

Best fit:
- serious Work/Codex tasks where Astra is unnecessary
- agentic coding with better efficiency
- sustained long tasks where allowance matters
- intermediate planner/executor roles
- broad everyday agentic work

Artificial Analysis:
- max Intelligence Index: **48**
- roughly level with GPT-5.6 Sol overall
- much lower API cost
- somewhat better AutomationBench-AA / Terminal-Bench 4 than GPT-5.6 Sol, with regressions on some other evaluations

**New default efficiency choice in OpenAI Work/Codex: GPT-6 Sol Medium/High.**

#### GPT-6 Luna

Best fit:
- high-volume focused tasks
- extraction / classification
- repetitive transformations
- inexpensive agentic execution
- batch-like workflow steps

Use it when task complexity is modest and throughput dominates.

#### GPT-5.6 Sol

Still important because it remains the high-quality model available in **ordinary ChatGPT Plus Chat**.

Best fit:
- one difficult reasoning node
- scientific/engineering discussion
- preflight before Work
- independent review without consuming Work/Codex allowance

#### GPT-5.6 Terra / Luna

Remain usable in Work/Codex, but the new GPT-6 Sol/Luna releases reduce how often they should be the first choice. Keep them as fallback options where the product UI, allowance behavior, or specific task economics favor them.

### Anthropic

#### Claude Opus 5.5

**New primary Claude Pro recommendation.**

Best fit:
- difficult knowledge work
- scientific / technical reasoning
- demanding coding
- long-context analysis
- long-running agents
- independent review of OpenAI work
- high-error-cost professional tasks

Independent Artificial Analysis:
- Intelligence Index max: **58**
- AA-Briefcase v1.1: **1822**
- GDPval-AA v2.1: **1846**
- AutomationBench-AA: **70%**
- Terminal-Bench 4.0: **~60%**
- SciCode: **~67%**
- Humanity's Last Exam: **~61%**

At high effort, Opus 5.5 scores **54** on the AA Intelligence Index, already around / above Astra max on that aggregate while using much less reasoning than its own max mode.

Recommended practical starting points:
- **High** for difficult normal work
- **xhigh** for long agentic/coding work
- **Max** only for correctness-critical cases where the extra token spend is justified

#### Claude Sonnet 5

Best fit:
- sustained everyday Claude work
- efficient coding
- routine-to-intermediate agentic work
- long sessions where Opus usage is unnecessary

#### Claude Fable 5.1

Still frontier-capable, but now **even less attractive on Claude Pro**:
- requires usage credits
- Opus 5.5 is available on Pro
- independent evals show Opus 5.5 matching or beating Fable 5.1 across many relevant tasks

Reserve Fable 5.1 for:
- a targeted second opinion where its specific strengths matter
- unresolved cross-model disagreement
- rare correctness-critical cases where direct spend is acceptable

## Reasoning / effort

### OpenAI

Stable rule:
- **Low:** straightforward execution / maximize allowance
- **Medium:** default serious agentic work
- **High:** reasoning-bound or verification-bound task
- **xhigh / max:** only for exceptional hard reasoning where exposed and justified

GPT-6 Sol/Luna support a broad reasoning-effort range; do not automatically increase effort because the task is long.

Operational rule remains:
**choose model and effort before a long agentic session; avoid switching mid-session without a concrete reason.**

### Anthropic

Supported effort levels:
- Low
- Medium
- High
- xhigh
- Max

Current guidance:
- Low/Medium → routine / efficient
- High → best general quality/speed balance
- xhigh → long-running coding / agentic work
- Max → deepest analysis, highest usage

Thinking:
- **Opus 5.5:** always on
- **Fable 5.1:** always on
- **Opus 5:** cannot be turned off in Claude; API behavior depends on effort

## Benchmark / eval evidence

### Artificial Analysis: Opus 5.5 vs Astra

Current max-effort comparison:

| Metric | Claude Opus 5.5 | GPT-6 Astra |
|---|---:|---:|
| Intelligence Index | **58** | 53 |
| AA-Briefcase v1.1 | **1822** | 1569 |
| GDPval-AA v2.1 | **1846** | 1542 |
| AutomationBench-AA | **70%** | 68% |
| Terminal-Bench 4.0 | **~60%** | 59% |
| SciCode | **67%** | 56% |
| Humanity's Last Exam | **61%** | 55% |
| GDP.pdf | 26% | **31%** |
| CritPt | 32% | 32% |
| AA-LCR v1.1 | **85%** | 81% |

Interpretation:
- Opus 5.5 is currently stronger on AA's broad knowledge/reasoning and agentic-knowledge mix.
- Astra remains very strong in execution-oriented and document/professional workflows and still has a strong long-horizon product/harness advantage through Work/Codex.
- These model-only / API-level results do **not** imply Claude is automatically better than Work/Codex as a complete product.

### Cognition FrontierCode 1.1

Current visible leaderboard:
- **Opus 5.5 medium: 54.6%**
- Fable 5 xhigh: 53.5%
- Opus 5 medium: 53.4%
- **GPT-6 Astra max: 53.3%**
- Fable 5.1 medium: 50.9%

This is especially relevant to mergeable software-engineering work. It strengthens Opus 5.5 as a serious Claude Code option.

### GPT-6 Sol efficiency evidence

Artificial Analysis:
- GPT-6 Sol max Intelligence Index: **48**
- GPT-5.6 Sol max: **47**
- cost per AA Intelligence task: about **$1.06 vs $1.99**
- GPT-6 Sol has lower API pricing and similar overall intelligence

Interpretation: GPT-6 Sol is mainly an **efficiency / price-performance upgrade**, not a new frontier peak.

### Android Bench 2.0

Keep the 2026-09-20 results as useful long-horizon evidence:
- Astra + Codex had the highest pass rate among the systems then reported.
- This benchmark is harness-sensitive and should not be treated as bare-model ranking.
- Re-check when Opus 5.5 / GPT-6 Sol results are added to the same benchmark version.

## Practical routing recommendations

### 1. Unknown task / preflight

**ChatGPT Chat → GPT-5.6 Sol High**

Use it to classify:
**environment → model → effort**

### 2. Hardest long autonomous research / artifact / cross-tool task

Default:
**ChatGPT Work → GPT-6 Astra Medium**

Reason:
- strongest integration with Work's multi-step environment
- good execution / automation profile
- avoids assuming bare-model benchmark leadership equals product-level superiority

### 3. Difficult Claude knowledge/reasoning task

Default:
**Claude → Opus 5.5 High**

For long coding/agentic work:
**Claude Code / unified Claude → Opus 5.5 xhigh**

This replaces the old Opus 5 recommendation.

### 4. Serious Work/Codex task with allowance pressure

Default:
**GPT-6 Sol Medium/High**

This replaces the old preference for GPT-5.6 Sol/Terra as the first efficiency alternative to Astra.

### 5. High-volume simple agentic task

Default:
**GPT-6 Luna**

If product availability or allowance behavior is unfavorable, fall back to the older Luna/Terra options.

### 6. Hard repository / software-engineering task

Primary candidates:
- **Codex + Astra Medium**
- **Claude Code + Opus 5.5 High/xhigh**

Current evidence is close enough that **tooling, repo access, session continuity and allowance economics should decide** rather than a universal coding winner.

FrontierCode currently slightly favors Opus 5.5 medium over Astra max, while Android Bench 2.0 previously favored Astra + Codex on long-horizon Android tasks.

### 7. Scientific / engineering work with high error cost

Recommended:
1. primary work with **Opus 5.5 High** or **Astra Medium**, based on tool needs
2. independent cross-vendor review with the other system
3. use **Fable 5.1 only if a material disagreement remains** and paying credits is justified

This is a meaningful update: for pure difficult reasoning / knowledge work, **Opus 5.5 now deserves equal or stronger consideration than Astra**, whereas Astra remains the safer default when the task is primarily long-horizon execution inside Work.

### 8. Fable policy

**Do not route to Fable by default.**

Use Fable 5.1 only when:
- a specific benchmark/task match favors it materially
- Opus 5.5 and Astra disagree
- the task is important enough to justify direct credits

Opus 5.5 significantly reduces the need for Fable on Claude Pro.

## Sources checked on 2026-09-26

### Official OpenAI
- https://help.openai.com/en/articles/6825453-chatgpt-release-notes
- https://help.openai.com/en/articles/20001275-chatgpt-work-and-codex
- https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex
- https://developers.openai.com/api/docs/changelog
- https://developers.openai.com/api/docs/models/gpt-6-sol
- https://developers.openai.com/api/docs/models/gpt-6-luna
- https://help.openai.com/en/articles/20001415-chatgpt-rate-card-enterprise-token-based-pricing

### Official Anthropic
- https://www.anthropic.com/claude-opus-5-5
- https://www.anthropic.com/claude/opus
- https://support.claude.com/en/articles/12138966-release-notes
- https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings
- https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan
- https://support.claude.com/en/articles/8606394-how-large-is-the-context-window-on-paid-claude-plans
- https://support.claude.com/en/articles/8325606-what-is-the-pro-plan

### Independent / task-oriented evidence
- https://artificialanalysis.ai/articles/claude-opus-5-5
- https://artificialanalysis.ai/models/comparisons/claude-opus-5-5-vs-gpt-6-astra
- https://artificialanalysis.ai/articles/gpt-6-sol-and-luna-push-the-cost-efficiency-frontier
- https://cognition.com/frontiercode
- https://developer.android.com/bench
- https://metr.org/blog/

## Uncertainties / re-check before important decisions

- OpenAI has not yet published GPT-6 Sol/Luna five-hour Plus estimates in the same usage table used for Astra / GPT-5.6; do not assume exact allowance ratios.
- Claude Pro limits are dynamic and task/context/tool dependent rather than a fixed message count.
- Anthropic states Opus 5.5 is available on Pro; account UI can still vary by rollout.
- Claude Chat/Cowork unification is gradual.
- Fable credit economics can change; verify before a large paid run.
- FrontierCode and Android Bench evaluate model+harness behavior and should not be treated as pure model rankings.
- Artificial Analysis results can change with methodology revisions and fallback configuration.
- Opus 5.5 is only a few days old; more long-horizon independent evidence is likely to appear soon.

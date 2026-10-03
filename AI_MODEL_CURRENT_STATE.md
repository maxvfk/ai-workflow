# AI Model Current State

**Last updated:** 2026-10-03  
**Previous snapshot:** 2026-09-26  
**Scope:** OpenAI + Anthropic, optimized for **ChatGPT Plus** and **Claude Pro (~$20/month)**.  
**Policy:** Treat **Claude Fable 5/5.1** as a last-resort option on Claude Pro because Anthropic explicitly bills them from pay-as-you-go usage credits rather than the normal Pro usage pool.

> Weekly snapshot, not permanent truth. Before an important routing decision, run a short delta-check after `Last updated` and only for capabilities relevant to the task.

## Executive summary

This week **materially changes the efficiency/default routing on both vendors**, while leaving the top-end agentic recommendation broadly intact.

### OpenAI: GPT-6.1 Sol replaces GPT-6 Sol as the default efficiency model in Work/Codex

OpenAI released **GPT-6.1 Sol on 2026-09-29** and is rolling it out to eligible paid plans, including Plus. It is available in **ChatGPT Work and Codex**, not regular Chat.

Official positioning:
- improves over GPT-6 Sol in agentic coding, computer use, and professional work;
- capability is described as comparable to GPT-6 Astra at much lower cost;
- standard API price remains **$2 input / $10 output per 1M tokens**;
- cached input falls to **$0.10 / 1M**, half GPT-6 Sol's cache price.

Independent Artificial Analysis:
- **GPT-6.1 Sol max: Intelligence Index 52**
- **GPT-6 Sol max: 48**
- GPT-6.1 Sol improves AA-Briefcase, GDPval-AA, AutomationBench-AA, Terminal-Bench 4.0, HLE and Omniscience, with some regressions such as SciCode and a tiny LCR drop.
- cost per AA Intelligence task is about **$0.72 vs $1.04** for GPT-6 Sol.

**Routing consequence:** for serious Work/Codex tasks where Astra is unnecessary, **GPT-6.1 Sol Medium/High becomes the new default efficiency/capability choice**, replacing GPT-6 Sol.

### OpenAI Plus usage guidance is now much clearer

OpenAI now publishes Plus five-hour estimates for the full current Work/Codex family:

| Model | Estimated local messages / 5h |
|---|---:|
| GPT-6 Astra | 5–45 |
| GPT-6.1 Sol | **15–160** |
| GPT-6 Sol | 15–150 |
| GPT-6 Luna | **350–3,000** |

Weekly limits may also apply. These are estimates, not fixed caps, and cloud tasks can consume more allowance than local messages.

This confirms that GPT-6.1 Sol is not just cheaper in API terms; on Plus it also provides a much larger expected Work/Codex throughput than Astra.

### Anthropic: Claude Sonnet 5.5 becomes the new efficiency/default Claude model

Anthropic released **Claude Sonnet 5.5 on 2026-09-28**.

Official positioning:
- clear upgrade over Sonnet 5;
- 30%+ faster;
- up to 30% cheaper per task in Anthropic's testing;
- strongest at well-scoped everyday work, fixing bugs, polished documents/slides/spreadsheets and iterative coding;
- default Claude-app effort remains **Medium**.

Independent Artificial Analysis:
- **Sonnet 5.5 max: Intelligence Index 56**
- **Sonnet 5.5 xhigh: 52**
- **Sonnet 5.5 high: 47**
- **Sonnet 5.5 medium: 41**
- at max, it reaches **64% Terminal-Bench 4.0**, **72% AutomationBench-AA**, and near-Opus scores on AA-Briefcase / GDPval-AA, but does so with very high token use.
- at high effort it is much cheaper and less verbose, so max is not the practical default.

**Routing consequence:** **Sonnet 5.5 replaces Sonnet 5** as the efficient/default Claude model. **Opus 5.5 remains the preferred Claude choice for complex open-ended judgment and high-error-cost work.**

### Fable policy is unchanged

On **Claude Pro**, Fable 5 and Fable 5.1 still run on **usage credits from the first request** and do not consume the normal included Pro usage pool.

With both **Opus 5.5** and **Sonnet 5.5** now available, Fable is even harder to justify for this subscription mix.

## Changes since 2026-09-26

### Material changes

#### GPT-6.1 Sol launch

Released: **2026-09-29**

Availability:
- ChatGPT Work
- Codex
- API
- rolling out to eligible paid plans, including Plus
- not available in regular Chat

Official API pricing:
- input: **$2 / 1M tokens**
- cached input: **$0.10 / 1M**
- output: **$10 / 1M**

Independent Artificial Analysis comparison vs GPT-6 Sol:

| Metric | GPT-6.1 Sol max | GPT-6 Sol max |
|---|---:|---:|
| Intelligence Index | **52** | 48 |
| AA-Briefcase v1.1 | **1564** | 1480 |
| GDPval-AA v2.1 | **1575** | 1509 |
| AutomationBench-AA | **65%** | 62% |
| Terminal-Bench 4.0 | **56%** | 44% |
| SciCode | 54% | **58%** |
| Humanity's Last Exam | **53%** | 48% |
| GDP.pdf | **31%** | 25% |
| CritPt | **32%** | 31% |
| AA-Omniscience | **42** | 27 |
| AA-LCR v1.1 | 83% | **84%** |
| Cost per AA task | **~$0.72** | ~$1.04 |

Interpretation:
- clear overall improvement over GPT-6 Sol;
- much stronger agentic/terminal profile;
- still not a universal replacement for Astra at the very top end;
- particularly attractive for Plus users because official usage estimates are now 15–160 local messages per five-hour window.

#### Claude Sonnet 5.5 launch

Released: **2026-09-28**

Anthropic positioning:
- faster, lower-cost complement to Opus 5.5;
- 30%+ faster than Sonnet 5;
- same list pricing as Sonnet 5 but fewer tokens per task in Anthropic testing;
- strong for well-scoped coding, bug fixing, docs/slides/spreadsheets and design polish.

API pricing:
- cache read: **$0.20 / 1M**
- input: **$2 / 1M**
- output: **$10 / 1M**

Artificial Analysis:
- max: **56 Intelligence Index**
- xhigh: **52**
- high: **47**
- medium: **41**
- low: **36**
- max Terminal-Bench 4.0: **64%**
- max AutomationBench-AA: **72%**
- max cost/task: **~$7.67**
- high cost/task: **~$1.12**

Practical interpretation:
- **High** is the better quality/usage setting for most serious work;
- **xhigh** for longer agentic/coding sessions;
- **Max** only when extra depth is worth the large token/time increase;
- Opus 5.5 still remains better for complex, open-ended work requiring sustained judgment.

### No material change

- **GPT-6 Astra** remains the top OpenAI model for hardest long-horizon Work/Codex tasks.
- **GPT-5.6 Sol** remains the strongest normal ChatGPT Plus reasoning option.
- **Claude Opus 5.5** remains the strongest practical included Claude Pro model for complex work.
- **Fable 5/5.1 remain credits-only on Pro.**
- Claude Pro remains **$20/month (US)**, with five-hour session limits plus a weekly usage limit.
- Claude effort levels remain Low / Medium / High / xhigh / Max on supported models.
- Sonnet 5.5, Opus 5.5 and Fable 5.1 support 1M-token context in paid Claude chat; exact product behavior still depends on surface and rollout.

## Subscription context

### ChatGPT Plus

#### Regular Chat

Primary high-quality reasoning model:
- **GPT-5.6 Sol**

Use:
- **Sol High** for difficult single-node reasoning, review, scientific/engineering discussion, or preflight planning.

GPT-6.1 Sol, GPT-6 Sol and GPT-6 Luna are **Work/Codex models**, not regular Chat models.

#### Work / Codex

Current relevant family:
- **GPT-6 Astra**
- **GPT-6.1 Sol**
- **GPT-6 Sol**
- **GPT-6 Luna**

Official Plus local-message estimates per five-hour window:

| Model | Plus estimate / 5h |
|---|---:|
| GPT-6 Astra | 5–45 |
| GPT-6.1 Sol | **15–160** |
| GPT-6 Sol | 15–150 |
| GPT-6 Luna | **350–3,000** |

Notes:
- Work and Codex share the plan's relevant usage allowance.
- Weekly limits may also apply.
- Cloud tasks may use more allowance than local messages.
- exact consumption depends on task length, model, effort, tool use and output size.
- check **Settings → Usage** for current personal allowance and reset times.

### Claude Pro (~$20/month)

- Pro remains **$20/month in the US**.
- Includes Claude Code.
- Includes longer multi-step tasks and the unified Claude/Cowork experience where rollout is available.
- Session usage resets every **five hours**.
- Pro also has a **weekly usage limit** across models.
- Usage varies by context length, files, tools, model and effort.
- users can enable usage credits after included limits are exhausted.
- API usage is separate from the Pro subscription.

Current practical model hierarchy:
- strongest included model → **Opus 5.5**
- efficient/default model → **Sonnet 5.5**
- credits-only specialist → **Fable 5.1**

## Current model landscape

### OpenAI

#### GPT-6 Astra

Best fit:
- hardest long-horizon autonomous work
- multi-tool research / execution
- complex repository tasks
- computer/browser use
- finished artifacts
- high-error-cost professional workflows

Practical default:
- **Astra Medium**

Use High only when reasoning/verification itself is the bottleneck.

#### GPT-6.1 Sol

**New default efficiency/capability model for serious Work/Codex tasks.**

Best fit:
- serious coding/repository work below Astra difficulty
- computer use
- professional knowledge work
- sustained agentic execution
- allowance-sensitive long tasks
- planner/executor roles

Practical default:
- **Medium** for most serious work
- **High** where deeper reasoning materially matters

Why it now beats GPT-6 Sol in routing:
- stronger independent benchmark profile
- same input/output API list price
- cheaper cache
- slightly better official Plus five-hour throughput estimate

#### GPT-6 Sol

Still useful where available, but usually superseded by GPT-6.1 Sol for new tasks.

#### GPT-6 Luna

Best fit:
- high-volume simple workflows
- extraction/classification
- repetitive transformations
- cheap agentic execution
- batch-like steps

Official Plus estimate of **350–3,000 local messages / 5h** makes it the clear throughput choice when task complexity is low.

#### GPT-5.6 Sol

Still important because it is available in ordinary ChatGPT Plus Chat.

Best fit:
- difficult one-shot reasoning
- scientific/engineering discussion
- preflight/routing
- independent review that should not consume Work/Codex allowance

### Anthropic

#### Claude Opus 5.5

Primary Claude Pro choice for:
- difficult knowledge work
- complex judgment
- demanding coding
- scientific/technical reasoning
- long-context synthesis
- high-error-cost review
- open-ended tasks requiring sustained judgment

Practical default:
- **High** for difficult normal work
- **xhigh** for long agentic/coding work
- **Max** only when the extra token/time cost is justified

#### Claude Sonnet 5.5

**New efficient/default Claude model.**

Best fit:
- well-scoped everyday work
- iterative coding
- bug fixes
- polished docs/slides/spreadsheets
- design/UI refinement
- sustained sessions where Opus is unnecessary

Practical default:
- **Medium** for routine work
- **High** for serious work
- **xhigh** for long agentic/coding tasks
- avoid Max by default because token/time cost rises dramatically

#### Claude Fable 5.1

Still frontier-capable, but for this user remains a **last resort** because:
- on Pro it uses usage credits from the first request;
- Opus 5.5 is available inside the subscription;
- Sonnet 5.5 now covers much of the efficiency/coding space extremely well.

Use only for:
- targeted second opinion
- unresolved model disagreement
- rare correctness-critical tasks where direct spend is acceptable

## Reasoning / effort

### OpenAI

Stable practical rule:
- **Low:** straightforward execution / maximize allowance
- **Medium:** default serious agentic work
- **High:** reasoning- or verification-bound tasks
- higher settings where exposed: only for exceptional cases

Operational rule:
**choose model and effort before a long agentic session and avoid changing effort mid-run without a concrete reason.**

For a difficult subproblem inside a long Work session, it is often better to solve/review that node separately with Sol High or the other vendor rather than increasing effort for the whole run.

### Anthropic

Supported effort levels on current 5.5 models:
- Low
- Medium
- High
- xhigh
- Max

Practical guidance:
- Low / Medium → routine and allowance-efficient
- High → best general quality/speed balance
- xhigh → long-running coding / agentic work
- Max → deepest analysis, highest usage

Thinking:
- Sonnet 5.5, Opus 5.5 and Fable 5.1 have thinking enabled in Claude.
- Opus 5.5 and Fable 5.1 have thinking always on at every API effort level.
- Sonnet 5.5 can use API-specific `between_tools` behavior when upfront thinking is disabled.

## Benchmark / eval evidence

### GPT-6.1 Sol vs GPT-6 Sol — Artificial Analysis

The current same-methodology comparison clearly favors GPT-6.1 Sol overall:
- 52 vs 48 Intelligence Index
- 56% vs 44% Terminal-Bench 4.0
- 65% vs 62% AutomationBench-AA
- ~$0.72 vs ~$1.04 cost per Intelligence task

This makes GPT-6.1 Sol the preferred serious efficiency model in OpenAI Work/Codex.

### Claude Sonnet 5.5 — Artificial Analysis

Current effort scaling:

| Effort | Intelligence Index | Cost / AA task |
|---|---:|---:|
| Medium | 41 | ~$0.59 |
| High | 47 | ~$1.12 |
| xhigh | 52 | ~$2.75 |
| Max | 56 | ~$7.67 |

At max:
- Terminal-Bench 4.0: **64%**
- AutomationBench-AA: **72%**
- AA-Briefcase: **~1824**
- GDPval-AA: **~1840**

Interpretation:
- Sonnet 5.5 can approach Opus-class benchmark performance at Max;
- however Max uses extremely large reasoning/output budgets and is not the default quality/usage setting;
- High/xhigh are the more practical operating points.

### Sonnet 5.5 vs Opus 5.5

Anthropic and independent evidence converge on:
- Sonnet 5.5: faster, cheaper, excellent for well-scoped work and iterative coding
- Opus 5.5: stronger for complex, open-ended tasks requiring sustained judgment

Do not route by model tier name alone; task shape matters.

### Android Bench / FrontierCode / long-horizon evidence

Previous snapshots remain relevant:
- Android Bench 2.0 favored Astra + Codex on the then-published long-horizon set.
- FrontierCode showed Opus 5.5 highly competitive with Astra.
- These benchmarks evaluate **model + harness**, not bare model only.

Re-check same-version results when GPT-6.1 Sol and Sonnet 5.5 appear broadly in the relevant long-horizon suites.

## Practical routing recommendations

### 1. Unknown task / routing preflight

**ChatGPT Chat → GPT-5.6 Sol High**

Use:
**environment → model → effort**

### 2. Hardest autonomous research / artifact / cross-tool task

Default:
**ChatGPT Work → GPT-6 Astra Medium**

Astra remains the preferred top-end choice when the task is primarily long-horizon execution, tool use, browser/computer use or artifact production.

### 3. Serious Work/Codex task with allowance pressure

**New default: GPT-6.1 Sol Medium/High**

This replaces GPT-6 Sol as the preferred efficiency/capability compromise.

### 4. High-volume simple agentic task

**GPT-6 Luna**

Use when throughput and allowance efficiency dominate.

### 5. Difficult Claude reasoning / knowledge task

Default:
**Claude → Opus 5.5 High**

For long coding/agentic work:
**Claude Code / unified Claude → Opus 5.5 xhigh**

### 6. Everyday / sustained Claude task

**New default: Claude Sonnet 5.5 Medium/High**

Use High for serious work; xhigh only when a long coding/agentic session needs deeper reasoning.

### 7. Hard repository / coding task

Primary candidates:
- **Codex + Astra Medium**
- **Codex + GPT-6.1 Sol Medium/High**
- **Claude Code + Opus 5.5 High/xhigh**
- **Claude Code + Sonnet 5.5 High/xhigh**

Choose based on:
- task difficulty
- repo/tool integration
- session continuity
- allowance pressure
- whether the task needs sustained judgment vs fast iterative implementation

### 8. Scientific / engineering work with high error cost

Recommended pattern:
1. primary work with **Opus 5.5 High** or **Astra Medium**, depending on tool/autonomy needs;
2. independent cross-vendor review with the other system;
3. use **Fable 5.1 only if a material disagreement remains** and paying credits is justified.

For a mostly reasoning-heavy scientific task, Opus 5.5 deserves at least equal consideration to Astra. For a tool-heavy autonomous workflow, Astra remains the safer first choice.

### 9. Fable policy

**Do not route to Fable by default.**

Use Fable 5.1 only when:
- a specific task/eval profile gives it a clear advantage;
- Astra and Opus 5.5 disagree materially;
- the decision value justifies direct usage credits.

## Sources checked on 2026-10-03

### Official OpenAI
- https://help.openai.com/en/articles/6825453-chatgpt-release-notes
- https://help.openai.com/en/articles/20001275-chatgpt-work-and-codex
- https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex
- https://developers.openai.com/api/docs/changelog
- https://deploymentsafety.openai.com/gpt-6-1-sol/respecting-auto-review
- https://help.openai.com/en/articles/20001415-chatgpt-rate-card-enterprise-token-based-pricing

### Official Anthropic
- https://www.anthropic.com/claude-sonnet-5-5
- https://www.anthropic.com/claude-opus-5-5
- https://support.claude.com/en/articles/12138966-release-notes
- https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings
- https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan
- https://support.claude.com/en/articles/8325606-what-is-the-pro-plan
- https://support.claude.com/en/articles/8606394-how-large-is-the-context-window-on-paid-claude-plans

### Independent / task-oriented evidence
- https://artificialanalysis.ai/models/gpt-6-1-sol
- https://artificialanalysis.ai/models/comparisons/gpt-6-1-sol-vs-gpt-6-sol
- https://artificialanalysis.ai/models/releases/claude-sonnet-5-5
- https://artificialanalysis.ai/articles/claude-sonnet-5-5
- https://cognition.com/frontiercode
- https://developer.android.com/bench

## Uncertainties / re-check before important decisions

- GPT-6.1 Sol is still rolling out across eligible paid plans; Plus access may depend on account rollout state.
- Work/Codex usage estimates are ranges, not fixed message caps; cloud tasks and high effort can consume substantially more allowance.
- Claude Pro usage is dynamic; session and weekly limits vary with context, files, tools and effort.
- Anthropic's 5.5 family is still new; more independent long-horizon data will likely arrive quickly.
- Artificial Analysis Max-effort scores can require extremely large token budgets and should not be read as a practical everyday default.
- FrontierCode and Android Bench are harness-sensitive.
- Fable credit economics can change; re-check before any large paid run.

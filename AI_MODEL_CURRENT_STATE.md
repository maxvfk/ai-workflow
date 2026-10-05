# AI Model Current State

**Last updated:** 2026-10-05  
**Previous snapshot:** 2026-10-03  
**Scope:** OpenAI + Anthropic, optimized for **ChatGPT Plus** and **Claude Pro (~$20/month)**.  
**Policy:** Treat **Claude Fable 5/5.1** as a last-resort option on Claude Pro because Anthropic bills them from pay-as-you-go usage credits rather than the normal Pro allowance.

> Weekly snapshot, not permanent truth. Before an important routing decision, run a short delta-check after `Last updated` and only for capabilities relevant to the task.

## Executive summary

**No material model or subscription-routing change since 2026-10-03.** The two changes from the previous full weekly cycle remain the important ones: **GPT-6.1 Sol** is now the main efficiency/capability model for serious ChatGPT Work/Codex tasks below Astra difficulty, and **Claude Sonnet 5.5** is the efficient/default Claude model while **Claude Opus 5.5** remains the stronger choice for difficult open-ended reasoning and judgment.

Fresh checks through **2026-10-05** confirm:

- **ChatGPT Plus:** GPT-6 Astra remains included in Work/Codex but not as GPT-6 Pro in regular Chat. Official Plus estimates remain Astra **5–45**, GPT-6.1 Sol **15–160**, GPT-6 Sol **15–150**, GPT-6 Luna **350–3,000** local messages per five-hour period; weekly limits may also apply.
- **GPT-6.1 Sol:** still the preferred serious efficiency model in Work/Codex. OpenAI's DevDay recap explicitly makes it available to Plus and positions it as near-Astra intelligence at one-fifth Astra's standard input/output API prices.
- **Regular ChatGPT Plus:** GPT-5.6 Sol remains the practical high-quality reasoning/preflight model; GPT-6.1 Sol is a Work/Codex model rather than the normal Chat replacement.
- **Claude Pro:** remains **$20/month in the US**, with a five-hour session-based usage limit and a weekly limit whose actual consumption depends on context, model, files, tools and effort.
- **Claude Opus 5.5:** remains the strongest practical included Claude Pro choice for difficult work.
- **Claude Sonnet 5.5:** remains the efficient/default Claude choice.
- **Claude Fable 5/5.1:** still **not included in normal Pro usage limits** and run on usage credits from the start. With Opus 5.5 and Sonnet 5.5 available, Fable remains a specialist / last-resort choice for this subscription mix.
- No announced **Fable 5.5** was found in official Anthropic release notes; current internet claims are leaks/rumors and are excluded from routing.

## Changes since 2026-10-03

### Material model / plan changes

**None found.** No new OpenAI or Anthropic model released in this two-day delta that changes the current Plus/Pro routing.

### Newly confirmed / clarified

#### OpenAI DevDay product context

OpenAI's current DevDay recap confirms several adjacent product changes, but they do **not** alter the Plus model recommendation:

- **GPT-6.1 Sol** is explicitly available to Plus, Pro, Business, Enterprise and Edu users as well as API users.
- **GPT-6 Astra Ultrafast** is a premium speed tier offering up to 8× faster generation in Codex, but in ChatGPT it is currently limited to **Pro 500 and Enterprise**, so it is irrelevant to the user's Plus routing.
- **GPT-6.1 Sol Ultrafast** is announced as coming soon; no Plus availability should be assumed.
- **dots**, OpenAI's always-on Astra-powered agents, are available on Pro / Business Premium / Enterprise rather than Plus. They are therefore useful ecosystem context but not a current Plus option.
- GPT-6.1 Sol also supports **multi-agent mode in beta in the Responses API**. This is relevant to future API/agent architecture, but it does not by itself change the ChatGPT Plus Work/Codex routing.

#### Claude context / allowance picture remains stable

Anthropic's current paid-plan documentation continues to list **1M-token context** for Sonnet 5.5 and Opus 5.5 in paid Claude Chat, Claude Code and Cowork. Automatic context management can summarize earlier material near the context limit when code execution is enabled.

Claude Pro still has both a five-hour session limit and a weekly limit. Usage credits can extend work beyond included limits, but API usage remains separate.

## Current subscription context

### ChatGPT Plus

#### Regular Chat

Primary difficult-reasoning option:
- **GPT-5.6 Sol High**

Best fit:
- difficult single reasoning nodes;
- scientific/engineering discussion;
- preflight before launching Work;
- independent review without consuming Work/Codex allowance.

GPT-6.1 Sol / GPT-6 Sol / GPT-6 Luna are Work/Codex models rather than normal Chat replacements.

#### Work / Codex

| Model | Official Plus estimate / 5h | Practical role |
|---|---:|---|
| GPT-6 Astra | 5–45 | hardest long-horizon autonomous work |
| GPT-6.1 Sol | **15–160** | serious default when Astra is unnecessary |
| GPT-6 Sol | 15–150 | mostly superseded by 6.1 Sol |
| GPT-6 Luna | **350–3,000** | high-volume simple execution |

These are approximate local-message ranges, not guaranteed caps. Cloud tasks can consume more allowance, and weekly limits may also apply. Check **Settings → Usage** for the account's current remaining allowance and reset time.

### Claude Pro (~$20/month)

- US price remains **$20/month**.
- Includes Claude Code and Cowork/unified Claude capabilities where available.
- Five-hour session-based usage limit plus weekly usage limit.
- Consumption varies with conversation length, attached files, model, effort and tool use.
- API usage is separate.
- Usage credits can extend eligible use beyond included limits.

Current hierarchy for this subscription:
- **Opus 5.5** → strongest included model for complex work;
- **Sonnet 5.5** → efficient/default model;
- **Fable 5.1** → credits-only specialist / last resort.

## Current model landscape

### OpenAI

#### GPT-6 Astra

Best fit:
- hardest end-to-end autonomous work;
- long-horizon research and execution;
- difficult repository work;
- browser/computer use;
- multi-tool workflows;
- high-error-cost artifact production.

**Practical default: Astra Medium.** Raise effort only when reasoning/verification, rather than execution length, is the bottleneck.

#### GPT-6.1 Sol

**Default serious efficiency/capability model for Work/Codex.**

Best fit:
- sustained coding/repository work below Astra difficulty;
- professional knowledge work;
- computer use;
- long agentic tasks where allowance matters;
- repeated workflows.

**Practical default: Medium; High when deeper reasoning materially matters.**

Independent Artificial Analysis from the previous snapshot remains the relevant same-methodology evidence: GPT-6.1 Sol max scored **52** on its Intelligence Index versus **48** for GPT-6 Sol, with particularly large improvement on Terminal-Bench 4.0 (**56% vs 44%**) and lower measured cost per Intelligence task.

#### GPT-6 Luna

Best fit:
- extraction/classification;
- repetitive transformations;
- inexpensive high-volume agentic execution;
- simple batch-like workflow steps.

#### GPT-5.6 Sol

Still important because it is available in ordinary ChatGPT Plus Chat. Prefer it for one hard reasoning/review node when Work autonomy is unnecessary.

### Anthropic

#### Claude Opus 5.5

Primary Claude Pro choice for:
- difficult knowledge work;
- complex judgment;
- demanding coding;
- scientific/technical reasoning;
- long-context synthesis;
- high-error-cost review;
- open-ended tasks requiring sustained judgment.

**Practical default: High** for difficult work; **xhigh** for long agentic/coding sessions; Max only when the extra usage is justified.

#### Claude Sonnet 5.5

Efficient/default Claude model for:
- well-scoped everyday work;
- iterative coding and bug fixing;
- documents/slides/spreadsheets;
- UI/design refinement;
- sustained sessions where Opus is unnecessary.

**Practical default: Medium for routine work, High for serious work, xhigh for long agentic/coding work.** Avoid Max by default because token/time use rises sharply.

Independent Artificial Analysis from the previous snapshot remains relevant: Sonnet 5.5 reaches **56** Intelligence Index at Max and **52** at xhigh, with strong Terminal-Bench / AutomationBench results, but Max uses unusually large token budgets. This supports High/xhigh rather than Max as the practical operating point.

#### Claude Fable 5.1

Keep as a **last resort on Claude Pro** because:
- it consumes pay-as-you-go usage credits from the start;
- Opus 5.5 is included in normal Pro usage and covers most difficult work;
- Sonnet 5.5 covers much of the efficient coding/agentic space.

Use Fable only for a targeted second opinion, unresolved frontier-model disagreement, or a rare correctness-critical task where direct spend is justified.

## Reasoning / effort

### OpenAI

Practical rule:
- **Low:** straightforward execution / maximize allowance;
- **Medium:** default serious agentic work;
- **High:** reasoning- or verification-bound tasks;
- higher settings where exposed: exceptional cases only.

Do not increase effort merely because a task is long. For one difficult subproblem inside a long Work session, a separate Sol High or cross-vendor review can be more efficient than increasing effort for the entire run.

### Anthropic

Current effort ladder on supported models:
- Low
- Medium
- High
- xhigh
- Max

Practical rule:
- Low/Medium → routine and allowance-efficient;
- High → general serious-work sweet spot;
- xhigh → long-running coding/agentic work;
- Max → deepest analysis with the highest usage.

## Benchmark / eval evidence to retain

### Artificial Analysis

Current routing-relevant same-methodology signals from the latest completed evaluations:
- **Opus 5.5 max:** Intelligence Index **58**;
- **Sonnet 5.5 max:** **56**, xhigh **52**;
- **GPT-6 Astra max:** **53**;
- **GPT-6.1 Sol max:** **52**.

Do not interpret this as a universal ranking: effort and token budgets differ substantially, and product/harness quality matters for Work, Codex and Claude Code.

### Task-oriented / agentic evidence

Retain the prior signals:
- **Android Bench 2.0** favored Astra + Codex on the then-published long-horizon Android task set;
- **FrontierCode** showed Opus 5.5 highly competitive with Astra for mergeable software-engineering work;
- Artificial Analysis Terminal-Bench / AutomationBench results show strong agentic performance from the 5.5 Claude family and GPT-6.1 Sol.

No newer same-version head-to-head result found in this delta-check is strong enough to change routing. Re-check when GPT-6.1 Sol / Sonnet 5.5 have broader representation in long-horizon suites.

## Practical routing recommendations

### 1. Unknown task / routing preflight

**ChatGPT Chat → GPT-5.6 Sol High**

Use the stable order:
**environment → model → effort**.

### 2. Hardest autonomous research / artifact / cross-tool task

**ChatGPT Work → GPT-6 Astra Medium**

Astra remains the preferred top-end option when the task is primarily long-horizon execution, browser/computer use, multi-tool work or finished artifact production.

### 3. Serious Work/Codex task with allowance pressure

**GPT-6.1 Sol Medium/High**

This remains the best Plus efficiency/capability compromise below Astra.

### 4. High-volume simple agentic task

**GPT-6 Luna**

### 5. Difficult Claude reasoning / knowledge task

**Claude → Opus 5.5 High**

For long coding/agentic work:
**Claude Code / unified Claude → Opus 5.5 xhigh**.

### 6. Everyday / sustained Claude task

**Claude Sonnet 5.5 Medium/High**

Use xhigh only when a long coding/agentic session actually benefits from deeper reasoning.

### 7. Hard repository / coding task

Primary candidates:
- **Codex + Astra Medium** for the hardest long-horizon execution;
- **Codex + GPT-6.1 Sol Medium/High** when allowance efficiency matters;
- **Claude Code + Opus 5.5 High/xhigh** for difficult judgment-heavy work;
- **Claude Code + Sonnet 5.5 High/xhigh** for efficient iterative implementation.

Choose based on repo/tool integration, session continuity, task shape and allowance pressure rather than assuming a universal coding winner.

### 8. Scientific / engineering work with high error cost

Recommended pattern:
1. primary work with **Opus 5.5 High** or **Astra Medium**, based on tool/autonomy needs;
2. independent cross-vendor review with the other system;
3. use **Fable 5.1 only if a material disagreement remains** and direct credits are justified.

For mostly reasoning-heavy scientific work, Opus 5.5 deserves at least equal consideration to Astra. For tool-heavy autonomous workflows, Astra remains the safer first choice.

### 9. Fable policy

**Do not route to Fable by default.**

Use Fable 5.1 only when a specific task/eval profile gives it a clear advantage, Astra and Opus 5.5 disagree materially, and the decision value justifies direct usage credits.

## Sources checked on 2026-10-05

### Official OpenAI
- https://openai.com/index/devday-2026-recap/
- https://openai.com/products/release-notes/
- https://help.openai.com/en/articles/20001275-chatgpt-work-and-codex
- https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex
- https://developers.openai.com/api/docs/changelog

### Official Anthropic
- https://support.claude.com/en/articles/12138966-release-notes
- https://support.claude.com/en/articles/8325606-what-is-the-pro-plan
- https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan
- https://support.claude.com/en/articles/8606394-how-large-is-the-context-window-on-paid-claude-plans
- https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings
- https://www.anthropic.com/claude-opus-5-5
- https://www.anthropic.com/claude-sonnet-5-5

### Independent / task-oriented evidence
- https://artificialanalysis.ai/models/gpt-6-1-sol
- https://artificialanalysis.ai/articles/claude-sonnet-5-5
- https://cognition.com/frontiercode
- https://developer.android.com/bench

## Uncertainties / re-check before important decisions

- Work/Codex usage figures are estimated ranges, not guaranteed message caps; cloud tasks and high effort can consume substantially more allowance.
- Claude Pro usage is dynamic; session and weekly limits depend on context, model, tools and task shape.
- Ultrafast is not currently a Plus feature; do not route around it unless plan availability changes.
- GPT-6.1 Sol multi-agent mode is currently an API beta signal, not a reason to assume identical orchestration in Plus Work/Codex.
- Fable 5.5 has not been officially announced as of this check; exclude leaks from current routing.
- Artificial Analysis Max-effort scores can involve very large token budgets and should not be treated as everyday operating points.
- FrontierCode and Android Bench are harness-sensitive; compare same benchmark versions and agent configurations when possible.

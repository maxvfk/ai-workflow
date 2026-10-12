# AI Model Current State

**Last updated:** 2026-10-12  
**Previous snapshot:** 2026-10-05  
**Scope:** OpenAI and Anthropic; practical routing for **ChatGPT Plus** and **Claude Pro (~$20/month US)**.  
**Cost policy:** **Claude Fable 5/5.1 = last resort** on Pro: usage credits are charged from the first request, outside normal Pro allowance.

> Weekly point-in-time snapshot, not a guarantee of account-specific access. Re-check the model picker, `Settings → Usage`, release notes, and costs before unusually expensive or consequential runs. Distinguish Chat, Work/Codex, Claude Chat/Code/Cowork, and API access.

## Executive summary

**Material changes since 2026-10-05:** (1) **GPT-6 Sol launched in regular ChatGPT** for Plus on 2026-10-07, with Intelligent UI, and becomes the preferred starting point for many difficult *conversational* tasks; (2) **Claude Haiku 5.5 launched** on 2026-10-07 and is a new lower-tier option for small, fast tasks and subagents. A fresh independent **Sonar evaluation** also strengthens the evidence favoring GPT-6.1 Sol over GPT-6 Sol in coding. The strongest Work/Codex and Claude long-running-work defaults **do not change**.

- **Regular ChatGPT Plus:** select **GPT-6 (Sol) Medium/High** as the initial choice; **GPT-5.6 Sol High** remains available as an independent A/B or fallback option. **Extra High and Pro are not included** on Plus. GPT-6 Chat is not the same deployed version as September GPT-6 Sol in Work/Codex.
- **Work/Codex on Plus:** **GPT-6 Astra Medium** for the hardest high-autonomy work; **GPT-6.1 Sol Medium/High** for serious tasks with allowance pressure; **GPT-6 Luna** for simple high-volume work.
- **Claude Pro:** **Opus 5.5 High/xhigh** for difficult judgment-heavy work, **Sonnet 5.5 Medium/High** as a strong efficient default, and **Haiku 5.5 Low/Medium** for simple fast tasks, compaction, classification or delegated narrow substeps when available.
- **Fable 5/5.1:** keep the existing *credits-only, last-resort* rule. No verified Fable 5.5 release as of this check.
- **No new free API credit for Claude Pro:** the announced monthly API credit is for Claude **Max and Team**, not Pro.

## Changes since 2026-10-05

### 2026-10-07 — GPT-6 in ordinary ChatGPT (material)

OpenAI began rolling out October GPT-6 with Intelligent UI in Chat, including **GPT-6 Sol** for paid plans. On **Plus** the usable GPT-6 effort settings are **Instant, Medium, High**; **Extra High and Pro are unavailable on Plus**. The separate **GPT-5.6 Sol** model selection remains available. Plus can use **GPT-6 Astra in Work/Codex**, but *not* GPT-6 Pro in ordinary Chat.

**Routing delta:** replace the old "GPT-5.6 Sol High is the only serious default for ordinary Chat" rule with **GPT-6 High first**, keeping GPT-5.6 Sol High as a second opinion. Prefer GPT-6 when Intelligent UI/structured interactive explanations add value. Avoid claiming proven superiority for every technical task: the Chat release has different deployment/training from September Work/Codex GPT-6 Sol, and most independent API benchmarks do not isolate that October Chat version.

Sources: https://openai.com/products/release-notes/ ; https://help.openai.com/en/articles/20001354-gpt-6-and-other-models-in-chatgpt ; https://deploymentsafety.openai.com/gpt-6-october/jailbreaks

### 2026-10-07 — Claude Haiku 5.5 (material for small tasks)

Anthropic launched **Haiku 5.5**, its first Haiku with adjustable reasoning effort. The model is available in Claude products and as `claude-haiku-5-5` on the API. **Use Low/Medium first** for fast, bounded tasks; reserve High/xhigh/Max for justified hard subproblems, rather than consuming more tokens by default.

Good candidates: summaries, search/extraction, classification, context compaction, database queries, quick computer-use steps and narrow coding subagents. **Do not automatically replace Sonnet 5.5** in substantive coding or long-horizon tasks; the Pro usage tradeoff depends on the actual account allowance and task shape.

**Context by interface:** official paid Claude context table lists Haiku 5.5 at **1M tokens in Chat and Claude Code**, and **500K in Cowork**. Context limit is not a promise that very long context is cost-free or perfectly recalled.

Official evidence: Anthropic reports **OSWorld 2.1 offline subset 72.4% vs GPT-6 Luna 48.9%**, **Terminal-Bench 4.0 39.2% vs 16.4%** and **FrontierCode 1.1 Main 46.4% vs 42.4%** at its published evaluation configuration. **These are vendor-run benchmarks**, not neutral product-harness A/B results.

Sources: https://www.anthropic.com/claude-haiku-5-5 ; https://support.claude.com/en/articles/12138966-release-notes ; https://support.claude.com/en/articles/8606394-how-large-is-the-context-window-on-paid-claude-plans

### 2026-10-09 — Independent Sonar GPT-6.1 Sol coding evaluation

Sonar's independent test on **544 HumanEval/MBPP tasks** with executable tests: **GPT-6.1 Sol 85.29%**, **GPT-6 Sol 83.09%** pass rate; Sonar's earlier Astra reference is **85.85%**. GPT-6.1 Sol generated **669,155 vs 480,125 lines** (+39.4%): issue *density* decreased, while absolute static-analysis findings rose **9,859 → 12,982** (+31.7%). This is a useful scoped signal, **not proof of better repository-scale agentic completion**. Keep testing/review gates.

Source: https://www.sonarsource.com/blog/openai-gpt-6-1-sol-evaluation/

### Economics clarification (not a routing reversal)

Anthropic reduced **Sonnet 5.5 API cache-read pricing** by **50%**, from $0.20 to $0.10 per million cache-read tokens; this may lower API/agent bills, but **does not automatically increase the Claude Pro subscription allowance**. Monthly Claude Platform API credits newly announced for **Max and Team**, **not Pro**. Fable 5/5.1 remain metered from the first request on Claude Pro.

Sources: https://www.anthropic.com/claude-haiku-5-5 ; https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan

## Subscription availability and usage

### ChatGPT Plus: Chat versus Work/Codex

**Regular Chat:** GPT-6 Sol **Instant, Medium, High**; no Extra High, no Pro. GPT-5.6 Sol is an independent legacy selection. For Plus, `Instant` does **not** silently promote itself to High on a complex query. Chat Thinking limits are dynamic; trust the model picker and in-account reset display, not a generic fixed-message estimate.

**Work and Codex:** share a separate included plan allowance. Plus may have both **five-hour and weekly** constraints. The official **approximate local-message** ranges per five-hour window are:

| Work/Codex model | Plus estimated local messages / 5h | Default role |
|---|---:|---|
| GPT-6 Astra | 5–45 | Hardest autonomous cross-tool tasks |
| GPT-6.1 Sol | 15–160 | Serious efficiency/capability default |
| GPT-6 Sol | 15–150 | Usually prefer 6.1 Sol |
| GPT-6 Luna | 350–3,000 | Simple, high-volume execution |

**Not guaranteed task/message caps.** Cloud runs, tool usage, context and effort may cost more. Plus may optionally purchase credits for extra eligible Work/Codex usage. **API billing is separate.** Astra and GPT-6.1 Sol **Ultrafast are not available on Plus**. Use `Settings → Usage` for remaining allowance and reset dates.

Sources: https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex ; https://help.openai.com/en/articles/20001275-chatgpt-work-and-codex ; https://help.openai.com/en/articles/20001354-gpt-6-and-other-models-in-chatgpt

### Claude Pro (~$20/month US)

Pro includes Claude Chat and Claude Code (and eligible unified Cowork features), but **not ordinary API usage**. It has **five-hour session resets plus an account-specific weekly limit shared across models**; tokens, tool calls, attachments, context, effort, model and product surface affect consumption. Usage credits can extend eligible use past included limits. Do not treat a request count as equivalent across Opus/Sonnet/Haiku.

| Claude model | On Pro | Suggested use |
|---|---|---|
| Opus 5.5 | Normal Pro allowance | Hard judgment, research, coding, review |
| Sonnet 5.5 | Normal Pro allowance | Efficient sustained day-to-day work |
| Haiku 5.5 | Available in Claude; normal model selection subject to rollout and limits | Narrow, fast and delegated work |
| Fable 5 / 5.1 | **Usage credits from first request** | Rare specialist, budget-approved escalation |

Official context: **Opus 5.5 and Sonnet 5.5: 1M** in paid Chat/Code/Cowork; **Haiku 5.5: 1M Chat/Code, 500K Cowork**. Automatic context management/compaction can apply. This is a context-window specification, not an allowance guarantee.

Sources: https://support.claude.com/en/articles/8325606-what-is-the-pro-plan ; https://support.claude.com/en/articles/8606394-how-large-is-the-context-window-on-paid-claude-plans ; https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan

## Reasoning and effort operating rules

**OpenAI regular Chat (Plus):** `GPT-6 Instant` for easy questions, `Medium` for normal complex work, `High` for difficult technical reasoning/long discussion. **No Extra High / Pro in Plus.** Select a level explicitly: requesting "think harder" in text does not ensure switching the level. The Work/Codex-specific model and effort selection is independent of this Chat picker.

**OpenAI Work/Codex:** `Medium` as the serious default for Astra and GPT-6.1 Sol; `High` when reasoning, verification or a hard subproblem is the bottleneck. Long task ≠ always High; higher effort may burn allowance before execution completes.

**Claude:** models support `Low`, `Medium`, `High`, `xhigh` (where offered), and `Max`. Start **Haiku Low/Medium**, **Sonnet Medium/High**, **Opus High**; try **xhigh** for meaningful long agentic/coding work; reserve **Max** for exceptional analysis with strong expected payoff. Higher effort can consume substantially more usage. **Thinking and effort are separate concepts; thinking cannot be disabled in Claude Chat on Haiku 5.5, Sonnet 5.5 or Opus 5.5.**

Source: https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings

## Relevant independent benchmarks and comparisons

**Artificial Analysis (independent, same evaluation methodology when comparing the listed configurations):**

| Comparison | Intelligence Index | Agentic / cost lesson |
|---|---|---|
| Haiku 5.5 **Max** vs GPT-6 Luna **Max** | **43 vs 38** | Terminal-Bench 4.0 **33% vs 13%**; Haiku output ~**162k vs 50k** tokens/task and cost **$0.21 vs $0.07** per index task |
| Haiku 5.5 **High** vs GPT-6 Luna **High** | **38 vs 33** | Terminal-Bench **22% vs 5%**; *AutomationBench-AA reverses* (**34% vs 48%**), so there is no universal winner |
| GPT-6 Sol **Medium** vs GPT-5.6 Sol **Medium** (API deployments) | **40 vs 39** | AutomationBench **58% vs 51%**, Terminal-Bench **19% vs 15%**; SciCode **54% vs 57%** |
| Earlier reference: Opus 5.5 Max / Sonnet 5.5 Max / Astra Max / GPT-6.1 Sol Max | **58 / 56 / 53 / 52** | Historical 2026-10-05 snapshot; effort, harness and token budget differ. Not a Plus subscription ranking |

At **Max**, Haiku 5.5 beats Luna on several intelligence and Terminal-Bench measures but loses to Luna in **AutomationBench (35% vs 53%)**. The enormous Max output budget means **avoid extrapolating Max scores to routine Pro Low/Medium work**. AA API GPT-6 comparisons are not direct tests of the new October ChatGPT GPT-6 deployment.

Sources: https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-luna ; https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-high-vs-gpt-6-luna-high ; https://artificialanalysis.ai/models/comparisons/gpt-6-sol-medium-vs-gpt-5-6-sol-medium

**Task-oriented / agentic carryover:** prior Android Bench 2.0 signal favored **Astra + Codex** on that published Android long-horizon harness; **FrontierCode** showed Opus 5.5 competitive with Astra on mergeable engineering tasks; Terminal-Bench and AutomationBench are useful complements, not interchangeable measures. **Harness, tool affordances, model version and token budget must match** before announcing a universal agent winner. No newly verified same-harness head-to-head compels replacing Astra/Opus/Sonnet for hard autonomous work.

References: https://developer.android.com/bench ; https://cognition.com/frontiercode ; https://www.sonarsource.com/blog/openai-gpt-6-1-sol-evaluation/

## Practical model routing — 2026-10-12

1. **Unknown problem / early technical discussion:** ordinary **ChatGPT GPT-6 Medium**, escalate to **High** if needed; **GPT-5.6 Sol High** is a valuable independent alternative. Decide **environment → model → effort**.
2. **Difficult scientific/engineering reasoning without autonomous tools:** **GPT-6 High** and/or **Claude Opus 5.5 High**. Use a cross-vendor check for critical conclusions; do not infer correctness from confident agreement alone.
3. **Hard autonomous Work task, complex artifact, browser/computer use:** **GPT-6 Astra Medium**; raise effort only if justified.
4. **Sustained coding/repository or Work with tight allowance:** **GPT-6.1 Sol Medium/High**; tests, CI and manual diff review are mandatory for consequential changes.
5. **Large volumes of simple Work/Codex actions:** **GPT-6 Luna**.
6. **Difficult Claude Code, judgment-heavy synthesis or review:** **Opus 5.5 High**; `xhigh` for complex long-running agents when necessary.
7. **Everyday Claude coding/iteration/artifact generation:** **Sonnet 5.5 Medium/High**; prefer this to Opus when capability is adequate.
8. **Small Claude tasks and subagents:** **Haiku 5.5 Low/Medium**, after checking it is selectable and evaluating output quality on the actual task.
9. **Disagreements on high-cost scientific or architectural decisions:** compare **Astra** vs **Opus** and a regular ChatGPT **GPT-6 High** review when useful. **Only then consider Fable 5.1** for a bounded paid second opinion, with explicit credit budget.

**Do not confuse lower API prices with higher subscription allowance.** Compare completion rate, elapsed time, allowance/credit use, tool calls, review/retry effort and actual artifact quality. Cross-vendor differences may come from Work/Codex/Claude Code harnesses rather than the base model alone.

## Sources checked / retained (2026-10-12)

**OpenAI official:**  
- https://openai.com/products/release-notes/  
- https://help.openai.com/en/articles/20001354-gpt-6-and-other-models-in-chatgpt  
- https://help.openai.com/en/articles/20001275-chatgpt-work-and-codex  
- https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex  
- https://deploymentsafety.openai.com/gpt-6-october/jailbreaks  

**Anthropic official:**  
- https://www.anthropic.com/claude-haiku-5-5  
- https://support.claude.com/en/articles/12138966-release-notes  
- https://support.claude.com/en/articles/8325606-what-is-the-pro-plan  
- https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan  
- https://support.claude.com/en/articles/8606394-how-large-is-the-context-window-on-paid-claude-plans  
- https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings  

**Independent and task-oriented:**  
- https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-luna  
- https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-high-vs-gpt-6-luna-high  
- https://artificialanalysis.ai/models/comparisons/gpt-6-sol-medium-vs-gpt-5-6-sol-medium  
- https://www.sonarsource.com/blog/openai-gpt-6-1-sol-evaluation/  
- https://cognition.com/frontiercode  
- https://developer.android.com/bench  

## What to re-check next

- October **GPT-6 Chat** on realistic scientific/research discussion versus explicitly selected **GPT-5.6 Sol**, preferably with independent same-interface tests rather than September API benchmarks.
- **Haiku 5.5 Low/Medium** output quality and *real Claude Pro allowance consumed* versus Sonnet Medium in repeatable narrow subagent tasks.
- New matched-harness long-horizon comparisons of **Astra, GPT-6.1 Sol, Opus 5.5, Sonnet 5.5** and improvements in tool reliability.
- Per-account Plus Work/Codex and Claude Pro usage reset and credit rules; whether any new model or feature changes plan eligibility.
- Fable policy only if Anthropic changes Pro inclusion/credit economics or independent task-level advantage becomes compelling; exclude leaks such as unannounced Fable 5.5.

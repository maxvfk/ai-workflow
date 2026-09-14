# AI Model Current State

**Last updated:** 2026-09-14  
**Previous snapshot:** 2026-09-10  
**Scope:** OpenAI + Anthropic, with routing optimized for **ChatGPT Plus** and **Claude Pro (~$20/month)**.  
**Policy:** Treat **Claude Fable 5/5.1** as a last-resort option on Claude Pro because they use pay-as-you-go usage credits from the start rather than the included Pro allowance.

> This is a weekly snapshot, not a permanent truth. Before an important routing decision, run a short delta-check for changes since `Last updated` and only for capabilities relevant to the current task.

## Executive summary

**No material change to the core routing recommendation since 2026-09-10.** For this subscription mix, the practical default frontier option for especially difficult long-horizon agentic work remains **GPT-6 Astra in ChatGPT Work/Codex**, because Astra is included within the limited Plus Work/Codex allowance, while **Claude Fable 5/5.1 is pay-as-you-go on Claude Pro**.

For demanding work that should stay inside the normal subscription allowance, the strongest practical Claude option remains **Claude Opus 5**; **Claude Sonnet 5** remains the better efficiency/default option for sustained Cowork and Claude Code sessions. In normal ChatGPT Plus Chat, **GPT-5.6 Sol High** remains the most useful high-quality reasoning/preflight option before consuming the separate Work/Codex allowance.

The main new evidence this week is task-oriented coding data from Cognition's **SWE-2** release and its new **Fusion** multi-model harness. Cognition's own FrontierCode/DeepSWE/Terminal-Bench runs continue to show **GPT-6 Astra and Claude Fable 5.1 at the frontier for agentic coding**, with Astra slightly ahead on FrontierCode and DeepSWE and substantially ahead on Terminal-Bench 4 in Cognition's table. Fusion also shows that harness design and multi-model planning/execution can preserve near-frontier coding performance while reducing cost. This is relevant architecturally, but it does **not** change the preferred ChatGPT Plus vs Claude Pro routing because Fusion/Devin is a separate product and allowance system.

## Changes since 2026-09-10

### Material changes

**None found in the core OpenAI/Anthropic subscription, model-access, or effort-routing picture.**

- ChatGPT Plus still includes **GPT-6 Astra in Work and Codex**, but not GPT-6 Pro/Astra in standard Chat.
- The published Plus Work/Codex five-hour estimates remain unchanged: Astra **5-45**, Sol **10-100**, Terra **25-200**, Luna **250-2,000** estimated local messages per five-hour period, with a separate weekly constraint where applicable.
- Claude Pro still treats **Fable 5 and Fable 5.1 as usage-credit models from the start**; they are not part of the normal Pro usage allowance.
- Claude effort controls remain **Low / Medium / High / xhigh / Max** where supported. Fable 5.1 and Opus 5 keep thinking enabled in Claude; Fable 5.1 thinking cannot be disabled.
- No newer OpenAI or Anthropic flagship model displaced Astra / Fable 5.1 / Opus 5 / Sonnet 5 during this check.

### New evidence / useful additions

1. **Cognition SWE-2 (released Sep 10)** published fresh task-oriented coding comparisons. In Cognition's own evaluation table:
   - FrontierCode 1.1 Main: Astra **53.3%**, Fable 5.1 **50.9%**, Sol **47.5%**.
   - DeepSWE 1.1: Astra **74.1%**, Sol **72.7%**, Fable 5.1 **67.4%**.
   - Terminal-Bench 4: Astra **57.9%**, Fable 5.1 **55.8%**, Sol **37.3%**.
   Treat these as useful task-oriented evidence, but not independent evidence: Cognition created SWE-2 and is reporting the comparison itself.

2. **Cognition Fusion** adds an important architectural signal: a frontier planner/reviewer paired with a cheaper executor can approach native Codex/Claude Code quality at lower inference cost. This strengthens the case for hierarchical multi-model workflows, but it is not directly applicable to the user's existing Plus/Pro allowance economics unless Devin/Fusion is separately adopted.

3. **OpenAI usage-page detail added to this snapshot:** eligible personal Plus/Pro accounts may be offered purchased instant Work/Codex resets depending on account and billing country. A purchased reset refreshes both the five-hour and weekly Work/Codex allowance and starts a new weekly period with the next Work/Codex request. This is a useful fallback, not a reason to route routine work to Astra unnecessarily.

4. **GPT-Live-1** launched in the OpenAI API during this interval, but it is a realtime voice model and does not materially affect this model-router's knowledge-work / coding / research recommendations.

## Subscription context

### ChatGPT Plus

- Standard Chat: **GPT-5.6 Sol** with Medium/High reasoning available; Sol High remains the strongest normal-chat preflight/review option on Plus.
- **GPT-6 Pro (Astra-powered) is not included in standard Chat on Plus.**
- ChatGPT Work and Codex on Plus include **GPT-6 Astra**, plus **GPT-5.6 Sol, Terra, and Luna**.
- Work and Codex share a separate included usage allowance. Both a five-hour window and a weekly limit may apply; allowance must remain in both.
- Current official estimated local messages per five-hour period for Plus:
  - Astra: **5-45**
  - Sol: **10-100**
  - Terra: **25-200**
  - Luna: **250-2,000**
- These are not fixed message caps. Larger inputs/outputs, higher reasoning settings, Fast mode, and multi-step tasks can consume allowance faster.
- OpenAI explicitly notes that **Astra Low can outperform Sol High** on some tasks; higher effort is not automatically better.
- Eligible personal accounts may be able to purchase an instant Work/Codex reset depending on country/account availability.

### Claude Pro (~$20/month)

- Pro includes Claude Chat, **Claude Code**, and **Claude Cowork**.
- **Claude Sonnet 5** is the efficient/default agentic model.
- **Claude Opus 5** remains the strongest model included in normal Claude Pro usage and the main high-quality Claude alternative for difficult work without extra Fable charges.
- Claude usage across supported products draws from the relevant subscription usage pool; long context, higher effort and tool-heavy sessions consume it faster.
- **Claude Fable 5 and Fable 5.1 are available on Pro only through pay-as-you-go usage credits from the start.**
- Fable 5.1 was never included in the earlier Fable 5 promotional allowance.
- Therefore, Fable remains a specialist option for rare correctness-critical tasks or an expensive second opinion when Astra/Opus are insufficient.

## Current model landscape

### OpenAI

#### GPT-6 Astra

Best fit:
- hardest end-to-end autonomous work;
- long-horizon research and multi-step execution;
- computer/browser use;
- demanding software engineering;
- scientific and professional workflows;
- artifact creation and cross-tool tasks.

**Practical default for serious Work tasks: Astra Medium.** Start with Low or Medium; use High only when the task is repeatedly reasoning-bound rather than merely long or tool-heavy.

#### GPT-5.6 Sol

Best fit:
- complex normal-chat reasoning;
- research/science/coding when full Astra autonomy is unnecessary;
- planning a task before launching Work;
- independent review of one difficult reasoning node.

On Plus, **Sol High** is especially useful as a preflight/reviewer because it does not consume the separate Work/Codex allowance.

#### GPT-5.6 Terra

Best fit:
- structured moderate-complexity work;
- document analysis, transformation and routine tool workflows;
- long tasks where Astra/Sol quality is unnecessary and allowance efficiency matters.

#### GPT-5.6 Luna

Best fit:
- high-volume simple operations;
- repetitive extraction/classification;
- low-reasoning transformations.

### Anthropic

#### Claude Fable 5.1

Frontier option for coding, knowledge work, research and long-context reasoning. However, on **Claude Pro it consumes pay-as-you-go usage credits immediately**, so it should normally be reserved for unusually difficult correctness-critical work or an independent frontier opinion when the expected gain clearly justifies direct spend.

Fable 5.1 supports effort control; thinking is always enabled.

#### Claude Opus 5

Best fit:
- strongest included Claude Pro reasoning;
- demanding knowledge work and coding;
- long-running agents when Fable cost is unjustified;
- independent/adversarial review of OpenAI-produced work.

#### Claude Sonnet 5

Best fit:
- efficient day-to-day Cowork/Claude Code work;
- sustained tool use and coding where usage efficiency matters;
- routine and intermediate agentic execution.

Sonnet 5 remains a strong value option because agentic performance is much closer to older Opus-class capability than previous Sonnet generations, while using fewer resources.

## Reasoning / effort settings

### OpenAI

In standard ChatGPT Plus Chat:
- GPT-5.6 Sol: Medium / High, plus Instant/automatic behavior where exposed.

In Work/Codex:
- model and reasoning level are selected separately;
- Low stretches allowance and can be surprisingly competitive on Astra;
- Medium is the normal starting point for serious tasks;
- High should be reserved for tasks where deep reasoning, not execution length/tool use, is the bottleneck.

**Operational rule:** choose model and effort before a long agentic run. Do not change them mid-session without a concrete reason; higher effort can consume more allowance and does not guarantee a better result.

### Anthropic

Current effort guidance:
- **Low / Medium:** routine work and better usage efficiency;
- **High:** best general quality/speed balance;
- **xhigh:** deeper reasoning for long-running coding/agentic tasks;
- **Max:** deepest reasoning and highest token cost, for correctness-critical cases.

Thinking and effort are separate controls, but:
- **Fable 5.1:** thinking always on.
- **Opus 5:** thinking is also always on in Claude; API behavior differs by effort level.

## Benchmark / eval evidence

### Artificial Analysis baseline (checked Sep 10; no newer same-methodology result found in this Sep 14 delta-check)

At max effort in the current same-methodology comparison used by the previous snapshot:

| Metric | GPT-6 Astra | Claude Fable 5.1 | Signal |
|---|---:|---:|---|
| Intelligence Index | 53 | 53 | Tie |
| AA-Briefcase | 1562 | 1662 | Fable |
| GDPval-AA v2 | 1580 | 1764 | Fable |
| AutomationBench-AA | 68% | 59% | Astra |
| Terminal-Bench v4.0 | 59% | 52% | Astra |
| SciCode | 56% | 63% | Fable |
| Humanity's Last Exam | 55% | 59% | Fable |
| AA-LCR v1.1 | 81% | 85% | Fable |
| Output tokens/task | ~27k | ~78k | Astra much more token-efficient |
| Reasoning tokens/task | ~17k | ~47k | Astra much more token-efficient |
| Measured cost/task | ~$3.26 | ~$7.63 | Astra lower in this eval |

Interpretation remains unchanged: **there is no universal winner**. Astra is particularly strong for autonomous execution / automation / terminal work; Fable 5.1 remains extremely strong in science-heavy reasoning, long-context and dense knowledge work, but its Pro-plan economics make it a specialist choice here.

### Cognition SWE-2 task-oriented coding comparison (new this week)

| Benchmark | GPT-6 Astra | Claude Fable 5.1 | GPT-5.6 Sol |
|---|---:|---:|---:|
| FrontierCode 1.1 Main | 53.3% | 50.9% | 47.5% |
| DeepSWE 1.1 | 74.1% | 67.4% | 72.7% |
| Terminal-Bench 2.1 | 89.9% | 91.4% | 88.8% |
| Terminal-Bench 4 | 57.9% | 55.8% | 37.3% |

This is relevant because it tests agentic software-engineering behavior, but it is **vendor-published evaluation data**, not an independent head-to-head study. Use it as corroborating evidence rather than a definitive ranking.

### Harness-level signal: Fusion

Cognition reports that its Fusion planner/executor architecture can achieve near-native Claude Code or Codex coding performance while cutting inference cost by roughly one-third in selected configurations. The design uses two agents with independent contexts and passes compact summaries/results between them, improving cache efficiency.

Practical takeaway for this repository: **routing architecture matters almost as much as raw model choice**. For complex future workflows, consider a strong planner/reviewer plus a cheaper executor instead of running the frontier model for every step. This is an architectural recommendation; it does not alter current Plus/Pro subscription routing by itself.

## Practical routing recommendations

### 1. Uncertain task / choose workflow first

**ChatGPT normal Chat → GPT-5.6 Sol High.** Use it to classify the task and choose vendor/surface/model/effort before spending Work/Codex allowance.

### 2. Long, difficult autonomous knowledge-work task

Default: **ChatGPT Work → GPT-6 Astra Medium**.

Use when the bottleneck is long-horizon planning, multi-file/tool execution, research, provenance tracking or iterative verification. Start at Medium; raise only if deeper reasoning is demonstrably limiting quality.

### 3. Long task where allowance efficiency matters more than frontier quality

Candidates:
- **Claude Cowork → Sonnet 5 Medium/High**;
- **ChatGPT Work → Terra or Sol at lower effort**.

Choose based on tool/file locality and which subscription allowance is more constrained.

### 4. Difficult single reasoning problem

Candidates:
- **ChatGPT Chat → Sol High**;
- **Claude Chat → Opus 5 High**.

Use a normal chat surface instead of launching a long-running agent when the problem is one reasoning node rather than an execution workflow.

### 5. Coding / repository work

- **Codex + Astra Medium** for the hardest long-horizon software work.
- **Codex + Sol** when Astra is unnecessary or allowance pressure matters.
- **Claude Code + Opus 5** for strongest included Claude Pro coding/reasoning.
- **Claude Code + Sonnet 5** for throughput and usage efficiency.
- **Fable 5.1** only when the expected quality gain justifies usage credits.

Fresh Cognition data strengthens Astra as the default frontier coding attempt for this subscription mix; it does not eliminate the value of Opus 5 as an independent implementation/review path.

### 6. Scientific / engineering work with high error cost

Recommended pattern:
1. Primary execution with **Astra Medium** or **Opus 5**, chosen by tool/agentic needs.
2. Independent adversarial review by the other vendor's strong included model (**Sol High** or **Opus 5 High**).
3. Use Fable 5.1 only if a material disagreement remains and the decision is important enough to justify extra spend.

Cross-vendor review is usually more valuable than blindly increasing effort on the same model.

## Sources checked on 2026-09-14

### Official OpenAI
- https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex
- https://openai.com/index/gpt-6-astra/
- https://openai.com/index/introducing-gpt-live-1-in-the-api/

### Official Anthropic
- https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan
- https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings
- https://www.anthropic.com/claude-fable-and-mythos-5-1
- https://www.anthropic.com/news/claude-sonnet-5

### Task-oriented / comparative evidence
- https://artificialanalysis.ai/articles/benchmarking-gpt-6-astra
- https://artificialanalysis.ai/models/comparisons/gpt-6-astra-vs-claude-fable-5-1
- https://cognition.com/blog/swe-2
- https://cognition.com/blog/local-fusion

## Uncertainties / re-check before important decisions

- Product availability and exact UI labels can change during staged rollouts; verify the model picker for the user's account.
- OpenAI does not publish one fixed Plus weekly Work/Codex message number; usage is task-, model- and effort-dependent.
- Purchased Work/Codex resets are eligibility- and country-dependent; do not assume they are available on every account.
- Claude Pro usage is dynamic rather than a fixed message count; long context, tools, product surface and effort affect consumption.
- Fable 5/5.1 usage-credit economics can change; verify the current Claude plan page before a paid-heavy run.
- Benchmark methodology changes rapidly. Compare models on the same benchmark version and effort configuration; do not mix launch-day scores with later methodology revisions.
- Cognition's SWE-2 comparison is useful but vendor-published; prefer independent replication when available.

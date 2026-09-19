# AI Model Current State

**Last updated:** 2026-09-20  
**Previous snapshot:** 2026-09-14  
**Scope:** OpenAI + Anthropic, with routing optimized for **ChatGPT Plus** and **Claude Pro (~$20/month)**.  
**Policy:** Treat **Claude Fable 5/5.1** as a last-resort option on Claude Pro because both use pay-as-you-go usage credits from the start rather than the included Pro allowance.

> This is a weekly snapshot, not a permanent truth. Before an important routing decision, run a short delta-check for changes since `Last updated` and only for capabilities relevant to the current task.

## Executive summary

**Core model routing is unchanged since 2026-09-14.** For this subscription mix:

- **Hardest long-horizon agentic work:** **ChatGPT Work / Codex → GPT-6 Astra**, normally **Medium** effort.
- **Best high-quality included Claude option:** **Claude Opus 5**.
- **Best efficient/default Claude option:** **Claude Sonnet 5**.
- **Best normal ChatGPT preflight / single-node reasoning option on Plus:** **GPT-5.6 Sol High**.
- **Claude Fable 5/5.1:** keep as a specialist / last-resort option because **Claude Pro does not include Fable usage in the normal plan allowance**.

Two meaningful updates appeared this week:

1. **Anthropic is gradually merging Claude Chat and Cowork into one Claude experience for Pro and Max.** Instead of explicitly choosing Chat vs Cowork, Claude can decide whether a request is a quick response or a longer task. This changes the **surface-selection UX**, but not the underlying routing principle: decide first whether the task needs agentic execution, local/computer access, or just a conversational answer.
2. **Google released Android Bench 2.0 long-horizon agentic coding results.** On its current 30-task long-horizon set, GPT-6 Astra + Codex has the highest pass rate among the listed frontier systems at **28.0%**, versus **22.7% for Claude Fable 5.1 + Claude Code**, **19.3% for GPT-5.6 Sol + Codex**, **16.7% for Claude Opus 5 + Claude Code**, and **6.7% for Claude Sonnet 5 + Claude Code**. Completion rates are much closer than pass rates, highlighting that frontier agents often get most of a task done but still miss correctness or polish details.

This new Android Bench evidence strengthens **Astra + Codex** for especially difficult long-horizon software-engineering tasks, but it does not make Astra the universal choice for all coding or knowledge work.

## Changes since 2026-09-14

### Material product / workflow changes

#### Claude: Cowork and Chat are gradually becoming one Claude

Anthropic now documents a gradual rollout on **Pro and Max** where Chat and Cowork are merged into a single conversation experience. The user asks for the result and Claude decides whether to answer quickly or perform a longer task. What previously required Cowork can be available from an ordinary Claude conversation.

Current availability notes:
- Cowork remains available on paid Claude plans.
- Desktop support remains available.
- Web/mobile Cowork is in beta for Pro/Max/Team.
- The unified Chat + Cowork experience is rolling out gradually, so UI can differ by account.

**Routing implication:** do not hard-code “Claude Chat vs Cowork” as strongly as before. For Anthropic, route primarily by **model + required capabilities**, then use the available Claude surface on the account.

### Core model / allowance changes

**No material change found.**

- ChatGPT Plus still includes **GPT-6 Astra in Work and Codex**, but not GPT-6 Pro in normal Chat.
- OpenAI’s published Plus estimates per five-hour Work/Codex window remain:
  - Astra: **5-45**
  - Sol: **10-100**
  - Terra: **25-200**
  - Luna: **250-2,000**
- Weekly limits may also apply; these are estimated local-message equivalents, not fixed message caps.
- Claude Pro remains **$20/month in the US** and includes Claude Code plus longer multi-step tasks; Cowork remains available while the unified Claude experience rolls out.
- **Fable 5 and Fable 5.1 still use usage credits from the start on Claude Pro.**
- No newer OpenAI or Anthropic flagship model displaced Astra / Fable 5.1 / Opus 5 / Sonnet 5 during this delta-check.

### New benchmark / eval evidence

#### Android Bench 2.0 (new, Sep 17)

Google’s Android Bench 2.0 adds:
- long-horizon tasks intended to take human engineers days or weeks;
- 5 independent runs per task;
- private / contamination-resistant codebases and migrations;
- multimodal UI verification;
- continuous completion scoring;
- provider-native agent harnesses such as Codex and Claude Code.

Current long-horizon results:

| Model + agent | Pass rate | Completion rate | Avg latency | Avg benchmark-run cost |
|---|---:|---:|---:|---:|
| GPT-6 Astra + Codex | **28.0%** | 82.2% | 7.9 h | $375.7 |
| Claude Fable 5.1 + Claude Code | 22.7% | **82.4%** | 22.2 h | $492.6 |
| GPT-5.6 Sol + Codex | 19.3% | 74.3% | 8.6 h | $235.8 |
| Claude Opus 5 + Claude Code | 16.7% | 77.8% | 27.0 h | $861.4 |
| Claude Sonnet 5 + Claude Code | 6.7% | 59.8% | 14.7 h | $283.7 |
| GPT-5.6 Terra + Codex | 4.7% | 53.4% | 5.1 h | $53.2 |
| GPT-5.6 Luna + Codex | 3.3% | 55.2% | 7.6 h | $13.5 |

Interpretation:
- **Astra + Codex has the strongest current Android Bench 2.0 pass rate.**
- Astra and Fable 5.1 are effectively similar on average completion (82.2% vs 82.4%), so the bigger difference is in finishing the last correctness/polish gap.
- The benchmark evaluates **model + agent harness**, not the bare model alone.
- Confidence intervals are wide because the long-horizon set is small; do not treat the ordering as a universal model ranking.
- The benchmark is highly relevant to large repo migrations, multi-file feature work, UI work, and other long-horizon software engineering.

#### Artificial Analysis baseline

No newer same-methodology release displaced the 2026-09-14 snapshot.

At current max-effort comparison:
- **GPT-6 Astra:** Intelligence Index 53.
- **Claude Fable 5.1:** Intelligence Index 53.
- Astra remains materially more token/cost efficient in Artificial Analysis’s run.
- Fable 5.1 remains stronger on several dense knowledge/science sub-evals.
- Astra remains especially strong on automation and terminal-oriented agentic work.

The overall conclusion remains: **no universal winner; choose by task and economics.**

## Subscription context

### ChatGPT Plus

Normal Chat:
- **GPT-5.6 Sol** with higher reasoning modes available.
- **GPT-6 Pro is not included in Plus Chat.**

Work / Codex:
- **GPT-6 Astra**
- **GPT-5.6 Sol**
- **GPT-5.6 Terra**
- **GPT-5.6 Luna**

Current official Plus estimates per five-hour window:

| Model | Estimated local messages / 5h |
|---|---:|
| GPT-6 Astra | 5-45 |
| GPT-5.6 Sol | 10-100 |
| GPT-5.6 Terra | 25-200 |
| GPT-5.6 Luna | 250-2,000 |

Notes:
- Work and Codex share the relevant included usage structure.
- Weekly constraints may also apply.
- Larger context, longer output, higher effort and complex multi-step execution consume allowance faster.
- Purchased/reset options can depend on account, region, billing country and rollout.

### Claude Pro (~$20/month)

- Pro remains **$20/month in the US**.
- Includes **Claude Code**.
- Claude supports longer multi-step tasks.
- **Cowork remains available**, while Anthropic gradually rolls Chat and Cowork into a unified Claude experience.
- **Claude Sonnet 5** remains the efficient/default model.
- **Claude Opus 5** remains the strongest model included in normal Pro usage.
- **Claude Fable 5 / 5.1 are not included in normal Pro limits** and use pay-as-you-go usage credits from the start.
- Claude API usage is separate from the Pro subscription.

## Current model landscape

### OpenAI

#### GPT-6 Astra

Best fit:
- hardest end-to-end autonomous work;
- long-horizon research and execution;
- computer/browser use;
- complex software engineering;
- high-stakes professional workflows;
- artifact generation across documents, spreadsheets, presentations, sites, and code.

**Default serious-agent recommendation: Astra Medium.**

Raise to High only when the bottleneck is genuinely deep reasoning or repeated verification, not merely task duration.

#### GPT-5.6 Sol

Best fit:
- difficult normal-chat reasoning;
- scientific / engineering reasoning;
- preflight planning before Work;
- independent review of a difficult subproblem;
- coding where Astra is unnecessary.

On Plus, **Sol High** is a good way to spend normal Chat allowance instead of consuming Work/Codex allowance.

#### GPT-5.6 Terra

Best fit:
- structured moderate-complexity Work/Codex tasks;
- document transformation;
- routine multi-file workflows;
- cost/allowance-sensitive agent execution.

#### GPT-5.6 Luna

Best fit:
- high-volume simple extraction;
- classification;
- repetitive transformations;
- low-reasoning workflow execution.

### Anthropic

#### Claude Fable 5.1

Frontier model for coding, knowledge work, research and long-context reasoning.

However, for **Claude Pro**, it is a **usage-credit model from the first request**, so it should normally be reserved for:
- correctness-critical frontier problems;
- expensive independent review;
- cases where Astra / Opus materially disagree;
- tasks where Fable’s known strengths plausibly matter enough to justify direct spend.

#### Claude Opus 5

Best fit:
- strongest included Claude Pro reasoning;
- difficult knowledge work;
- demanding coding and analysis;
- long-running agents when Fable cost is unjustified;
- independent/adversarial review of OpenAI output.

#### Claude Sonnet 5

Best fit:
- sustained everyday Claude work;
- coding and tool use where usage efficiency matters;
- routine-to-intermediate agentic execution;
- long tasks where Opus quality is unnecessary.

## Reasoning / effort

### OpenAI

For serious Work/Codex tasks:
- **Low:** use when execution is straightforward and allowance efficiency matters.
- **Medium:** default for serious agentic work.
- **High:** use when hard reasoning / verification itself is the bottleneck.

Operational rule remains:
**choose the model and effort before a long agentic session and avoid changing them mid-session without a concrete reason.**

For a single hard subproblem arising during a long Work task, prefer solving/reviewing it separately with **Sol High** (or the other vendor) rather than automatically increasing effort for the whole ongoing task.

### Anthropic

Current Claude effort levels:
- **Low**
- **Medium**
- **High**
- **xhigh**
- **Max**

Guidance:
- Low/Medium: routine work and allowance efficiency.
- High: strong general quality/speed balance.
- xhigh: long-running coding/agentic tasks.
- Max: deepest reasoning, highest usage.

Thinking:
- **Fable 5.1:** always on.
- **Opus 5:** thinking cannot be turned off in Claude; API rules vary by effort.
- Thinking and effort remain separate concepts.

## Practical routing recommendations

### 1. Uncertain task / workflow selection

**ChatGPT Chat → Sol High** for routing/preflight.

Use the stable rule:

**workflow / environment → model → effort**

### 2. Long, difficult autonomous knowledge-work task

Default:
**ChatGPT Work → Astra Medium**

Especially strong when the task includes:
- multiple files;
- browser/research;
- cross-tool execution;
- long-horizon verification;
- finished artifacts.

### 3. Long software-engineering / repository task

Default:
**Codex → Astra Medium**

The new Android Bench 2.0 results strengthen this recommendation for difficult multi-file, long-horizon engineering tasks.

Alternatives:
- **Claude Code → Opus 5** when you want the strongest included Claude path.
- **Claude Code → Sonnet 5** when throughput and allowance efficiency matter.
- **Fable 5.1** only when the expected marginal quality gain justifies usage credits.

### 4. Long task where usage efficiency matters more than frontier quality

Candidates:
- **Claude → Sonnet 5 Medium/High**
- **ChatGPT Work → Terra**
- **ChatGPT Work/Codex → Sol at lower effort**

Choose by tools, locality, and which allowance is currently more constrained.

### 5. Difficult single reasoning problem

Candidates:
- **ChatGPT Chat → Sol High**
- **Claude → Opus 5 High**

Avoid launching a long-running agent if the problem is one reasoning node.

### 6. Scientific / engineering work with high error cost

Recommended pattern:
1. Primary work with **Astra Medium** or **Opus 5**, based on required tools/autonomy.
2. Independent cross-vendor review with **Opus 5 High** or **Sol High**.
3. Use **Fable 5.1** only if important disagreement remains and the value justifies direct credits.

Cross-vendor review usually adds more value than blindly increasing effort on the same model.

### 7. Claude surface selection after the Chat/Cowork merge

Because Anthropic is gradually merging Chat and Cowork:
- do not rely on a rigid “Claude Chat vs Cowork” choice;
- specify the task, model, tools, files, autonomy and verification requirements;
- let the available unified Claude surface decide whether to perform a quick answer or longer task;
- still use **Claude Code** when the work is clearly repository/developer-centric.

## Sources checked on 2026-09-20

### Official OpenAI
- https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex
- https://help.openai.com/en/articles/20001275
- https://openai.com/index/gpt-6-astra/

### Official Anthropic
- https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan
- https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings
- https://support.claude.com/en/articles/8325606-what-is-the-pro-plan
- https://support.claude.com/en/articles/16761823-claude-cowork-and-chat-are-one-claude
- https://support.claude.com/en/articles/15520349-use-claude-cowork-on-web-desktop-and-mobile
- https://www.anthropic.com/news/claude-opus-5
- https://www.anthropic.com/news/claude-sonnet-5

### Independent / task-oriented comparative evidence
- https://artificialanalysis.ai/articles/benchmarking-gpt-6-astra
- https://artificialanalysis.ai/articles/claude-fable-5-1
- https://artificialanalysis.ai/evaluations/aa-briefcase
- https://developer.android.com/blog/posts/android-bench-2-0-pushing-the-frontier-with-challenging-long-horizon-tasks
- https://developer.android.com/bench
- https://developer.android.com/bench/methodology/2

## Uncertainties / re-check before important decisions

- ChatGPT and Claude product surfaces are actively changing; UI labels may differ by rollout cohort.
- Anthropic’s merged Chat/Cowork experience is gradual, so some Pro accounts may still show separate modes.
- OpenAI Work/Codex estimates are not fixed message caps; task/model/effort strongly affect actual consumption.
- Claude Pro usage remains dynamic rather than a fixed message count.
- Fable 5/5.1 economics may change; verify the current plan page before a heavy paid run.
- Android Bench 2.0 currently has a relatively small long-horizon task set; confidence intervals are wide and the harness is part of the evaluated system.
- Benchmark methodology changes quickly. Compare only same-version, same-effort results when possible.

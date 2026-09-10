# AI Model Current State

**Last updated:** 2026-09-10  
**Scope:** OpenAI + Anthropic, with routing optimized for **ChatGPT Plus** and **Claude Pro (~$20/month)**.  
**Policy:** Treat **Claude Fable** as a last-resort option on Claude Pro because it uses pay-as-you-go usage credits from the start rather than the included Pro allowance.

> This is a weekly snapshot, not a permanent truth. Before an important routing decision, run a short delta-check for changes since `Last updated` and only for capabilities relevant to the current task.

## Executive summary

As of 2026-09-10, the practical default frontier choice for this subscription mix is **GPT-6 Astra in ChatGPT Work/Codex** for especially demanding long-horizon agentic work, because Astra is included (with limited allowance) on ChatGPT Plus, whereas **Claude Fable 5/5.1 is pay-as-you-go on Claude Pro**. For ordinary high-end chat reasoning, ChatGPT Plus provides **GPT-5.6 Sol Medium/High**, while Claude Pro provides **Claude Opus 5** as its strongest included model and **Claude Sonnet 5** as the default/efficient model.

Fresh independent evidence from Artificial Analysis now puts **GPT-6 Astra and Claude Fable 5.1 effectively tied at the top of its current Intelligence and Coding Agent indices**, with Astra using substantially fewer tokens and lower measured cost per task. On the same current comparison, Fable 5.1 remains stronger on some science/knowledge benchmarks (for example SciCode, HLE, GDPval-AA), while Astra leads on AutomationBench-AA and Terminal-Bench v4.0. This reinforces task-specific routing rather than a single global winner.

## Subscription context

### ChatGPT Plus

- Standard Chat: **GPT-5.6 Sol** with **Medium** and **High** reasoning is included.
- Plus does **not** include GPT-5.6 Sol Extra High or Pro in standard Chat.
- **GPT-6 Pro (Astra-powered) is not included in standard Chat on Plus.**
- ChatGPT Work and Codex on Plus include **GPT-6 Astra** plus **GPT-5.6 Sol, Terra, and Luna**.
- Work and Codex share a separate included usage allowance. Both a five-hour window and a weekly limit may apply; allowance must remain in both.
- Current OpenAI guidance gives approximate Plus local-message ranges per five-hour period (not fixed message caps):
  - Astra: **5–45**
  - Sol: **10–100**
  - Terra: **25–200**
  - Luna: **250–2,000**
- Higher reasoning effort can consume allowance faster and does not guarantee a better answer.

### Claude Pro (~$20/month)

- Pro includes Claude Chat, **Claude Code**, and **Claude Cowork**.
- **Claude Sonnet 5** is the default Pro model and is optimized for efficient agentic work.
- **Claude Opus 5** is the strongest model included on Claude Pro and is the main high-quality alternative to Sol/Astra for demanding work without extra Fable charges.
- Claude usage across web/app/Desktop/Claude Code counts toward the same subscription usage pool.
- Pro has a five-hour session limit and a weekly usage limit; actual usage depends on model, context length, features, and effort.
- **Claude Fable 5 and Fable 5.1 are available on Pro only through pay-as-you-go usage credits from the start.** They are not included in the regular Pro weekly allowance.
- Therefore, for this user, Fable should normally be considered only when the expected quality gain is clearly worth direct additional spend.

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

For ChatGPT Plus, Astra is especially attractive in **Work/Codex** because it is included within the limited Work/Codex allowance. OpenAI explicitly recommends trying Astra Low or Medium before assuming a higher effort is better; Astra Low can outperform Sol High on some tasks.

Practical default for serious Work tasks: **Astra Medium**. Use High only when the task is repeatedly reasoning-bound rather than merely long or tool-heavy.

#### GPT-5.6 Sol

Best fit:
- complex chat reasoning;
- research/science/coding when full Astra autonomy is unnecessary;
- planning a task before launching Work;
- independent review of one difficult reasoning node.

On ChatGPT Plus, **Sol High** is a particularly useful “preflight” model because it is available in normal Chat and does not consume the separate Work/Codex allowance.

#### GPT-5.6 Terra

Best fit:
- structured, moderately complex work;
- extraction/transformation and routine tool workflows;
- tasks where Sol/Astra quality is unnecessary and Work allowance efficiency matters.

#### GPT-5.6 Luna

Best fit:
- high-volume simple operations;
- repetitive extraction/classification;
- low-reasoning transformations.

### Anthropic

#### Claude Fable 5.1

Anthropic positions Fable 5.1 as its most capable generally available model for coding and knowledge work, with strong research/science capability and long-context/agentic performance.

However, on **Claude Pro it is not included in the subscription allowance**: it uses pay-as-you-go usage credits immediately. Therefore it should be used only for rare correctness-critical tasks where Opus 5/Astra are insufficient or a second independent frontier opinion is worth the added cost.

Fable 5.1 supports effort control and has thinking always enabled. Current effort choices include Low, Medium, High, Extra high (xhigh), and Max where exposed by the product.

#### Claude Opus 5

Best fit:
- strongest included Claude Pro reasoning;
- demanding knowledge work and coding;
- long-running agents when Fable cost is unjustified;
- adversarial/independent review of OpenAI-produced work.

Anthropic describes Opus 5 as close to Fable-class frontier intelligence at substantially lower cost and as the strongest model available on Claude Pro.

#### Claude Sonnet 5

Best fit:
- efficient day-to-day Cowork/Claude Code work;
- agentic execution where cost/usage efficiency matters;
- sustained coding/tool-use tasks that do not require Opus-level reasoning.

Sonnet 5 is the default on Claude Pro and is explicitly optimized for stronger agentic performance and good performance per token.

## Reasoning / effort settings

### OpenAI

In standard ChatGPT Plus Chat:
- GPT-5.6 Sol: **Medium / High** (plus Instant/automatic reasoning behavior in the UI).
- Extra High and Pro are not included on Plus Chat.

In Work/Codex:
- reasoning level is selected separately from model choice;
- lower effort stretches allowance;
- Medium is the normal starting point for serious tasks;
- higher effort is appropriate only when deeper reasoning is a genuine bottleneck.

**Operational rule:** for a long agentic session, choose the model and effort before launch and avoid changing them mid-session unless there is a strong reason. Do not assume a mid-session effort switch is free or cache-neutral at the product level.

### Anthropic

Claude exposes model, effort, and thinking as separate controls. Current effort guidance:
- **Low / Medium**: routine work and better usage efficiency;
- **High**: strong balance of quality and speed;
- **xhigh**: deeper reasoning for long-running coding/agentic tasks;
- **Max**: most thorough and most expensive, for correctness-critical tasks.

Higher effort consumes more tokens and reaches subscription limits faster. Fable 5.1 always uses thinking.

## Independent benchmark / eval evidence

### Artificial Analysis — current comparison (checked 2026-09-10)

Use the current same-methodology comparison rather than mixing scores from launch-day articles that used earlier index versions.

At **max effort** on the current comparison page:

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

Artificial Analysis' Sep 9 summary also reports Astra tying Fable 5.1 on both its flagship Intelligence Index and Coding Agent Index while using less cost per task. Treat this as strong but still benchmark-specific evidence, not a universal ranking.

### What these benchmarks imply for routing

- **Long autonomous execution / automation / terminal work:** current independent evidence favors Astra more than broad academic reasoning scores do.
- **Science-heavy reasoning / dense knowledge work / long-context synthesis:** Fable 5.1 remains extremely strong and leads on several relevant sub-benchmarks, but its Pro-plan credit economics make it a specialist/last-resort choice here.
- **Coding:** Astra and Fable are both frontier; on this subscription mix, Astra/Codex is usually the economical first frontier attempt, while Claude Opus 5 or Sonnet 5 are useful alternatives depending difficulty and usage pressure.
- **Independent review:** cross-vendor review (Astra/Sol ↔ Opus 5) is often more valuable than simply increasing effort on the same model.

## Practical routing recommendations for this user

### 1. Uncertain task / need to choose a workflow

Start in **ChatGPT normal Chat → GPT-5.6 Sol High**. Use it to classify the task and select vendor/surface/model/effort. This preserves Work/Codex allowance.

### 2. Long, difficult autonomous knowledge-work task

Default: **ChatGPT Work → GPT-6 Astra Medium**.

Use when the bottleneck is long-horizon planning, multi-file/tool execution, research, provenance tracking, or iterative verification. Raise effort only if deep reasoning is repeatedly the dominant failure mode.

### 3. Long task but allowance efficiency matters more than frontier quality

Candidates:
- **Claude Cowork → Sonnet 5 Medium/High**;
- **ChatGPT Work → Terra or Sol at lower effort**, depending required reasoning.

Choose based on where the files/tools are and which allowance is currently more constrained.

### 4. Difficult single reasoning problem

Candidates:
- **ChatGPT Chat → Sol High**;
- **Claude Chat → Opus 5 High**.

Prefer a normal chat surface over launching an expensive long-running agent if only one reasoning node is difficult.

### 5. Coding / repository work

- **Codex + Astra/Sol** for especially difficult long-horizon software work.
- **Claude Code + Opus 5** for strongest included Claude Pro coding/reasoning.
- **Claude Code + Sonnet 5** for better throughput/usage efficiency.
- **Fable 5.1** only when an unusually hard coding/research problem justifies direct extra credits.

### 6. Scientific / engineering work with high error cost

Recommended pattern:
1. Primary execution with **Astra Medium** or **Opus 5**, according to agentic/tool needs.
2. Independent adversarial review by the other vendor's strong included model (**Sol High** or **Opus 5 High**).
3. Use Fable only if the disagreement remains material and the decision is important enough to justify extra spend.

## Fresh changes / observations since the previous file version

The previous `AI_MODEL_CURRENT_STATE.md` was only an initial placeholder, so this update establishes the first full baseline rather than representing a normal weekly delta.

Key current facts established in this baseline:

1. **GPT-6 Astra is now available to ChatGPT Plus in Work and Codex**, while GPT-6 Pro in standard Chat remains for higher plans.
2. OpenAI has published concrete Plus Work/Codex usage estimates: Astra **5–45**, Sol **10–100**, Terra **25–200**, Luna **250–2,000** local messages per five-hour period, with task-dependent consumption and a separate weekly constraint.
3. **Claude Fable 5.1 is not included in Claude Pro usage**; it consumes pay-as-you-go usage credits from the start. This materially changes routing economics and makes Fable a last-resort model for this user.
4. **Claude Opus 5 is the strongest included model on Claude Pro; Sonnet 5 is the default and efficiency-oriented agentic option.**
5. Fresh Artificial Analysis results (Sep 9) place **Astra and Fable 5.1 in a tie at the top of its current Intelligence and Coding Agent indices**, with Astra materially more token/cost efficient in the measured runs.
6. Current sub-benchmarks do not show a universal winner: Fable leads several science/knowledge/long-context measures, while Astra leads automation/terminal measures.

## Sources checked

### Official OpenAI
- https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex
- https://help.openai.com/en/articles/20001354-gpt-56-in-chatgpt/
- https://help.openai.com/en/articles/20001275-chatgpt-work-and-codex
- https://openai.com/index/gpt-6-astra/
- https://openai.com/products/release-notes/

### Official Anthropic
- https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan
- https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings
- https://support.claude.com/en/articles/11647753-how-do-usage-and-length-limits-work
- https://support.claude.com/en/articles/8325606-what-is-the-pro-plan
- https://www.anthropic.com/news/claude-opus-5
- https://www.anthropic.com/news/claude-sonnet-5
- https://www.anthropic.com/claude/fable

### Independent
- https://artificialanalysis.ai/articles/benchmarking-gpt-6-astra
- https://artificialanalysis.ai/models/comparisons/gpt-6-astra-vs-claude-fable-5-1

## Uncertainties / re-check before important decisions

- Product availability and exact UI labels can change during staged rollouts; verify the model picker for the user's account.
- OpenAI does not publish a single fixed Plus weekly Work/Codex message number; usage is task- and model-dependent.
- Claude Pro usage is likewise dynamic rather than a fixed message count; long context, effort, tools, and product surface affect consumption.
- Benchmark methodology changes rapidly. Compare models on the **same current benchmark version and effort configuration**; do not mix launch-day scores with later methodology revisions.
- Before an important task, run a short delta-check from this date for relevant model releases, plan/usage changes, and task-specific benchmarks.

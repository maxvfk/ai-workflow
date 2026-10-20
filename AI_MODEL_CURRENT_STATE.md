# AI Model Current State

**Last updated:** 2026-10-20  
**Previous snapshot:** 2026-10-17  
**Scope:** OpenAI, Anthropic and DeepSeek; practical routing for **ChatGPT Plus**, **Claude Pro (~$20/month US)** and **prepaid DeepSeek API credit balance (no DeepSeek subscription)**.  
**Cost policy:** **Claude Fable 5/5.1 = last resort** on Pro: usage credits are charged from the first request, outside normal Pro allowance. **DeepSeek API usage is metered and deducted from prepaid credit**, not from ChatGPT/Claude subscription allowances.

> Weekly point-in-time snapshot, not a guarantee of account-specific access. Re-check the model picker, `Settings → Usage`, release notes, and costs before unusually expensive or consequential runs. Distinguish Chat, Work/Codex, Claude Chat/Code/Cowork, and API access.

## DeepSeek addendum: 2026-10-20 — new provider added to routing

**This is a material expansion of the scope of the 2026-10-20 snapshot, not a claim of an OpenAI/Anthropic model change since 2026-10-17.** User now also uses a **prepaid DeepSeek API balance**. Previous snapshots only considered ChatGPT Plus and Claude Pro, so the old "no material changes" findings below remain valid for the *previous two-vendor scope*.

### Model versions, access and lifecycle

- **Preferred DeepSeek default: DeepSeek-V4.1-Flash-1017**, released **2026-10-17**; use the production API identifier `deepseek-flash`. The 1017 update replaces the September V4.1 Flash behind this alias and its legacy aliases. **Do not use September V4.1 Flash benchmark results to describe the 1017 model**.
- **DeepSeek-V4-Pro-0813**, API identifier `deepseek-v4-pro`, remains separately accessible **as of 2026-10-20**. Though the Sept 10 announcement proposed redirecting V4 Pro traffic to Flash from Sept 14, DeepSeek subsequently reversed that plan **in response to demand**. The currently published pricing and model table explicitly lists distinct Pro and Flash versions. Therefore do **not** claim the Pro API is merely a Flash alias.
- Both models support a **1M-token context**, up to **384K output** (API maximum, not a prudent default generation budget), JSON output, tools, Responses API, and Anthropic-compatible API. **Flash supports native image input; V4 Pro does not**. OpenAI-compatible base URL `https://api.deepseek.com`; Anthropic-compatible base URL `https://api.deepseek.com/anthropic`. Integrations with **Claude Code, Codex, OpenCode and DeepSeek Harness** are documented. An integration does **not** mean DeepSeek inherits the same coding/agent quality or included allowance from OpenAI/Anthropic.
- The model is **open-weight** (MIT on Hugging Face): **552B total MoE / about 8B input-active, 16B output-active** per DeepSeek. Active parameter count is **not** the total weights to load. This is **not a practical local model on a 12 GB VRAM laptop**; assess it here primarily as hosted API service.

Official: https://api-docs.deepseek.com/news/news261017/ ; https://api-docs.deepseek.com/quick_start/pricing/ ; https://api-docs.deepseek.com/quick_start/pricing/?helper=penn&method=individual ; https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017

### API reasoning and effort: actual controls, not ChatGPT/Claude labels

DeepSeek's **thinking mode is enabled by default**; default reasoning effort is **high**. Disable explicitly with `thinking: {type: "disabled"}` on OpenAI-format Chat Completions when deep reasoning is unnecessary. With thinking enabled, use `reasoning_effort: "low" | "high" | "max"`; effective mapping is **minimal/low → low; medium/high/xhigh → high; max/ultra → max**. Do **not** assume that requesting "medium" gives a distinct Medium mode; it maps to High. Practical default **low** for simple/throughput work, **high** for real coding/reasoning, **max** for carefully bounded hard tasks when the additional tokens pay off. Compare elapsed time and cost across settings. In thinking mode `temperature`, `presence_penalty`, `frequency_penalty` are ignored. When calling tools, the integration must preserve prior `reasoning_content` according to API rules to avoid errors.

Source: https://api-docs.deepseek.com/guides/thinking_mode/

### Pay-as-you-go pricing for a topped-up balance (USD per 1M tokens; checked 2026-10-20)

| Model | Input cache miss off-peak / peak | Input cache hit off-peak / peak | Output off-peak / peak |
|---|---:|---:|---:|
| **V4.1 Flash 1017** (`deepseek-flash`) | **$0.15 / $0.30** | **$0.003 / $0.006** | **$0.60 / $1.20** |
| **V4 Pro 0813** (`deepseek-v4-pro`) | **$0.66 / $1.32** | **$0.022 / $0.044** | **$1.98 / $3.96** |

- Peak hours: **01:00–04:00 and 06:00–10:00 UTC, Monday–Friday, excluding Chinese public holidays**; other times including weekends / Chinese public holidays are off-peak (50% of peak). Rate schedule can change: verify before spending.
- DeepSeek deducts charges from **granted balance first, then topped-up prepaid balance**; this is **not** a fixed monthly allowance. Reasoning/output tokens and context replay are metered according to the API invoice.
- Example, assuming **1M uncached input + 250K output**, no tools/extra calls: **Flash $0.30 off-peak / $0.60 peak**, versus **Pro $1.155 off-peak / $2.31 peak**. This is an illustration of usage charges, *not* end-to-end agent cost or expected consumption per task. Long agent runs may repeat context many times; caching, tool retries and effort substantially change the result.
- Newly added DeepSeek **Search and Fetch APIs** each cost **$0.75 / 1,000 successful requests**. Server-side calls from DeepSeek Harness / Claude Code / Codex are temporarily free with **billing beginning Nov 1 2026, 00:00 Beijing time (= Oct 31 16:00 UTC)**, per DeepSeek's current documentation; these are separate from generation token charges and can alter the economics of research-heavy agents.

Source: https://api-docs.deepseek.com/quick_start/pricing/ ; https://api-docs.deepseek.com/guides/search/

### Independent benchmarks: 1017 only; compare like-for-like efforts and harnesses

**Artificial Analysis (API, Max setting for each model unless otherwise labeled):**

| Model | Intelligence Index | AutomationBench-AA | Terminal-Bench 4.0 | SciCode |
|---|---:|---:|---:|---:|
| **DeepSeek V4.1 Flash 1017 Max** | **45** | **67%** | **34%** | **56%** |
| DeepSeek V4 Pro 0813 Max | 36 | 57% | 14% | 51% |
| GPT-6.1 Sol Max | 52 | 65% | 56% | 54% |
| Claude Sonnet 5.5 Medium | 41 | 55% | 30% | 53% |
| Claude Sonnet 5.5 High | 47 | 59% | 44% | 54% |
| Claude Sonnet 5.5 Max | 56 | 72% | 64% | 61% |
| Claude Opus 5.5 Max | 58 | 70% | 60% | 67% |

- **Key result:** 1017 Flash **beats V4 Pro in most listed tests**, and its Max score falls near **Sonnet High (45 vs 47)**, above Sonnet Medium (45 vs 41), but behind stronger Max Opus/Sonnet and GPT-6.1 Sol. On AA AutomationBench it scores **67%**, slightly ahead of GPT-6.1 Sol Max **65%**, but GPT-6.1 Sol is far stronger on Terminal-Bench **56% vs 34%**. *Do not infer universal coding/agent superiority from one aggregate or sub-benchmark.*
- AA reports **~225 output tokens/s** and **$0.26/task** for Flash 1017 Max versus **~57 tokens/s** and **$0.72/task** for GPT-6.1 Sol Max under its own deployment, evaluation mix and cost model. Flash uses **~89K output tokens per task** versus Sol **~38K**: very high generated/reasoning-token consumption can erode apparent per-token savings. API-provider/harness throughput is **not** a measurement of ChatGPT Work or Claude Code end-to-end user experience.
- DeepSeek's **own** model card reports vendor-evaluated 1017 gains over September Flash: **DeepSWE v1.1 77.0 vs 74.2**, **ProgramBench 29.1 vs 20.3**, **Automation-Bench v1.0.6 60.5 vs 54.8**, **Terminal-Bench 4.0 42.3 vs 31.2**. These are **developer claims with their stated harness**, not the same run as AA's 34% Terminal-Bench; preserve both with source labels and do not average them.

Independent: https://artificialanalysis.ai/models/comparisons/deepseek-v4-1-flash-1017-vs-deepseek-v4-pro ; https://artificialanalysis.ai/models/comparisons/deepseek-v4-1-flash-1017-vs-gpt-6-1-sol ; https://artificialanalysis.ai/models/comparisons/deepseek-v4-1-flash-1017-vs-claude-sonnet-5-5-high ; https://artificialanalysis.ai/models/comparisons/deepseek-v4-1-flash-1017-vs-claude-sonnet-5-5-medium ; https://artificialanalysis.ai/models/comparisons/deepseek-v4-1-flash-1017-vs-claude-sonnet-5-5 ; https://artificialanalysis.ai/models/comparisons/deepseek-v4-1-flash-1017-vs-claude-opus-5-5

Developer: https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash-1017

### Routing with the third provider — updated decision rules

1. **DeepSeek prepaid API: Flash 1017 is the default DeepSeek choice**, particularly for bulk classification/transformation, repetitive coding agents, independent budget-friendly technical second opinions, vision+text input, and experiments with Claude Code/OpenCode/Codex backed by DeepSeek. Use **Low thinking** for cheap bounded calls, **High thinking** for substantial work; verify output quality and usage with real logs.
2. **Do not default to V4 Pro** simply because of the "Pro" label. Current independent evals show it behind Flash 1017 on several agentic/coding metrics, with **~3–4.4× higher uncached/token output peak rates**. Use V4 Pro for a narrow verified task-specific advantage, legacy compatibility or deliberate A/B test; otherwise use Flash.
3. For **hardest autonomous Work/browser/cross-tool artifacts**, continue **GPT-6 Astra Medium on existing Plus allowance**. For heavy repository work choose **GPT-6.1 Sol Medium/High** or **Claude Opus 5.5 High/xhigh** based on agent harness, task shape and included allowance. Flash is a serious extra candidate if repeat cost, speed or remaining allowance dominates; require CI, verification and human diff review.
4. For **serious but routine Claude work**, **Sonnet 5.5 Medium/High** remains default with existing Claude Pro usage; **Haiku 5.5** is useful for narrower steps. A cheap DeepSeek API call is still **additional money** while these subscription allowances may remain unused. It can nonetheless be the right independent third-provider review and capacity source.
5. For **scientific/engineering analysis**, seek physical/empirical verification and cross-vendor review (e.g., GPT-6 High or Opus High plus Flash High). Do not presume benchmark leadership implies reliability on the user's experiments, MATLAB, SolidWorks/CAD, technical calculations or long-context evidence synthesis.
6. **Economics:** first compare marginal prepaid API cost *against the marginal cost of already included Plus/Claude allowance* (often $0 until the allowance is constrained) and then consider hard limits, latency, throughput, automatic operation and optional tool charges. Set a per-project DeepSeek top-up budget and monitor actual cache hit/miss, output/reasoning tokens, retry rate and task success. **Fable 5/5.1 remain last-resort credits-only escalation** in Claude Pro.

**Next check:** confirm aliases and pricing on every cycle; test 1017 Flash High vs GPT-6.1 Sol Medium and Claude Sonnet 5.5 Medium/High **in the same real repository with the same work scope, tests, tool privileges and stopping criteria**. Track effective USD / successfully merged change and engineering review effort. Do not treat Max API leaderboard scores as an outcome for default effort modes.


## Weekly delta check: 2026-10-20 (vs 2026-10-17)

**No material changes in recommended models for the original ChatGPT Plus and Claude Pro scope from 2026-10-18 through 2026-10-20.** DeepSeek was added in a same-day scope expansion above. The prior GPT-6 Chat / GPT-6.1 Sol Work-Codex / Claude Opus-Sonnet-Haiku 5.5 routing remains the best supported default. This is an evidence-limited dated check, not a blanket assertion of no product releases or changes.

### Product and model availability

- **OpenAI:** No newly verified broadly released reasoning or coding model during this delta that supersedes GPT-6 Sol in Plus Chat or GPT-6 Astra / GPT-6.1 Sol in Plus Work/Codex. Official ChatGPT release notes dated **Oct 16** describe faster **GPT-6 Pro**, improved tool/plugin use and parallel agents **for eligible Pro users**; they do not confer these Pro-only Chat features on Plus. ChatGPT Slides collaborative rollout is also Pro/Business/Enterprise eligible, not Plus.
- **Codex workflow changes, not models:** A developer community report dated **Oct 19** describes editing prior Codex messages, discarding later model outputs/tool calls for consistency. Another Oct 17 community summary reports improved Work/Codex cache reuse, subagent context sharing and routing to improve **effective usage**. Neither provides a defensible new numeric Plus allowance; distinguish an efficiency improvement from a raised entitlement. Community reports are secondary evidence and should not override account usage displays.
- **Anthropic:** Latest verified Claude release notes still identify **Haiku 5.5 (Oct 7)** as the latest major model. Opus 5.5 / Sonnet 5.5 / Haiku 5.5 remain the normal Claude tiered routing. No verified Fable 5.5 launch or policy reversal.

### Subscription economics / reasoning effort — rechecked

- **ChatGPT Plus:** GPT-6 Chat **Instant/Medium/High**; not Extra High or Pro. Work/Codex share an allowance and may have both five-hour and weekly windows. Official estimated *local messages / five hours*, unchanged: **Astra 5–45**, **GPT-6.1 Sol 15–160**, **GPT-6 Sol 15–150**, **Luna 350–3,000**. Actual task usage is not a fixed message count, and cloud runs/effort can cost more. `Settings → Usage` is authoritative for remaining balance.
- **Claude Pro (~$20/month in US):** session-based five-hour and weekly usage limits remain variable. Model, effort, context and tools affect usage. API usage is distinct, and the monthly Claude Platform API credit added for **Max/Team does not apply to Pro**. **Fable 5 and 5.1 use pay-as-you-go usage credits from the first request** on Pro, so continue to classify them as last-resort paid exceptions.
- **Effort:** Claude supports Low/Medium/High/xhigh/Max where model-enabled; increasing effort spends more tokens and may shorten sessions. On Claude Chat, thinking cannot be disabled for Haiku 5.5, Sonnet 5.5, Opus 5.5 or Fable 5.1. No new reason to abandon **Opus High/xhigh**, **Sonnet Medium/High**, **Haiku Low/Medium** defaults. For Plus Chat, choose GPT-6 Medium/High explicitly for harder work; for Work/Codex use Astra or GPT-6.1 Sol Medium by default and escalate selectively.

### Independent benchmarks, agentic evals and head-to-head delta

No newly confirmed **Oct 18–20 same-harness, same-effort, comparable-token-budget** result provides a material reason to rewrite the routing. Retain prior independent Artificial Analysis comparisons (Haiku 5.5 vs GPT-6 Luna, GPT-6 Sol vs GPT-5.6 Sol), Sonar's GPT-6.1 Sol coding test, and prior Android Bench/FrontierCode/Terminal-Bench/AutomationBench caveats. Do not promote one-off media prompt comparisons to agentic engineering evidence; API benchmark scores do not validate October's Chat deployment or integrated Work/Claude Code performance.

### Operational decision — unchanged

**Chat:** GPT-6 Medium/High (Plus), GPT-5.6 Sol High for comparative reviews. **DeepSeek prepaid API:** Flash 1017 first, typically Low/High thinking; Pro 0813 only when verified advantageous. **Autonomous Work:** Astra Medium for the highest-stakes long-horizon cross-tool runs; GPT-6.1 Sol Medium/High for efficient serious coding/Work; Luna for simple high-volume jobs. **Claude:** Opus 5.5 High/xhigh for hard judgment/coding, Sonnet 5.5 Medium/High as sustained default, Haiku 5.5 Low/Medium for narrow or delegated substeps. **Fable 5/5.1:** only bounded, explicitly budgeted paid escalation where other models disagree materially or a clear task-level advantage exists. For scientific and repository work, preserve independent review plus external tests, rather than treating the model score as a quality guarantee.

### Sources checked 2026-10-20

- Official OpenAI ChatGPT updates (Oct 16 GPT-6 Pro): https://help.openai.com/en/articles/6825453-chatgpt-release-notes
- Official OpenAI Work/Codex allowance: https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex
- Official Anthropic release notes: https://support.claude.com/en/articles/12138966-release-notes
- Official Anthropic effort/thinking: https://support.claude.com/en/articles/8664678-change-the-model-effort-and-thinking-settings
- Official Anthropic Fable billing on Pro: https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan
- Report of Oct 19 Codex message editing (secondary): https://community.openai.com/t/a-reset-to-keep-cooking-with-codex-day-15-of-28-days-of-quality-of-life-improvements-and-or-a-full-reset/1403525/70
- Work/Codex effective-usage discussion (secondary): https://community.openai.com/t/cooking-with-codex-day-15-of-28-days-of-quality-of-life-improvements-and-or-a-full-reset/1403525?page=4
- Retained independent comparisons: https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-luna ; https://www.sonarsource.com/blog/openai-gpt-6-1-sol-evaluation/

## Weekly delta check: 2026-10-17 (vs 2026-10-12)

**No material change to the Plus / Pro model-routing recommendations was verified for 2026-10-13 through 2026-10-17.** This is a dated delta check, not a claim that no product functionality changed. The substantive GPT-6 Chat and Haiku 5.5 changes from the 2026-10-12 snapshot remain active.

**Official model / plan checks:**
- OpenAI's current ChatGPT model-availability documentation still identifies GPT-6 Sol Instant/Medium/High for Plus, with Extra High and Pro excluded, and GPT-5.6 Sol remaining separately selectable. GPT-6 Astra remains a Work/Codex option on Plus, not GPT-6 Pro in ordinary Chat.
- OpenAI's Oct 15 ChatGPT/voice release notes announced **GPT-Live-1.1** (and GPT-Live-1.1 Quip on Free) with updated voices. This affects Voice experience, not text GPT-6 model routing. On Oct 16 the API gained **prompt-to-voice** and nine new GPT-Live voices; this is an API audio feature, not a new general-purpose reasoning model or a Plus allowance increase. Oct 15 also removed the fixed count limit for creating Sites on Plus/Pro, with usage/storage limits still applying; this does not change agent routing.
- Anthropic's official Claude release notes still identify **Oct 7 Haiku 5.5** as the most recent October model release. No verified Oct 13–17 release of a new Opus/Sonnet/Haiku/Fable model was found. Pro remains a ~US$20/month subscription with dynamic five-hour/weekly usage, and API usage remains separate.
- No new verified Plus/Pro allowance or credit policy change was found sufficient to amend the estimates and caveats below. These are product-dependent and should be checked within the user's actual account. Claude Fable 5/5.1 remain **last resort due to metered usage credits from the first request** on Pro.

**Independent benchmark / agentic delta:** Reviewed independent benchmark comparisons, including Artificial Analysis' same-effort GPT-6/Claude comparisons and the Sonar GPT-6.1 Sol coding evaluation retained below. No newly verified, matched-version/harness **Oct 13–17** head-to-head result was strong enough to reverse the prior task-oriented guidance. Existing benchmark numbers are historical evidence, not claimed fresh measurements.

**Routing decision — unchanged:** ChatGPT GPT-6 Medium/High for normal difficult chat; GPT-5.6 Sol High for A/B review; GPT-6 Astra Medium for the hardest autonomous Work; GPT-6.1 Sol Medium/High for efficient serious Work/Codex; GPT-6 Luna for simple high-volume runs; Claude Opus 5.5 High/xhigh for demanding reasoning and coding; Sonnet 5.5 Medium/High for efficient sustained use; Haiku 5.5 Low/Medium for narrow/fast tasks; Fable only after explicit cost justification.

**Sources checked on 2026-10-17:**
- https://help.openai.com/en/articles/20001354-gpt-6-and-other-models-in-chatgpt
- https://help.openai.com/en/articles/6825453-chatgpt-release-notes
- https://openai.com/products/release-notes/
- https://support.claude.com/en/articles/12138966-release-notes
- https://support.claude.com/en/articles/8325606-what-is-the-pro-plan
- https://support.claude.com/en/articles/15424964-claude-fable-models-on-your-plan
- https://artificialanalysis.ai/models/comparisons/claude-haiku-5-5-vs-gpt-6-luna
- https://artificialanalysis.ai/models/comparisons/gpt-6-sol-medium-vs-gpt-5-6-sol-medium
- https://www.sonarsource.com/blog/openai-gpt-6-1-sol-evaluation/

## Executive summary

**Historical material changes from the 2026-10-05 → 2026-10-12 snapshot (retained for context; no additional routing change on 2026-10-17):** (1) **GPT-6 Sol launched in regular ChatGPT** for Plus on 2026-10-07, with Intelligent UI, and becomes the preferred starting point for many difficult *conversational* tasks; (2) **Claude Haiku 5.5 launched** on 2026-10-07 and is a new lower-tier option for small, fast tasks and subagents. A fresh independent **Sonar evaluation** also strengthens the evidence favoring GPT-6.1 Sol over GPT-6 Sol in coding. The strongest Work/Codex and Claude long-running-work defaults **do not change**.

- **Regular ChatGPT Plus:** select **GPT-6 (Sol) Medium/High** as the initial choice; **GPT-5.6 Sol High** remains available as an independent A/B or fallback option. **Extra High and Pro are not included** on Plus. GPT-6 Chat is not the same deployed version as September GPT-6 Sol in Work/Codex.
- **Work/Codex on Plus:** **GPT-6 Astra Medium** for the hardest high-autonomy work; **GPT-6.1 Sol Medium/High** for serious tasks with allowance pressure; **GPT-6 Luna** for simple high-volume work.
- **Claude Pro:** **Opus 5.5 High/xhigh** for difficult judgment-heavy work, **Sonnet 5.5 Medium/High** as a strong efficient default, and **Haiku 5.5 Low/Medium** for simple fast tasks, compaction, classification or delegated narrow substeps when available.
- **Fable 5/5.1:** keep the existing *credits-only, last-resort* rule. No verified Fable 5.5 release as of this check.
- **No new free API credit for Claude Pro:** the announced monthly API credit is for Claude **Max and Team**, not Pro.

## Historical changes: 2026-10-05 to 2026-10-12

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

## Practical model routing — 2026-10-20 (OpenAI/Anthropic; DeepSeek addendum above)

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

## Sources checked / retained (baseline 2026-10-12; current delta sources above)

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

# Daily Legal / Privacy / GRC News Briefing, Pattern

*A reusable pattern for a master agent that curates a daily legal/privacy/GRC news briefing from public sources and drops it into a doc for review.*

**What's in this folder:**
- `README.md` (this file): the methodology, how to set it up and automate it
- `sources.md`: a starter source universe (600+ legal/privacy/GRC publications and law-firm insight pages), the set the curation draws from
- `sample-briefing-2026-06-03.md`: a real worked example of one day's output

---

## What it is

A scheduled routine that, each morning:
1. Searches public sources for recent legal/privacy/GRC/AI-regulation developments
2. Curates the best items (dedupes, filters to your topics, ranks)
3. Formats each as a clip: `[source](link) | headline`
4. Adds a short **POV line** per clip, the practitioner's "why it matters" angle
5. Writes the result into a doc as a daily section, as a **draft for human review**

It is pure **public news aggregation plus commentary**. Nothing proprietary. The value is in the curation (good source set + good filtering) and the POV layer (turning a neutral link list into something with a point of view).

## Why the POV layer matters

A raw clip list ("here are 20 links") is easy to generate and low value. The differentiator is the one-line POV under each clip: what a privacy/AI legal practitioner should actually DO or watch because of this item. That is the part a reader keeps coming back for. Keep POV lines short, specific, and action-oriented ("re-paper your privacy notices," "map your AI systems against the annex now"), not summaries of the headline.

## The source set

See `sources.md`. It is a frequency-ranked list of 600+ sources: major law firms' insight/alert pages (the bulk of it), plus privacy/compliance publications (IAPP and similar), regulators (EU Commission, EDPB, NYDFS, HHS), and a few general outlets (FT, TechCrunch, Politico) for industry context.

How to use it:
- The top ~50 sources produce the majority of high-signal items, start there
- Treat the list as a seed, not a cage; add sources as you find good ones, prune ones that never surface useful items
- Sources skew US + UK/EU legal, which matches an AI/privacy/GRC practice. Re-weight for your jurisdiction

## The daily workflow (what the agent does)

1. **Search** the source set plus a handful of standing topic queries (e.g., "EU AI Act," "US state privacy enforcement," "HIPAA security rule," "cybersecurity regulation," "GDPR enforcement," "AI litigation/governance"). Bias to the last 24-72 hours.
2. **Dedupe** items that cover the same development across multiple firms (keep the clearest 1-2, or list several if each adds an angle).
3. **Filter** to your topics. Drop marketing fluff and pure vendor promotion.
4. **Rank** by relevance and recency.
5. **Format** each kept item as `[source](link) | headline`.
6. **Write a POV line** per item.
7. **Group** lightly by theme (AI Regulation, US Privacy, Healthcare Privacy, Cybersecurity, EU Data Protection, AI Litigation/Governance, etc.).
8. **Output** a dated section into the destination doc.

## Setup

You need:
- A master-agent environment with **web search** (to find the news) and the ability to **write to your destination** (a doc, a markdown file, an email draft, wherever you want the briefing to land).
- The source set (`sources.md`).
- A curation instruction (the workflow above, encoded as the agent's prompt for this task).

First run it **manually / attended**: trigger it, read the output, tune the source weighting, topic queries, clip count, and POV style until it reads the way you want. Calibrate before you automate.

## Automating it (every morning)

Once the output is dialed in, schedule it:
- Use your agent platform's scheduling (a cron-style routine / scheduled task) to run the curation each morning at a fixed time.
- Have it write the day's section to your doc and, optionally, ping you that the draft is ready.
- Keep a **human in the loop**: the morning run produces a DRAFT you review before relying on it or sharing it. Do not auto-publish externally.

## Guardrails (important)

- **Public sources only.** This pattern aggregates public legal news. Do not let it pull in or emit confidential, employee, or customer information.
- **Draft, not publish.** Autonomous generation into your own review queue is low-risk. Autonomous external publishing is not, keep a review gate.
- **Cite everything.** Every clip links to its source. The reader (and you) can verify.
- **Respect your org's autonomy rules.** A scheduled unattended agent may need security sign-off depending on your environment, even a benign one. Confirm before flipping it fully autonomous.

## Customization knobs

- **Cadence**: daily, weekly, or on-demand
- **Topic mix**: weight toward your practice (privacy-heavy, AI-heavy, sector-specific)
- **Clip count**: a tight 8-12 or a comprehensive 25+
- **POV voice**: terse and practical, or more analytical
- **Output target**: a living doc, a daily email draft, a channel post draft

---

*Pattern v1, 2026-06-03. Public news-aggregation methodology, no proprietary content. Adapt the source set and POV voice to your own practice.*

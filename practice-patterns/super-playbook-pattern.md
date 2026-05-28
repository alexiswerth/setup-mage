# Super Playbook Pattern

*A reusable structure for building a paste-in master agent brief that turns Claude for Word (or similar AI surfaces) into a domain-aware reviewer for your org's playbook.*

**Originally built for**: commercial-legal SSA + DPA reviews
**Generalizes to**: any domain where you have a "playbook" (positions, fallbacks, escalation rules) and want an AI to apply those positions consistently across reviewers.

---

## The problem this pattern solves

You have a playbook. It lives in a Google Sheet, Notion, Word doc, or shared brain. When a junior team member runs a review using an AI tool, the AI doesn't know your playbook by default. It applies generic best practices. You either:

- Catch the misses in QA (slow, defeats the point)
- Don't catch them and ship inconsistent positions
- Tell people to "use AI for the first pass and then I'll fix it" (still slow, doesn't scale)

The super playbook pattern fixes this by giving the AI your full playbook context **at the start of every review**, so its first pass is calibrated to your org's positions.

---

## The mental model

Think of it as a **paste-in system prompt** for a per-document AI review session:

1. Open your document (contract, policy, RFP response, etc.) in the AI-enabled editor
2. Paste the super playbook brief as your first message
3. Tell the AI to review the open document against the playbook
4. Get back tracked changes + comments calibrated to your positions

The "super playbook" lives in a single, copyable document that you maintain. When your underlying playbook updates, you re-build the super playbook. (Long-term, this can be replaced by an org-level system prompt or a custom MCP server. The paste-in is the manual bridge.)

---

## The structure (12 sections to include)

Every super playbook should have these sections, in this order. Treat this as the **scaffold**; fill in each one with your org-specific content.

### 1. How to use this (paste-in instructions)

Tell the END USER (the human running the review) how to use the brief. Step by step:

- Open the document in your AI-enabled editor
- Open the AI chat panel
- Copy everything between the "PASTE BLOCK START" and "PASTE BLOCK END" markers (see Section 12)
- Paste as the first message
- Pick the right output mode (e.g., "Tracked changes + proposal cards")
- Ask the AI to review the open document against the playbook

### 2. Why this exists

Tell the AI why this brief is being loaded. Two sentences max. Frames the AI's role for the session.

Example template:
> "Claude for Word doesn't know [YOUR ORG]'s playbook by default. This brief tells the AI: who you are, our positions on every [DOMAIN] clause, our one-thing deal-breaker, our voice for redlines, and our escalation chain."

### 3. Identity

Tell the AI who it's operating as and who it's working for. Include the org's corporate identity facts (legal entity name, address, tax ID, notice email) so the AI can correctly fill in sign blocks, addresses, etc.

### 4. Scope

What this brief covers. What it doesn't. If a user opens a doc that's outside scope, the AI should say so and stop, not try to wing it.

Example: "This brief covers sales-side SSA + DPA reviews only. If the contract is purchasing-side or any other type, say so and stop."

### 5. THE ONE-THING DEAL-BREAKER

The **single most important** line in the sand. The thing that, if violated, the deal is REJECT or escalate. State it cleanly, then list common patterns customers use to attack it.

Example template:
> "[YOUR ONE THING] — EXCEPT for [YOUR EXPLICIT EXCEPTIONS]. Common watch-fors: [LIST 4-6 PATTERNS]."

### 6. Customer Paper Requirements (if applicable)

If your team accepts counterparty-paper deals in specific conditions, list the requirements VERBATIM from your playbook. Use numbered list. Make them non-negotiable as written.

### 7. Negotiation Threshold (if applicable)

Minimum deal size where your team will engage. Below that → no support, escalation path defined.

### 8. Voice & Output Format

How the AI should communicate redlines and comments. Tone (medium-light touch / heavy / educational / minimal). Style rules (no em dashes, no corporate buzzwords). Output severity tiering (CRITICAL / MAJOR / NOTABLE). Format spec (tracked changes + comments / proposal cards / plain notes).

### 9. Citation Handling

What research tools the AI has (or doesn't have) access to. Tag rules for unverified citations (e.g., "tag all case law as [unverified — no research connector]").

### 10. Escalation Chain

Who decides what, by role placeholder. Use generic role names like `[MANAGER]`, `[FINANCE_LEAD]`, `[GRC_LEAD]`, `[CRO]`, `[CISO]`. Not real names (those stay in your private Tier 0 brief).

### 11. Position Library

The heart of the brief. Every clause your playbook covers, with:

- **Standard position** (what your default is)
- **[MANAGER] Note** (calibration / approval boundaries)
- **Second Position / Fallback** (what you'll concede if pushed)
- **Source** (citation back to your playbook source of truth)

Group by section number or category. Use a consistent format. The AI reads this and applies it to the open document.

### 12. Common Customer Asks (one-liner responses)

Quick-answer pairs for the most-asked questions. Each entry: `'Customer question?'` → punchy answer with source citation. Saves the AI from generating responses from scratch on common asks.

### 13. Workflow Reminders + PASTE BLOCK boundary markers

Closing notes: where the brief lives, when to update, source of truth pointer. Then a clear "▲ PASTE BLOCK END" marker so users know where to stop copying. Anything below this marker is for the brief MAINTAINER (you), not the AI.

---

## How to fill in each section (your work)

For each section, you'll work with three things:

1. **Your source playbook** (Google Sheet, Notion, etc. — the source of truth)
2. **Your manager's voice and preferences** (medium-light vs. heavy redline touch, "Note to Customer" vs other comment prefixes, etc.)
3. **Your org's escalation paths** (who approves what, when)

Pull from these three sources into each section. Cite back to the source playbook so anyone can verify a position. Don't paraphrase positions — copy them verbatim where the playbook gives you exact language.

---

## Voice profile considerations

The super playbook reflects the VOICE of the person it's calibrated for (e.g., your manager who'll be using it). If that person says "no em dashes" or "use 'Note to Customer:' as the comment prefix" or "be less educational, more direct," bake those rules into Section 8.

When updating the brief, check those rules against the maintainer's voice profile. Voice preferences evolve — keep the brief in sync.

---

## Citation discipline

Every position in the brief should cite back to the source of truth (your playbook). This serves two purposes:

1. The AI can name the source when it applies a position ("Source: [PLAYBOOK §X.X]")
2. The human reviewer can verify the position is still current

When the source playbook updates, the brief needs to be rebuilt. Keep the source-of-truth pointer prominent.

---

## Maintenance cadence

- **When your underlying playbook updates** → rebuild the brief
- **When your manager's voice evolves** → update Section 8
- **When org structure changes** → update Section 10 (Escalation Chain)
- **When you discover the AI is misfiring on a position** → add a clarifying note in the relevant Section 11 entry
- **Version the brief** (v1, v2, v3) and keep a changelog at the top so users know what changed

---

## Long-term off-ramp

The paste-in is a manual bridge. Over time, this can be replaced by:

1. **Org-level system prompt** in your AI tool's enterprise tier (if supported) — the AI auto-loads your playbook context without anyone needing to paste it
2. **Custom MCP server** that exposes your playbook to the AI dynamically — the AI fetches positions on demand

If/when either lands, the paste-in goes away. Until then, keep the brief current.

---

## Example: how one team applied this pattern

Below is a worked example showing how one team (Drata's commercial-legal team) instantiated the pattern. Note that positions, dollar amounts, and specific section numbers below are EXAMPLES — your team's playbook will have different specifics. The STRUCTURE is what's reusable.

### Their Section 5 (One-thing deal-breaker)

> "Unlimited liability — EXCEPT for our standard third-party IP infringement indemnity in Section 12.1, which IS deliberately uncapped on our side and is acceptable as standard. Any OTHER provision creating effectively unlimited liability is REJECT or escalate to [MANAGER]."

Followed by a list of common watch-fors: customers trying to delete the aggregate cap, carving breach-of-confidentiality out of damages exclusions, asking to tie the cap to insurance limits, etc.

### Their Section 11 entry for an Aggregate Liability Cap

> **§13.2 — Aggregate Liability Cap**
> Standard: Aggregate liability capped at fees paid by Customer in 12 months prior to event giving rise to liability. Carve-outs limited to: IP indemnity and Customer's breach of use restrictions.
> [MANAGER] Note: If Customer requests mutual cap, can add to Order Form. Standard mutual language available.
> Second Position (fallback): If pushed for higher cap, offer super-cap multiplier by ARR band (see Appendix C). Higher multipliers require [MANAGER] approval.
> Source: Playbook §13.2

The dollar amounts in the multiplier ladder, the specific Appendix C content, and the named [MANAGER] are all org-specific — they live in the team's Tier 0 brief, not in this public pattern.

---

## When this pattern doesn't fit

- **Your domain doesn't have a "playbook" of positions/fallbacks** (e.g., creative work, novel research) — pattern is the wrong fit
- **Your AI surface doesn't accept paste-in system prompts** (e.g., it only accepts strict structured inputs) — adapt or pick a different pattern
- **You need cross-document analysis** (e.g., comparing 50 contracts at once) — this is a single-doc review pattern; you want a different architecture (file search agent + analytics)
- **Your playbook changes daily** — paste-in maintenance becomes the bottleneck; invest in the org-level system prompt or custom MCP off-ramp sooner

---

*Pattern version: v1 (2026-05-28). First derived from a real-world build for commercial-legal SSA + DPA reviews.*

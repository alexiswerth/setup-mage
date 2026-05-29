> **Anonymized example from a live Mage setup.** Real names, companies, and identifying details are replaced with [TOKENS]. Patterns are illustrative, not universal rules; swap in your own specifics when adopting.
> _Auto-synced by sync-setup-mage.sh. Do not hand-edit this file, changes are overwritten on the next sync._

# Commercial Legal, Redlining Methodology (Vendor POV)

Last updated: 2026-05-28 during [VENDOR_EXAMPLE] case study work.

**Scope of this methodology:** [USER_NAME] writes from the **VENDOR perspective** (she is in-house at the SaaS vendor) and redlines **CUSTOMER edits and comments** on the vendor's template. This file applies to that workflow specifically. A separate methodology will be written for customer-side review when needed.

**Read at the start of any vendor-side contract review session.** Update as new patterns get added.

**How playbook positions get committed here:**
- Mage does NOT pre-commit speculative positions to the playbook.
- Playbook entries are added AFTER [USER_NAME] finalizes a redline. Mage ingests her final marked-up docx, extracts the positions she actually held, and commits those as canonical positions.
- Patterns (below) are extracted from her actual moves, not hypothesized.

---

## Why this file exists

Adeu (the docx-edit MCP) has an architectural limit: it cannot modify text INSIDE another author's active tracked change. That means Adeu cannot layer "[VENDOR]'s counter-redline" on top of "[CUSTOMER]'s redline" the way Word does natively (purple-on-red).

Result: Mage cannot directly produce a fully-redlined deliverable where [VENDOR]'s tracked changes sit on top of the counterparty's tracked changes. Word does this natively when an attorney works in it; Adeu doesn't.

The workflow we converged on:
- **Mage produces per-clause proposals** in a structured format
- **Attorney applies the redlines in Word** (the actual in-line strike/insert)

The chat-based visual mockups we tried are not a workable UI. Word integration is the right target. Until that lands, Mage hands the attorney the specific moves and the specific words; she applies them.

---

## The PROPOSAL format Mage uses per clause

```
SECTION X.X [name]

REDLINES (attorney applies in Word):
  • [specific delete instruction with exact text or Chg ID]
  • [specific insert instruction with proposed text]
  • [accept/reject specific [CUSTOMER] Chg IDs if applicable]

COMMENT (attorney pastes into margin):
  [2 sentences max, customer-facing, anchored either in [VENDOR] product reality
   OR in market-standard practice]
```

Mage produces this for every clause that needs [VENDOR] action. The attorney never has to think "what should I propose" or "how do I phrase the comment", Mage hands her the specific moves and the specific words.

---

## House style for customer-facing comments

Established 2026-05-28.

- **TWO SENTENCES MAXIMUM** for any comment that goes to a customer or counterparty.
- **Anchor in [VENDOR] product reality first, market-standard practice second.** Example: "The customized agentic services we provide each customer make X impossible" beats "market practice is Y." The first is harder to argue with because it grounds in product reality, not abstract norms.
- **Structure for REJECTION:** (sentence 1) state the position, anchored. (sentence 2) state what [VENDOR] is open to as compromise OR a discovery invitation.
- **Structure for ACCEPT-WITH-REFINEMENT:** (sentence 1) accept [CUSTOMER]'s structure / acknowledge what they got right. (sentence 2) state the specific refinement [VENDOR] is asking for.

---

## Redline patterns identified so far

### Pattern A, Reinstate-with-invitation

When rejecting a customer-side amendment that exposes corporate-structure or use-case risk:
1. Reinstate the original [VENDOR] drafting
2. Anchor rejection in product reality, not abstract market norms
3. Extend a DISCOVERY INVITATION (not a fallback). Example: "happy to walk through your corporate structure to better understand this requirement"

The discovery invitation forces the customer to volunteer information you want them to disclose, without telegraphing that you've already identified it.

**Used at:** Section 2.5 Affiliates ([CUSTOMER]'s rewrite would have created a [PARENT_GROUP_EXAMPLE] Group backdoor; [VENDOR]'s reinstate-with-invitation forces [CUSTOMER] to disclose without naming [PARENT_GROUP_EXAMPLE]).

### Pattern B, Accept-with-refinement

When the customer's change is structurally reasonable but slightly overreaches:
1. Accept the structure
2. Tighten one or two specific elements (trigger threshold, scope limiter, qualifier removal)
3. State what's accepted and what's refined in 2 sentences

**Used at:** Section 2.3 DPA Updates ([VENDOR] accepted [CUSTOMER]'s consent gate, tightened the trigger to "materially adversely" and scoped it to "under this Agreement").

### Pattern C, Market-standard rejection

When the customer asks [VENDOR] to deviate from a standard vendor position:
1. Frame the position as market-standard / industry-norm
2. State [VENDOR]'s narrow give (what [VENDOR] commits to in place of the customer's broader ask)

**Used at:** Section 2.4 Third Party Products (AS IS / AS AVAILABLE is the standard SaaS vendor position; [VENDOR] offers responsibility for non-negligent selection and [VENDOR]'s own integration code only).

### Pattern D, Discovery-invitation-without-disclosure

When the customer has corporate-structure or use-case information you want them to volunteer:
- Don't telegraph that you've identified it
- Ask the customer to explain in their own words
- This forces disclosure on the record

**Used at:** Section 2.5 Affiliates ([PARENT_GROUP_EXAMPLE] angle stays internal, [CUSTOMER] has to surface their parent themselves).

### Pattern E, Strategic give-back

When a customer makes multiple changes to the same clause/section, accept a low-cost technical change to bank goodwill while rejecting the substantive ones:
1. Identify the smallest customer change that has minimal [VENDOR]-risk
2. Accept it cleanly (often without comment)
3. Use the accepted change to signal good-faith engagement so the more substantive rejections in the same clause land better

**Used at:** Section 5.2 [VENDOR_EXAMPLE] IP ([USER_NAME] accepted [CUSTOMER]'s "for" → "on behalf of" change as a low-cost technical concession while holding firm on rejecting the Joint Workflows carve-out and restoring sub-clause (d)).

### Pattern F, Deny-the-premise

When a customer-side carve-out is trying to mitigate a risk that does not actually exist in the product or contract structure, reject by denying the premise of the concern rather than offering a compromise:
1. State the operative reality (e.g., what the Platform actually does)
2. Conclude that the customer's proposed mitigation addresses a non-issue
3. No compromise offered, there's nothing to compromise on

**Used at:** Section 5.2 [VENDOR_EXAMPLE] IP ([USER_NAME]'s argument: Platform tooling is uniform across customers, customer USE is unique, therefore [CUSTOMER]'s "Joint Workflows" carve-out is mitigating a non-issue because customer use is not customer IP).

This pattern is STRONGER than offering a compromise because it removes the premise. Use it when the customer's drafting reflects a misunderstanding of how the product or contract actually works.

---

## Architectural principles

### Positive responsibility vs risk allocation

Established 2026-05-28 during [VENDOR_EXAMPLE] Section 7.4 review.

| Section type | Architectural role | Where in [VENDOR_EXAMPLE] MSA |
|---|---|---|
| **Operational commitment** | [VENDOR] positively commits to provide the Service | Section 2.1, Section 3.1 |
| **Warranty** | [VENDOR] represents and warrants performance standard | Section 7.2 |
| **Risk allocation (disclaimers)** | What [VENDOR] is NOT promising | Section 7.4 |
| **Risk allocation (caps)** | Limits on [VENDOR]'s damages exposure | Section 8 |
| **Risk allocation (indemnity)** | Who covers whom for third-party claims | Section 9 |

**Rule:** positive [VENDOR] commitments belong in Section 2, Section 3, or Section 7.2. They do NOT belong in Section 7.4, Section 8, or Section 9.

**Why this matters:** when a customer pushes positive [VENDOR] commitments INTO the risk-allocation sections (e.g., adding a counter-warranty to Section 7.4 to "balance" the AS-IS), the result is structurally incoherent. A court is then asked to choose between contradictory clauses. The clean answer is to relocate the positive commitment to the right architectural home (operations, warranties), or to reject it if it does not belong anywhere in the agreement.

**Used at:** Section 7.4 AS-IS pushback ([CUSTOMER] added a safeguards warranty in 7.4; [VENDOR]'s structural answer is to either relocate to Section 7.2 if substantively acceptable, or reject the substance and explain why a warranty is the wrong mechanism for AI output safeguards).

---

## Mechanism explanations (for educating customer's counsel)

When the customer pushes back on a clause because they don't understand its mechanism, the answer is education, not citation. These are mechanism explanations to use in customer-facing comments.

### Mechanism: Section 7.4 AS-IS for AI hallucinations

Section 7.4 does not exclude [VENDOR]'s responsibility for the Platform. It distinguishes between the SERVICE and individual OUTPUTS, which is the structural mechanism necessary for AI service delivery:
- **Service** = warranted in Section 7.2 (Platform performance in accordance with Documentation)
- **Output** = allocated in Section 7.4 (cannot be warranted because generative AI is probabilistic by design)

The split is what makes AI service delivery contractually workable: a vendor can commit to how the Service operates; a vendor cannot commit to the specific content of any individual generated output without misrepresenting the technology.

**Used at:** Section 7.4 response to [CUSTOMER]'s Com:128 ("VERY HIGH RISK") concern.

### Mechanism: Section 8.1 loss-of-data carve-out

"Loss of data" sits in Section 8.1 as a categorical exclusion because data loss damages are by nature consequential. Their value is measured by downstream regulatory, reconstruction, and business-interruption effects, not by direct contractual valuation. Putting "loss of data" inside the direct-damages path would create unbounded valuation exposure for [VENDOR] while bypassing the structured data protection framework that lives in the DPA (Section 5 security, Section 5.2 incident notification), MSA Section 5.10(b) (Customer's backup responsibility), and Section 9.2(a) indemnification for [VENDOR]'s gross negligence in data handling (uncapped per Section 8.3(b)).

**Used at:** Section 8.1 response to [CUSTOMER]'s strike of "DATA" from the consequential damages list.

### Mechanism: GDPR "process" alignment in DPA definitions

When a customer changes DPA terminology to use GDPR-defined terms (e.g., "process" instead of "know or otherwise access"), this is terminology alignment, not substantive expansion. [VENDOR]'s actual sub-processors are the same set under either definition. Accept these alignments as a low-cost good-faith engagement.

**Used at:** DPA Section 1.1 Authorized Sub-Processor definition ([CUSTOMER] changed "know or otherwise access" → "process" to align with GDPR Article 4(2); [VENDOR] accepted).

---

## Clause-specific fallback positions

Established by [USER_NAME] during specific clause negotiations. Saved as candidate fallback moves if the counterparty pushes back; not yet locked in as playbook canon until used and confirmed.

### Section 5.9 No Challenge, breach remedy preservation fallback

**Context:** vendor-side review. [VENDOR] struck a customer's explicit "(iii) breach of Agreement" carve-out from the no-challenge clause, relying on the implied principle that no-challenge clauses don't override standard breach remedies. Comment cites Sections 8 and 9 as already addressing customer's preservation.

**Risk:** the implied-principle reading is generally how courts read no-challenge clauses, but not airtight. Counterparty may push back asking for explicit protection.

**Fallback if pushed:** offer to add a single sentence confirming 5.9 does not restrict Customer's right to bring breach claims under this Agreement. This is a give-back [VENDOR] can afford because it does not grant Customer anything substantively new; it confirms the structural reading [VENDOR] is already relying on.

**Established:** 2026-05-28 during [VENDOR_EXAMPLE] case study work. Source: conversation reviewing Section 5.9 after [USER_NAME]'s "Accepted as modified" comment.

---

## Role split

| Role | Action |
|---|---|
| **Mage** | Produces per-clause proposals (redlines to apply + 2-sentence comment) |
| **Attorney** | Applies redlines in Word, pastes comments, owns the final deliverable |
| **Adeu** | Currently NOT the right tool for [VENDOR]-side counter-redlines (architectural limit) |
| **Word** | The right tool for layered tracked changes; the attorney's environment |

---

## Hard rules

- **No em dashes anywhere** (chat, drafts, comments)
- **2-sentence customer-facing cap** (no exceptions)
- **Mage labels internal-planning comments as such**, never sends them to the counterparty
- **Mage produces proposals, attorney applies redlines in Word**
- Before any change to live docx via Adeu: confirm with attorney

---

## Open / next

- [ ] **Ingest [USER_NAME]'s final [VENDOR_EXAMPLE] redline + comments** (whenever she finalizes the file going back to [CUSTOMER] / [VENDOR]). Extract her actual positions per clause and commit them to the commercial-legal CLAUDE.md as vendor-POV playbook entries. This is the canonical source of [VENDOR]'s positions, not Mage's drafts.
- [ ] **Set up commercial-legal plugin (Anthropic)**, cold-start interview to populate broader playbook positions, escalation matrix, risk posture, etc.
- [ ] **Find Word integration for Mage**, Copilot in Word? Office.js skill? Direct add-in? The chat-based visual mock is not a workable UI long-term.
- [ ] **Contribute msa-respond-vendor-side skill to lq-skills** built from this methodology
- [ ] **Strip the 14 bad-format Mage comments** from `[VENDOR_EXAMPLE] - Case Study - Mage Comments v2.docx` once [USER_NAME] confirms (those were internal-planning style; they should not be in a customer-facing file)

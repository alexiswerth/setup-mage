# Capture-the-How Pattern

*A method for capturing a practitioner's professional JUDGMENT (the how) as reusable, de-identified playbook entries, while leaving the underlying matter content (the what) behind.*

**Originally built for**: a commercial lawyer building a personal playbook from their own work, to consult their own prior judgment the way they'd consult a trusted colleague
**Generalizes to**: any knowledge worker who wants a reusable playbook of their craft (review patterns, negotiation moves, drafting techniques) that stands on its own, free of any confidential matter content

---

## The problem this pattern solves

Your professional judgment lives inside your work product: the way you respond to a counterparty's edit, the reasoning behind accepting one ask and countering another, the phrasing register you use in customer-facing comments. That judgment is yours. The documents it lives in usually are not.

So when you want to consult your own past craft ("how do I usually handle this clause? why did that approach work?"), you hit a wall:

- **Reread the old documents** → every consultation drags confidential content, customer data, and matter specifics back into view, and ties your craft to files you may not always control.
- **Work from memory and rebuild from scratch** → this is the fundamental failure. Judgment built over years of matters does not survive a from-scratch rebuild; you keep the instincts but lose most of the reasoning, the anchors, and the phrasing that made each move work. Every undocumented playbook gets rebuilt smaller than it was.

The middle path: extract the RULE behind each move, anchor it in PUBLIC sources (statutes, case law, market norms), generalize it to peer-level, and scrub it. The playbook you get is methodology a peer at any company could apply, consultable any time, with everything matter-specific left where it belongs, and nothing lost to the rebuild.

**A note on method**: machine-assisted re-authoring goes a half-step beyond rewriting purely from memory, so the pattern keeps a human in the loop at both ends: you decide what goes in, and you review every entry before it goes anywhere. If your agreements or professional rules raise questions, a quick counsel check before scaling is cheap insurance.

---

## The entry template (RULE-FIRST)

One entry = one RULE, not one clause. A rule is transferable: "When X, I do Y, because Z." The specific moves in a given matter are APPLICATIONS of the rule. If you can only describe what you did in one clause (context), it is not an entry yet; find the rule, or merge the move into an existing rule.

```markdown
## RULE: [the transferable principle: "When X, I do Y, because Z"]

- **Anchor (REQUIRED):** [case / statute / market norm]
- **Applications (in this matter, generic):**
  - [the specific move + technique that applied the rule]
  - [another application of the SAME rule, if any, cluster them here]
- **Voice note:** [how I phrase the customer-facing comment, in my register]
- **Provenance:** authored [YYYY-MM-DD], own time + own equipment,
  source = general professional knowledge + the anchor above. Scrubbed: yes.
```

---

## The 4 gates (every entry must pass all four)

| # | Gate | The question | Fails if |
|---|---|---|---|
| 1 | **RULE** | Does this state a reusable when/do/because rule, not just what I did in one clause? | It only describes a move in context. Context is not a rule. |
| 2 | **PUBLIC ANCHOR** | Is the reasoning grounded in a named public source (statute, case, published market norm)? | The only support is "that's how we did it at [employer]." |
| 3 | **GENERALIZE** | Could a peer at another company apply this rule on a different deal? Re-author to peer-level: generic labels (the customer / the vendor / us), clause referenced by TYPE not section number. | Indirect identifiers survive: deal amounts, dates, unique phrasing, a fact pattern recognizable as one specific matter. |
| 4 | **SCRUB** | Zero names, numbers, positions, or verbatim text from the source material? | Anything verbatim or identifying remains. |

Why gate 3 matters most: direct identifiers (names, emails, orgs) are catchable by tools (see `local-pii-detection-pattern.md`). INDIRECT identifiers (amounts, dates, distinctive phrasing, the fact pattern itself) are not; they re-identify by context. The generalization gate closes that hole by construction: you re-author the move at peer-level, so matter-specific context never enters the entry in the first place. Tools are necessary, not sufficient; the gates plus human review carry the real weight.

---

## Worked example (4 entries from one clause family)

These four de-identified entries were produced by this method from a SaaS DPA subprocessor clause (vendor side). They show what passing output looks like.

### Move subproc-list-location : put the subprocessor list where the customer can trust it

- **Clause type (generic):** subprocessor list location in a SaaS DPA
- **The move:** relocate the subprocessor list out of a live vendor-controlled web link (a "trust center" page the vendor edits at will) and into the DPA itself.
- **Technique:** delete the hyperlink reference at the start of the sentence, insert "subprocessors set forth in the DPA" ahead of the deletion so the redline reads clean.
- **Reasoning:** SaaS vendors keep the subprocessor list at a hyperlink and notify before updating it; individualized objection periods or custom notification per customer is operationally impossible at scale, so the general-authorization model is the industry standard. When a customer is uncomfortable with a link the vendor can change unilaterally, give them the DPA as the anchored location instead. Same mechanism, a home the customer trusts.
- **Public anchor:** GDPR Art. 28(2) (general written authorization; processor informs of intended addition/replacement of subprocessors, controller may object); standard SaaS subprocessor-notice practice.
- **Voice note:** "Accepted as slightly modified." Short, accommodating, anchored in what is standard.
- **Provenance:** authored on own time + own equipment, general professional knowledge + the anchor above. Scrubbed: yes.

### Move subproc-notice-period : accept a reasonable advance-notice ask

- **Clause type (generic):** subprocessor change-notice in a SaaS DPA
- **The move:** accept a customer's request for a defined advance-notice period (e.g. a set number of days) before a new subprocessor is added.
- **Technique:** accept the counterparty's insertion; conform the surrounding language so the notice and objection terms read together.
- **Reasoning:** normal practice is a pre-update notice to the admin on file (email or in-app); a defined notice window is a reasonable, low-cost way to operationalize the controller's right to object. Accept reasonable, norm-aligned asks; they bank goodwill cheaply.
- **Public anchor:** GDPR Art. 28(2) (opportunity to object); market norm of advance subprocessor notice.
- **Voice note:** accept cleanly, often without a long comment.
- **Provenance:** authored on own time + own equipment, general professional knowledge + the anchor above. Scrubbed: yes.

### Move mechanism-flow-through : propagate a mechanism change everywhere it is referenced

- **Clause type (generic):** cross-clause consistency after changing a mechanism
- **The move:** when you change the mechanism in one place (e.g. where the subprocessor list lives), carry the change through every dependent term (objection, notification) and mirror it across documents (DPA and MSA).
- **Technique:** trace the references; fix each dependent clause so none points at the old mechanism.
- **Reasoning:** a mechanism change orphans the clauses that reference the old one if you do not propagate it, leaving internally contradictory terms. Consistency prevents a later dispute over which clause governs.
- **Public anchor:** general contract-drafting practice (internal consistency; courts construe against conflicting provisions). Market/drafting norm.
- **Voice note:** usually no customer-facing comment; this is internal discipline.
- **Provenance:** authored on own time + own equipment, general professional knowledge + the anchor above. Scrubbed: yes.

### Move accept-restatement-of-law : if their ask only restates the governing law, take it

- **Clause type (generic):** subprocessor liability standard in a SaaS DPA
- **The move:** accept the customer's "vendor remains fully liable for its subprocessors, as if it performed the acts itself."
- **Technique:** accept the counterparty insertion; no counter needed.
- **Reasoning:** the wording just restates the governing legal standard, so accepting costs nothing and signals good faith. When a counterparty asks for something the law already requires of you, take it rather than fight a phantom concession.
- **Public anchor:** GDPR Art. 28(4) (the initial processor remains fully liable to the controller for a subprocessor's failures).
- **Voice note:** accept cleanly; can note it reflects the statutory standard.
- **Provenance:** authored on own time + own equipment, general professional knowledge + the anchor above. Scrubbed: yes.

---

## How to apply (6 steps)

1. **Pick a source artifact you have clean rights to work from.** Best case: your own work product with no NDA attached (pro bono work, published writing, personal projects). If working from employer material, get the legal posture settled first (see the note on method above).
2. **Decompose change-by-change.** Every edit is a decision, including silent edits with no comment. List them.
3. **For each move, ask WHY, and capture the answer in the practitioner's own words.** Bottom-up only: show the change, ask, record. Never pre-fill the reasoning for them; pre-filled reasoning is the tool's judgment, not theirs.
4. **Find the RULE behind the move** (gate 1). Cluster multiple moves that apply the same rule into one entry.
5. **Anchor, generalize, scrub** (gates 2-4). Name the public source. Re-author at peer-level. Strip everything specific.
6. **Human review on every entry before it enters the playbook.** Then run the entry file through your local PII detection layer (see `local-pii-detection-pattern.md`) as a fail-closed backstop.

---

## When to use this pattern

- **Consulting yourself**: building the playbook you wish you could ask a trusted colleague for, except the colleague is you, three deals ago
- **Building a practice playbook** from finished matters, one clause family at a time
- **Training a domain agent** on your judgment: rule-first entries are exactly the shape an agent playbook needs
- **Mentoring**, when you want to hand a junior the transferable rules without handing them confidential matter files

---

## Complementary patterns

- **Local PII Detection Pattern** (`local-pii-detection-pattern.md`): the tooling backstop for gate 4 (scrub). Catches direct identifiers; the generalization gate handles the indirect ones.
- **Super-Playbook Pattern** (`super-playbook-pattern.md`): where the captured entries can land, a paste-in master brief that turns the AI into a domain-aware reviewer.

---

*Pattern version: v1 (2026-06-09). Derived from a real pilot: 4 gates, rule-first entries, public-anchor discipline, piloted on the author's own no-NDA work product.*

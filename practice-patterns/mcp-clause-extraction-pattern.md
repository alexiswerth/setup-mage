# MCP Clause Extraction Pattern

*A reusable methodology for building a contract negotiation playbook from a CLM (Contract Lifecycle Management) tool using its MCP connector, even when the MCP has data access limitations.*

**Originally built for**: extracting SSA + DPA positions from a CLM system via MCP
**Generalizes to**: any domain where you need to extract structured knowledge from a tool that only exposes an AI-powered conversational search API

---

## The problem this pattern solves

Your CLM tool has an MCP connector. You want to build a playbook from your actual executed contracts. But the MCP has limitations: capped results per query, no pagination, no bulk export, unreliable counts. You can't just ask "give me everything."

This pattern works around those constraints by querying **by clause area** rather than by individual contract, letting the MCP's AI do the cross-contract synthesis on the server side.

---

## The approach: clause-area queries

Instead of:
- "Give me contract IC-12345" (one contract at a time, slow, hits caps)
- "List all SSAs" (capped at ~20, can't paginate)

Do this:
- "What are [COMPANY]'s standard positions on limitation of liability in recently negotiated agreements?"
- "What indemnification provisions have been negotiated? Show specific language and counterparty names."
- "What are the most commonly negotiated or disputed clauses?"

Each query asks the MCP to **synthesize positions across its full index** for one topic. The AI searches broadly even though it only surfaces ~20 contracts in the response. You get the positions (which is what you need for the playbook), even if you can't enumerate every contract.

---

## Query design principles

1. **One clause area per query.** Don't combine topics. "Limitation of liability" is one query. "Indemnification" is another. Combining them dilutes the results.

2. **Ask for specifics.** "Show the specific language" and "include counterparty names" produce verbatim clause text you can use. Generic questions get generic answers.

3. **Ask for variations.** "Show standard language AND any negotiated variations" surfaces both your template position and what you've actually agreed to in practice.

4. **Run a meta-query.** Ask "what are the most commonly negotiated or disputed clauses?" to understand where customers push back most. This helps you prioritize playbook sections.

5. **Batch in parallel.** If your tool supports parallel queries, run 3 at a time. Batch by independence (liability + indemnification + termination can run together; they don't depend on each other).

6. **Use the fastest model tier available.** These are synthesis queries, not complex reasoning. Speed matters more than depth.

---

## Playbook structure (per section)

For each clause area, the playbook should capture:

| Element | What it contains |
|---|---|
| **Standard position** | Your template language / starting point |
| **Common customer asks** | What counterparties typically push back on |
| **Fallback position** | What you've actually agreed to (with anonymized deal examples) |
| **Redline / reject** | What you do not accept, period |

This structure gives a reviewer everything they need: what to start with, what to expect, how far to go, and where to stop.

---

## SSA sections to query (commercial-legal)

These are the core clause areas for a SaaS subscription agreement playbook. Adapt for your contract type.

1. Term, renewal & termination (including termination for convenience, auto-renewal)
2. Limitation of liability (caps, super caps, excluded damages, remediation carve-outs)
3. Indemnification (IP indemnity, expanded indemnity, mutual vs. one-way)
4. Warranties & disclaimers (performance warranty, "as is" disclaimers, compliance warranties)
5. Confidentiality (scope, exclusions, survival)
6. Governing law & dispute resolution (jurisdiction, venue, arbitration)
7. Insurance (coverage types, minimums, certificate requirements)
8. SLA / uptime / support (availability commitments, service credits, response times)
9. IP ownership / license scope
10. Use restrictions / acceptable use
11. Assignment / change of control
12. Force majeure
13. Most commonly negotiated provisions (meta-query for prioritization)

---

## DPA sections to query (privacy/data protection)

1. Scope of processing (Annex 1 details: data subjects, data categories, processing activities)
2. Sub-processors (list, notification, objection rights)
3. Data subject rights (assistance obligations, response timelines)
4. Cross-border transfers / SCCs
5. Breach notification (timeline, method, scope)
6. Audit rights (scope, frequency, alternatives)
7. CCPA / state privacy law provisions
8. Data retention & deletion (timelines, methods, certification)

---

## Measuring coverage

The MCP won't tell you how many total contracts exist (its counts are unreliable). To measure coverage:

1. **Track unique contract IDs** across all queries. Each response includes record references. Deduplicate them.
2. **Cross-reference with an external count** if available (your legal ops reporting, CLM admin console, or team knowledge of deal volume).
3. **Accept that this is a sample, not a census.** The positions are synthesized from the MCP's full index, but you can only verify the contracts it cites.
4. **Document the gap** so stakeholders know the playbook is based on [N] contracts, not the full population.

---

## When this pattern breaks down

- **You need verified full-population coverage** (e.g., for regulatory reporting). The MCP can't provide this. You need a data warehouse approach (see: CLM-to-warehouse pipeline pattern).
- **Your CLM has no MCP or API.** You're stuck with manual extraction.
- **Your contract volume is very small** (<20 contracts). Just pull them individually; the clause-area approach adds overhead for small populations.
- **The MCP's AI synthesis is unreliable for your domain.** Test with a few contracts you know well. If the synthesis misrepresents positions, the pattern won't work.

---

## Complementary patterns

- **Super Playbook Pattern** (`super-playbook-pattern.md`): Once you've extracted positions using this pattern, the super playbook pattern structures them into a paste-in brief for AI-assisted document review.
- **CLM-to-Warehouse Pipeline Pattern** (`clm-to-warehouse-pipeline-pattern.md`): When MCP limitations block full population access, this pattern moves your contract data to a queryable warehouse.

---

*Pattern version: v1 (2026-06-05). First derived from a real-world build extracting positions from a CLM MCP connector across 63 contracts.*

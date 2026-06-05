# MCP Limitations Audit Pattern

*A reusable checklist for testing the actual data access capabilities of any MCP connector before building a workflow that depends on it.*

**Originally built for**: discovering hard limits in a CLM MCP connector after it returned unreliable data
**Generalizes to**: any MCP connector you're evaluating for production use

---

## The problem this pattern solves

MCP connectors look powerful in demos. In production, they often have undocumented limitations: capped results, no pagination, unreliable AI-generated counts, restricted tool scopes. If you build a workflow that depends on full data access and discover the caps later, you've wasted time and need to re-architect.

This pattern front-loads the discovery. Run it before committing to an MCP-dependent workflow.

---

## The audit (7 tests)

Run these tests in order. Each one reveals a specific constraint.

### Test 1: Smoke test
**Query:** Ask for a simple, known result (e.g., "list recent [document type]").
**What you learn:** Does the MCP return data at all? Are results structured? Do you get record IDs/URLs?
**Pass/fail:** If this fails, stop. The connection isn't working.

### Test 2: Record cap
**Query:** Ask for "all" of something you know has more than 20 items (e.g., "list all contracts of type X").
**What you learn:** How many records come back? Is there a cap? Count the records in the response, not the text summary (the AI text may say a different number than what's in the records field).
**Red flag:** If the response says "20" and the records field has exactly 20, you've likely hit a cap, not a real count.

### Test 3: Pagination
**Query:** Look for pagination tokens, offset parameters, or "next page" mechanisms in the response.
**What you learn:** Can you get the next batch of results?
**Red flag:** No pagination = the record cap is a hard ceiling on per-query visibility.

### Test 4: Count accuracy
**Query:** Ask "how many total [items] are in the system?" Compare the text answer to: (a) the number of records returned, and (b) any external count you have (admin console, ops reporting, team knowledge).
**What you learn:** Whether the AI can accurately count its own data.
**Red flag:** Count in text differs from records returned, or differs from your known count. This means the AI is guessing, not querying.

### Test 5: Cross-query deduplication
**Query:** Run 5-10 different queries on overlapping topics. Collect all record IDs. Deduplicate.
**What you learn:** How many unique records the MCP surfaces across multiple queries. This is your effective reach -- likely much higher than any single query.
**Document:** Total unique records found / estimated population = coverage percentage.

### Test 6: Bulk export
**Query:** Ask explicitly: "export all [items]" or "give me a complete list."
**What you learn:** Whether bulk export is supported.
**Red flag:** If the response caps at the same number as Test 2, bulk export doesn't exist regardless of what the docs say.

### Test 7: Tool scope
**Query:** List all available tools/endpoints the MCP exposes. Check for: read-only vs. read-write, search vs. enumerate, conversational vs. structured.
**What you learn:** What the MCP can actually do vs. what you assumed.
**Red flag:** "Conversational search only" means you can't enumerate, filter, sort, or count reliably. You're dependent on the AI's interpretation of your query.

---

## Output template

After running the audit, document your findings:

```
## MCP Audit: [Tool Name]
**Date:** [date]
**Connector version:** [if known]

### Results

| Test | Result | Notes |
|---|---|---|
| 1. Smoke test | Pass/Fail | |
| 2. Record cap | [N] records max | |
| 3. Pagination | Yes/No | |
| 4. Count accuracy | Accurate/Unreliable | Text said [X], records showed [Y], actual is [Z] |
| 5. Cross-query reach | [N] unique records across [M] queries | Coverage: ~[P]% of estimated population |
| 6. Bulk export | Yes/No | |
| 7. Tool scope | [list tools/endpoints] | |

### Constraints summary
[1-2 sentences on the hard limits]

### Viable for
[what workflows this MCP CAN support given the constraints]

### Not viable for
[what workflows require a workaround or different approach]

### Recommended workaround
[if constraints block your use case, what's the alternative?]
```

---

## When to run this audit

- **Before building any workflow** that depends on full data access from an MCP
- **When an MCP-dependent workflow starts returning unexpected results** (empty responses, wrong counts, missing records)
- **When evaluating a new MCP connector** for production adoption
- **After an MCP update** that might have changed rate limits or capabilities

---

## Complementary patterns

- **MCP Clause Extraction Pattern** (`mcp-clause-extraction-pattern.md`): The workaround for when the audit reveals data caps. Query by topic instead of by record.
- **CLM-to-Warehouse Pipeline Pattern** (`clm-to-warehouse-pipeline-pattern.md`): The long-term fix when MCP limitations are permanent.

---

*Pattern version: v1 (2026-06-05). First derived from a real-world audit that discovered a CLM MCP was capping at ~20 records, returning counts off by 6.5x, and had no pagination or bulk export.*

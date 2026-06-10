# Local PII Detection Pattern

*A defense-in-depth setup for detecting and scrubbing PII on your own machine, BEFORE anything reaches a cloud LLM. Two complementary local tools plus a deterministic term list, unioned.*

**Originally built for**: a legal practitioner's "Wall 1" (sanitize before the cloud) gate, feeding a judgment-capture workflow
**Generalizes to**: anyone who needs confidential names, orgs, or matter data kept out of cloud AI context (RPC 1.6 duties, NDAs, corporate AI policy)

---

## The problem this pattern solves

If your master agent runs on a cloud LLM, anything you paste or pipe into it leaves your machine. A confidentiality duty (professional rules, NDA, employer policy) means the sanitization has to happen LOCALLY, outside the conversation, before the text goes up. You cannot ask the cloud model to scrub the data, because asking is itself the disclosure.

The catch: no single local tool catches everything. Empirically (same synthetic input through two well-regarded tools):

| PII type | NER tool (names-focused) | Wrapper tool (org-focused) |
|---|---|---|
| Person names | ✓ caught | ✗ MISSED (flaky) |
| Organization names | ✗ missed | ✓ caught |
| SSN / account numbers | ✓ | ✓ |
| Email / phone | ✓ | ✓ |

One tool is a hole. The pattern is: **run BOTH, union the detections, add a deterministic term list for the names you already know matter, and fail CLOSED.**

---

## The three layers

1. **A names-reliable local NER model** (example: OpenAI's open-source `privacy-filter`, "opf": ~600MB local model, 8 PII categories, strong on person names). Detect + mask. Runs fully offline after a one-time model download.
2. **An org-reliable tool with round-trip restore** (example: a local anonymize/restore CLI that keeps a key drawer on disk). Use it for organization detection, and for the send-a-real-doc-to-cloud-and-back flow where you need to restore the original names afterward.
3. **A deterministic term list** (`terms.txt`): the specific names, orgs, codenames, and matters YOU know are sensitive. Plain string substitution, case-insensitive. NER is probabilistic; this layer is not. It catches the known-critical terms every time.

---

## Vet before you install (the method matters as much as the tools)

Before any PII tool touches real data, run a read-only code audit on a clone in a throwaway directory. Two independent review angles:

- **Execution / supply chain**: install-time or import-time code execution? subprocess/shell-outs? eval/pickle/dynamic imports? telemetry or auto-update phone-home? postinstall hooks? (Install Node packages with `--ignore-scripts` and build explicitly.)
- **Data flow / network**: enumerate every network call. Confirm input text and detected PII stay in memory. Find every code path that writes input text to disk and decide whether each is acceptable.

What this caught in practice, on tools that passed overall:

- An `eval`/`train` mode that writes the FULL original text + detected PII to disk by design. Verdict: use `redact` mode only on real PII.
- A scan output that includes the ORIGINAL text alongside the redacted version (for QA). Verdict: forward only the redacted field downstream.
- A scan tool variant that leaks raw detected entities back into LLM context. Verdict: never call it from an agent; file-based CLI only.

---

## Fail-closed wiring (the lesson that matters most)

A detector that silently fails is worse than no detector, because you stop checking by hand. Wire the gate so that **an unknown detection, a missing output file, or a failed verification BLOCKS the action** (the push, the upload, the prompt), rather than warning and proceeding.

Hard-won specifics:

- **Case-insensitive substitution.** A case-sensitive name substitution let an ALL-CAPS instance of a known name slip through to the public repo's staging. Use `/gi`, not `/g`.
- **NER as the backstop on the OUTPUT.** After deterministic substitution, run the NER model over each sanitized file. Any leftover detected person name = block the push. This is the layer that catches the name you forgot to add to terms.txt.
- **Do not trust exit codes.** One tool's native runtime (onnxruntime) crashes on process EXIT after the work completes, clobbering the real exit code every run. The reliable success signal is OUTPUT-BASED: confirm the output file exists, then run the tool's own `verify` command and read its "verified clean" line.
- **Pin the runtime device.** A model that defaults to CUDA will fail or misbehave on a Mac; wrap the CLI to force `--device cpu`.
- **Keep the key drawer out of backups.** If your tool stores anonymize/restore mappings on disk, exclude that directory from any backup or sync that leaves the machine. Prefer allow-list backups (only named files travel) over deny-list.
- **Egress-block the tool's process** (a firewall rule) once the one-time model download is done. Local should be verifiably local.

---

## Known limits (be honest about them)

- **Tools catch DIRECT identifiers only** (names, emails, orgs, SSNs). INDIRECT identifiers (deal amounts, dates, unique phrasing, a recognizable fact pattern) re-identify by context, and no detector catches them. Close that hole upstream by construction (see `capture-the-how-pattern.md`, gate 3: generalize to peer-level) plus human review. Tools are necessary, not sufficient.
- **Hybrid beats any single approach.** Community testing across multiple legal-tech builders converged on the same answer: regex + NER together outperform any one tool, and the differences between leading NER tools are smaller than the gap between one-layer and multi-layer setups.
- **Name recall in NER is inconsistent across tools.** One tool caught a person name in one sentence and missed the SAME name in a near-identical sentence. Test recall yourself on synthetic data before trusting any tool with a category.

---

## How to apply (5 steps)

1. **Pick one names-reliable NER tool + one org-reliable tool.** Vet both with the read-only audit above before installing.
2. **Install isolated** (Python venv / `npm ci --ignore-scripts`), wrap each CLI in a small script that enforces the guardrails (device pin, safe mode only, output-based verification).
3. **Smoke-test on synthetic data** containing every PII category you care about. Record which tool catches what; that table is your routing logic.
4. **Populate `terms.txt`** with your known-sensitive names, orgs, and codenames. Wire it as case-insensitive substitution that runs FIRST.
5. **Wire the union into your gates, fail-closed**: pre-push (block on any leftover detection in files headed to a repo) and pre-cloud (scrub any document before it enters an LLM conversation).

---

## When to use this pattern

- **Before any workflow that sends documents or pasted text to a cloud LLM** under a confidentiality duty
- **Before publishing anything from a workspace that also holds confidential material** (the pre-push backstop)
- **When de-identifying captured work product** (the scrub gate of `capture-the-how-pattern.md`)

---

## Complementary patterns

- **Capture-the-How Pattern** (`capture-the-how-pattern.md`): the upstream fix for indirect identifiers that no tool catches.
- **Git Identity Guard Pattern** (`git-identity-guard-pattern.md`): the same fail-closed philosophy applied to commit identity.

---

*Pattern version: v1 (2026-06-09). Derived from a real two-tool install + vet (one NER model, one anonymize/restore CLI), smoke-tested on synthetic data, and one real near-miss that turned the design fail-closed.*

# Redline Prompting Pattern (vendor-side, counterparty paper)

*A reusable prompt structure for AI-assisted counter-redlines when the counterparty insists on their paper instead of your template.*

---

## The pattern

Attach your org's standard template as the source of truth, then prompt:

> "Take the positions in our standard [AGREEMENT TYPE] template attached here and redline this counterparty paper accordingly. Use a [TOUCH LEVEL] touch. We don't want to be prohibitive, but we want to protect ourselves as the [VENDOR/CUSTOMER] given the counterparty is insisting on their paper."

## Why it works

1. **Template as source of truth.** Instead of enumerating every position in the prompt, attach the template that already encodes them. Shorter prompt, fewer transcription errors, positions stay current with the template.
2. **Explicit calibration ("touch level").** Tells the AI how aggressive to be, which a position list alone never conveys.
3. **Orientation framing.** "Protect ourselves as the vendor" sets whose interest governs every close call.
4. **Scenario flag.** Naming it as counterparty paper triggers the org's counterparty-paper playbook conditions, if any.
5. **Short and declarative.** No over-engineering. The template carries the substance; the prompt carries the calibration.

## The touch-level parameter

| Level | When | What the AI does |
|---|---|---|
| **Heavy** | Deal-breaker provisions present, high-risk paper | Rigorous, position-by-position, full comments |
| **Medium (default)** | Standard negotiation | Protect core positions, concede cosmetics |
| **Light** | Low-risk, relationship-priority deals | Cosmetic + critical-only |

Match touch level to severity: default medium-light, escalate to heavy when a deal-breaker provision is triggered. Side-by-side outputs at multiple levels are usually overkill.

---

*Pattern derived from real vendor-side practice, fully genericized. Positions and templates are yours to supply.*

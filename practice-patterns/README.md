# Practice Patterns

*Generic, parameterized patterns for adopting Mage-style workflows in specific domain contexts. Each pattern is a template you can fill in for your own org, role, and tooling.*

---

## What's a practice pattern?

A **practice pattern** is the **STRUCTURE** of a Mage workflow without the **CONTENT**. It captures the methodology — how to organize a master agent brief, how to instrument an Apprentice for a specific task type, how to gate a workflow with policy checks — but leaves the actual specifics (clauses, positions, customer names, dollar amounts) for you to fill in based on your context.

Patterns are at the **Tier 2** sanitization level (see `../mage-operating-principles.md` Section "Sanitization Tier Model"):

- They reference **identifying-but-not-confidential** facts like "this pattern targets Claude for Word" or "this pattern works with Drata's setup" — because the AI model name or one example org name doesn't expose confidential information.
- They DO NOT contain **real names of people** (replaced with `[MANAGER]`, `[CISO]`, etc.), **specific dollar amounts**, **real customer names**, **internal positions**, or **specific contract section numbers** tied to a specific org's templates.

## Sanitization rationale (the why)

When converting a Tier 0 work product (real playbook, real positions, real names) to a Tier 2 pattern for setup-mage, we apply these rules:

| Keep | Replace | Strip |
|---|---|---|
| Company name (Drata) — identifying-not-confidential | Real names of people → `[MANAGER]` / `[CISO]` / `[GRC_LEAD]` / etc. | Specific dollar amounts |
| LLM name (Claude / Anthropic) — identifies the model these instructions target | Customer names → `[CUSTOMER]` | Project codenames |
| Generic tech stack categories (cloud provider, LLM gateway, etc.) — generic infra references | Specific contract sections tied to one org's template → generic descriptions | Internal Slack channel names, internal email addresses, specific vendor names that aren't already publicly disclosed |
| Generic framework structure | Position library content → "this is where you put your positions" guidance | Specific internal process names (specific ticketing tool, specific escalation paths) — replaced with generic concepts |

**The principle**: the FRAMEWORK and METHODOLOGY are reusable across any org. The CONTENT (who, what, how much) is org-specific and stays in your private Tier 0 repo.

## Patterns in this directory

| File | What it covers | Mature? |
|---|---|---|
| `super-playbook-pattern.md` | Building a paste-in master agent brief for Claude for Word that turns the AI into a domain-aware reviewer (originally built for commercial-legal SSA/DPA reviews) | ✅ first stable pattern |

More to come as patterns prove themselves in real Mage instances.

## How to use a pattern

1. Read the pattern doc end-to-end
2. Identify which sections apply to YOUR domain (some may not)
3. Fill in each section's placeholders with your real org-specific content (stays in your private workspace)
4. Apply the structure as described — paste-in / Apprentice spawn / whatever the pattern specifies
5. Iterate based on real use

## How to CONTRIBUTE a new pattern

If you've built something that worked well in your Mage instance and the FRAMEWORK is reusable for others:

1. Take the original Tier 0 doc
2. Apply the sanitization rules above (or run it through a Tier 2 Sanitization Apprentice if you have one built)
3. Add a "How to fill in each section" guide so others can adopt it
4. Optionally include an illustrative example showing how one org filled it in (parameterized)
5. Add to this directory + update this README's pattern list

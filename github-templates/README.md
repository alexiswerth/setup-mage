# Operating Rules Templates

Three versions of the same operating rules framework, each designed for a different audience. All three are safe to commit — they contain no PII, no company names, and no confidential policy content.

Your **populated** operating rules (the one with your real name, email, and company policies filled in) lives outside this directory and is blocked by .gitignore. These templates are how you rebuild it.

---

## Which version do I use?

| Template | Audience | Best for | Detail level |
|---|---|---|---|
| **operating-rules-template.md** | Students, beginners | Teaching the concepts. Explaining WHY these rules exist and WHAT categories to think about. | Low — generic placeholders, minimal scaffolding. The learner fills in everything. |
| **operating-rules-template-hybrid.md** | Students, developers learning enterprise AI governance | Teaching the structure. Showing exactly what enterprise AI security rules look like in practice, without tying to any specific company. | High — every rule category is written out with concrete language. The learner fills in company-specific values only. |
| **operating-rules-client-setup.md** | Clients, end users setting up their own environment | Getting a client operational. Guided fill-in with onboarding checklist, examples, verification steps. | Highest — every section has instructions, examples of good answers, and a verification checklist at the end. |

---

## Decision guide

**"I'm teaching a class or workshop on AI governance"**
→ Start with `operating-rules-template.md` (concepts first), then show `operating-rules-template-hybrid.md` (what it looks like filled in with real structure).

**"I'm setting up a client's Claude environment"**
→ Use `operating-rules-client-setup.md`. Hand it to them, walk through the onboarding checklist, fill it in together.

**"I'm rebuilding my own setup on a new machine"**
→ Use `operating-rules-client-setup.md` and fill it in from your policy documents.

**"I want to understand the framework before committing to it"**
→ Read `operating-rules-template-hybrid.md` — it has the most detail without requiring you to fill anything in.

---

## What's NOT in this directory

The following files contain PII and/or confidential policy content and are excluded by .gitignore:

- `operating-rules.md` (your populated rules — lives one level up)
- `subagent-policy-briefing.md` (your populated subagent briefing — lives one level up)
- `company-profile.md` (your company details)
- Any `CLAUDE.md` in a `config/` path (populated practice profiles)
- `voice-profile.md` (personal communication patterns)

These files are created by populating the templates in this directory. They never touch the repo.

---

## Subagent briefing templates

| Template | Matches |
|---|---|
| **subagent-policy-briefing-template.md** | Pairs with `operating-rules-template.md` (generic placeholders) |
| **subagent-policy-briefing-template-hybrid.md** | Pairs with `operating-rules-template-hybrid.md` and `operating-rules-client-setup.md` (detailed structure) |

The subagent briefing is a compact version of the operating rules designed to be pasted into every subagent prompt. It ensures spawned agents follow the same policies as the parent session.

---

## File inventory

```
github-templates/
├── README.md                                    ← You are here
├── operating-rules-template.md                  ← Generic placeholders (teaching concepts)
├── operating-rules-template-hybrid.md           ← Full structure, anonymized (teaching practice)
├── operating-rules-client-setup.md              ← Guided fill-in (client onboarding)
├── subagent-policy-briefing-template.md         ← Generic subagent briefing
└── subagent-policy-briefing-template-hybrid.md  ← Detailed subagent briefing
```

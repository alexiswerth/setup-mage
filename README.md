# setup-mage

A reusable framework for setting up a Claude-assisted legal workflow environment that complies with corporate AI security policies from day one.

> **What this repo IS**: anonymized templates, folder scaffolds, and setup guides — the framework for rebuilding a compliant Claude environment anywhere.
>
> **What this repo is NOT**: a working environment. There's no real client data, no populated configurations, no PII. Everything here is structure waiting to be filled in.

---

## What's in here

| Folder | Contents |
|---|---|
| `github-templates/` | Three tiers of operating rules templates (generic / hybrid / client setup), plus subagent policy briefing templates |
| `voice-profile/` | Sanitized voice profile framework — communication style guide with [PLACEHOLDER] labels for any named individuals/companies |
| `folder-scaffolds/` | Empty workspace structures mirroring the local Mac and Google Drive directory layouts |
| `setup-guide.md` | Step-by-step instructions to rebuild this environment on a new machine |
| `.gitignore` | Blocklist patterns to keep confidential content out of the repo |

---

## Why this exists

The three problems this repo solves:

1. **Reproducibility**: Setting up a compliant Claude-for-Legal environment from scratch is a multi-step process. This repo captures the steps and the templates so it's repeatable.
2. **Policy compliance**: Corporate AI security policies require careful configuration (least privilege, account boundaries, audit logging). This repo embeds those requirements into the operating rules templates so they're enforced from day one.
3. **Portability**: Your voice, your operating rules, your folder scaffolds — all portable across machines, jobs, and clients (with confidential content stripped).

---

## How to use this repo

### To rebuild your own environment on a new machine
See `setup-guide.md`.

### To set up a new client environment
Use `github-templates/operating-rules-client-setup.md` — it's the guided fill-in version with an onboarding checklist.

### To teach a workshop on AI governance for legal teams
Start with `github-templates/operating-rules-template.md` (concepts), then show `github-templates/operating-rules-template-hybrid.md` (what it looks like populated, anonymized).

---

## The Pre-Commit Review Gate

Before ANY file gets pushed to this repo, run the 5-step gate (codified in operating rules):

1. **Identify**: Template/scaffold (safe) or real content (not safe)?
2. **Strip**: Remove all real names, PII, confidential data — use generic placeholders
3. **Show**: Diff is reviewed before pushing
4. **Confirm**: Explicit approval required, no silent commits
5. **Update .gitignore**: Add new confidential patterns as they emerge

**PII Sanitization Standard**: Placeholders must be generic enough that surrounding context can't be used to re-identify. Use the broadest category (`[MANAGER]` not `[SVP_LEGAL]`, `[VENDOR]` not `[VENDOR_PRIVACY]`).

---

## License

No license — private repo, all rights reserved.

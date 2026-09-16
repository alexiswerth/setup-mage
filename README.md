# setup-mage

A reusable framework for setting up a persistent legal-workflow agent whose identity, memory, voice, and operating rules can load in both Claude Code and OpenAI Codex.

> **What this repo IS**: public, sanitized templates, folder scaffolds, and setup guides for rebuilding a governed agent environment.
>
> **What this repo is NOT**: a working environment or a copy of anyone's private agent. It contains no populated memory, client data, personal information, credentials, or confidential configuration.

---

## What's in here

| Folder | Contents |
|---|---|
| `github-templates/` | Claude `CLAUDE.md` templates, a Codex `AGENTS.md` template, operating-rules templates, and subagent policy briefings |
| `voice-profile/` | Sanitized voice profile framework — communication style guide with [PLACEHOLDER] labels for any named individuals/companies |
| `folder-scaffolds/` | Empty workspace structures mirroring the local Mac and Google Drive directory layouts |
| `memory/` | Persistent-memory methods, including the cross-model shared-memory pattern |
| `scripts/` | Sanitized backup automation for the private memory twin |
| `setup-guide.md` | Step-by-step instructions to rebuild this environment on a new machine |
| `.gitignore` | Blocklist patterns to keep confidential content out of the repo |

---

## Why this exists

The three problems this repo solves:

1. **Reproducibility**: Setting up a governed, persistent agent from scratch is a multi-step process. This repo captures the structure so it can be rebuilt.
2. **Policy compliance**: Corporate AI security policies require careful configuration (least privilege, account boundaries, audit logging). This repo embeds those requirements into the operating rules templates so they're enforced from day one.
3. **Portability**: The agent's continuity lives in user-controlled files instead of one model provider. Compatible environments can load the same rules, voice, memory, and work state.

---

## What this structure enables

- One named orchestrator across fresh sessions
- Persistent memory based on local files, not chat history
- The same external operating layer in Claude Code and Codex
- Voice-aware drafting and channel-specific communication rules
- Account boundaries, policy controls, and human approval gates
- Practice-specific workflows and reusable legal methodology
- A sanitized rebuild path that keeps real work product private

## How one agent works across Claude and Codex

The model is the reasoning engine. The persistent agent is the external operating layer the user controls.

```text
                 SHARED EXTERNAL OPERATING LAYER
        identity | operating rules | voice | memory | workflows
                         /                         \
                CLAUDE.md                         AGENTS.md
                Claude Code                      OpenAI Codex
```

Claude Code and Codex do not send private conversations to each other. Each environment reads the same user-controlled files at session start. A checkpoint written to shared memory in one environment can therefore load in the other environment later.

See [`memory/cross-model-memory-setup.md`](memory/cross-model-memory-setup.md) for the full sanitized pattern.

---

## The two-repo rebuild kit

Mage rebuilds from **two** repos that survive any single machine:

1. **This repo (`setup-mage`, public)**: the framework, including Claude and Codex instruction templates, operating-rules templates, voice-profile structure, memory methods, folder scaffolds, backup script, and setup guide. It contains no populated personal or client configuration.
2. **Your private repo (e.g. `*-sanitized-memory`, private)**: your sanitized memory twin (`memory-portable/`) and filled-in voice profile. Your decisions and context live there with identifying details removed.

Clone both onto a fresh machine, run `setup-guide.md`, and point each supported agent environment at the same external operating layer. The same rules, voice, and accumulated lessons can then load in Claude Code or Codex. Employer-specific configuration, populated practice profiles, and raw client work stay outside the portable layer and must be rebuilt for the new context.

> Keep both repos on an account you control independent of any employer (personal GitHub), and make sure you can reach it — credentials and 2FA not tied to a work device. That independence is what makes the kit actually portable.

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

This is a public repository. No license is granted; all rights are reserved.

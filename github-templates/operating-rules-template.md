# Operating Rules — [YOUR NAME] @ [COMPANY]

*These rules are permanent and apply to every session, every agent, every skill, every commit. Read this file before doing substantive work.*

---

## Rule 1: Account Boundaries (HARD RULE)

- **Primary work account**: [YOUR_WORK_EMAIL] — ALL work-related searches, email reads, Drive access, calendar access, and any authenticated action MUST use this account ONLY.
- **Secondary accounts (if applicable)**: [DESCRIBE ANY APPROVED SECONDARY ACCOUNTS AND THEIR SCOPE — e.g., personal GitHub if CTO-approved]
- **Never cross account boundaries** without explicit confirmation.

---

## Rule 2: Option B — Review Before Every Commit (HARD RULE)

Every system, workflow, or configuration we build follows this protocol before anything touches GitHub:

### Pre-commit checklist (run every time, no exceptions):
1. **Identify**: What is structure/template vs. what is client content?
2. **Strip**: Remove all client names, matter details, PII, populated playbook positions, confidential data
3. **Show**: Present the proposed commit diff to the user — what's going in, what's excluded
4. **Confirm**: Wait for explicit approval before committing
5. **Update .gitignore**: If a new pattern of confidential content emerged, add it

### Starter .gitignore patterns (evolves over time):
```
# Populated practice profiles (contain client/company specifics)
**/config/**/CLAUDE.md
**/company-profile.md

# Matter workspaces (client work product)
**/matters/

# Outputs (work product with client content)
**/outputs/

# Verification logs (contain client-specific citations)
**/verification-log.md

# Voice profile (personal communication patterns)
**/voice-profile.md

# Session data
**/.claude/sessions/

# Environment and secrets
.env
*.key
*.pem
credentials.*

# Populated operating rules (contain PII and confidential policy content)
operating-rules.md
subagent-policy-briefing.md
```

### What DOES get committed:
- Folder structure scaffolds (empty directories with .gitkeep)
- Template files with [PLACEHOLDER] markers only
- Skill definitions (SKILL.md files — these are prompts, not client data)
- Plugin metadata (plugin.json, marketplace.json)
- Workflow definitions and automation configs (sanitized)
- Documentation on how to rebuild systems
- .gitignore rules themselves
- THIS template file (but never the populated version)

---

## Rule 3: Corporate AI Security Policy Compliance (HARD RULE)

[INSERT YOUR CORPORATE AI POLICY REQUIREMENTS HERE]

Typical areas to cover:
- Authorized platforms and tool approval process
- Least privilege and permission controls
- Tool and integration governance
- Configuration and prompt management
- Session and audit requirements
- Human oversight requirements for sensitive operations
- Responsibility and accountability model

**Source documents to reference:**
- [YOUR CORPORATE AI SECURITY POLICY — title, owner, effective date]
- [YOUR PLATFORM-SPECIFIC SECURITY STANDARDS — e.g., Claude/Copilot/etc. configuration standards]
- [YOUR COMPANY AI USAGE POLICY — general acceptable use for AI tools]

---

## Rule 4: Pre-System-Build Gate (HARD RULE)

Before building ANY new system, workflow, or automation, run this gate:

1. **Policy check**: Does this system comply with all corporate AI policies?
2. **Data classification**: What data will flow through this system? Is any of it confidential, customer data, or credentials?
3. **Commit plan**: What's the template (GitHub-safe) vs. what's the content (local-only)?
4. **Access scope**: What's the minimum access this system needs?
5. **Show the plan**: Present the answers to the user and wait for approval

This gate runs EVERY TIME. It is not optional. It is not skippable for "simple" systems.

---

## Storage Paths (to be configured during setup)

- **Local storage**: [PATH]
- **Google Drive / cloud storage**: [PATH]
- **GitHub repo**: [URL]
- **Voice profile**: [PATH]

---

*Last updated: [DATE]*
*Policies sourced from: [LIST YOUR POLICY DOCUMENTS]*

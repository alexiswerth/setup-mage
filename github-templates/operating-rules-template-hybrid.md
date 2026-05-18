# Operating Rules — [YOUR NAME] @ [COMPANY]

*These rules are permanent and apply to every session, every agent, every skill, every commit. Read this file before doing substantive work.*

---

## Rule 1: Account Boundaries (HARD RULE)

Define which accounts are used for what. Never cross boundaries without explicit confirmation.

- **Primary work account**: [YOUR_WORK_EMAIL] — ALL work-related searches, email reads, Drive access, calendar access, and any authenticated action MUST use this account ONLY.
- **Secondary accounts (if applicable)**: [DESCRIBE ANY APPROVED SECONDARY ACCOUNTS AND THEIR SCOPE]
  - Example: "Personal GitHub registered under personal email — approved by [APPROVER]. Used for [SCOPE] only."
- **What "never cross boundaries" means in practice**: Don't pull data from your work Google account into a personal-email context. Don't authenticate to a work system with a personal account. If a task requires both accounts, get explicit confirmation before each cross-boundary action.

---

## Rule 2: Option B — Review Before Every Commit (HARD RULE)

Every system, workflow, or configuration we build follows this protocol before anything touches a repository:

### Pre-commit checklist (run every time, no exceptions):

| Step | What you do | Why |
|---|---|---|
| 1. **Identify** | Label every file/change as STRUCTURE (template, scaffold, prompt, config schema) or CONTENT (client names, populated profiles, work product, PII) | You can't strip what you haven't classified |
| 2. **Strip** | Remove all client names, matter details, PII, populated playbook positions, confidential data from anything labeled CONTENT | Client content never touches a public or shared repo |
| 3. **Show** | Present the proposed commit diff — what's going in, what's excluded | Human eyes catch what rules miss |
| 4. **Confirm** | Wait for explicit "yes, commit" approval | No silent commits |
| 5. **Update .gitignore** | If a new pattern of confidential content emerged, add it now | The ignore rules grow with your system |

### Starter .gitignore patterns (customize to your setup):
```gitignore
# Populated practice profiles (contain client/company specifics)
**/config/**/CLAUDE.md
**/company-profile.md

# Populated operating rules and policy briefings (contain PII + confidential policy content)
operating-rules.md
subagent-policy-briefing.md

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
```

### What DOES get committed (the "structure" side):
- Folder structure scaffolds (empty directories with .gitkeep)
- Template files with [PLACEHOLDER] markers only
- Skill definitions (SKILL.md files — these are prompts, not client data)
- Plugin metadata (plugin.json, marketplace.json)
- Workflow definitions and automation configs (sanitized)
- Documentation on how to rebuild systems
- .gitignore rules themselves
- Template versions of operating rules (this file)

---

## Rule 3: Corporate AI Security Policy Compliance (HARD RULE)

Populate this section from YOUR company's AI security policies. Below is the structure — replace the guidance notes with your actual policy requirements. If your company doesn't have a formal policy yet, use these categories as a starting checklist.

**Source documents you'll need:**
- Your corporate AI / agentic AI security policy
- Your platform-specific security standards (e.g., how your org configures Claude, Copilot, etc.)
- Your company-wide AI acceptable use policy

### Authorized Platforms
- All agentic AI platforms used with company systems, code, or data must be reviewed and approved by Security prior to use
- Unauthorized platforms — including personal or consumer-tier accounts — are prohibited for use with proprietary code, infrastructure, credentials, or customer data
- [LIST YOUR APPROVED PLATFORMS AND WHERE THE APPROVED LIST IS MAINTAINED]

### Least Privilege
- All agentic AI deployments must operate under the principle of least privilege — minimum access necessary for the intended task
- Organization-managed config files governing AI permissions must be reviewed and approved by Security
- Modes or settings that bypass or suppress permission checks are disabled organization-wide and may not be re-enabled by any individual user
- Persistent broad-access rules for destructive or privileged operations (unrestricted file deletion, root-level commands, outbound network calls to arbitrary hosts) are prohibited
- Agentic AI sessions must operate under a standard, non-privileged user account — no root, admin, or superuser
- Credentials, API keys, and secrets must not be passed via plaintext config files, environment variables in shared contexts, or conversation prompts

### Tool & Integration Governance
- Approved tools and integrations are managed in organization settings — tools not listed are unapproved and must not be connected
- Tools connecting AI systems to external third-party services require a vendor risk assessment prior to approval
- Organization-managed allowlists for tool access must be enforced on all deployments — user-level modifications are not permitted
- Tools that enable write access to production systems, financial systems, or customer-facing services require elevated review and explicit approval by [YOUR SECURITY LEAD ROLE]
- [IF APPLICABLE: Local tool servers must have source code in a version-controlled company repo, pass a security scan, and not be exposed to external network interfaces]

### Configuration & Prompt Management
- Organization-level system prompts, config files, and behavioral instructions are managed centrally and apply to all deployments
- Individual users may add project-level configs but may not override, disable, or contradict organization-level security instructions
- Prompt injection risks must be considered when designing workflows that process external content (emails, documents, web content)

### Human Oversight
- Human operators must maintain active oversight of any agentic AI session interacting with:
  - Production infrastructure, CI/CD pipelines, or IaC configurations
  - Customer-facing services or APIs
  - Authentication, authorization, or cryptographic components
  - Secrets management systems or credential stores
  - Financial systems, billing data, or customer account data
- Autonomous or unattended agentic AI sessions in production environments are prohibited without explicit Security approval
- Any agentic workflow that will execute automatically (scheduled jobs, pipeline triggers) must have its scope documented and reviewed

### Session & Audit
- Session data and logs must be retained per your organization's retention schedule
- Local retention of session transcripts should be minimized to reduce credential exposure risk
- Enterprise-level audit logs must be exported to your security logging infrastructure on a regular basis
- Activity logs must support security investigations, incident response, and compliance audit requirements

### Responsibility & Accountability
- The individual who initiates or authorizes an agentic AI system to operate on their behalf is fully accountable for all actions taken by that agent
- The AI system is an extension of the employee's role — responsibility for output and policy compliance rests with the authorizing person

### Plugins, Skills & Connectors
- [DESCRIBE YOUR APPROVED SOURCES FOR PLUGINS — e.g., official marketplace, company private repo]
- [DESCRIBE YOUR SKILL APPROVAL PROCESS — e.g., must conform to a standard spec, must pass supply chain security scan]
- [DESCRIBE YOUR CONNECTOR APPROVAL PROCESS — e.g., pre-approved if vendor already procured, otherwise requires security review]
- [IF APPLICABLE: Pre-built connectors from platform vendor preferred over custom integrations]

### General AI Acceptable Use
- Do not input customer data, source code, internal documentation, credentials, proprietary models, or financial/company strategies into unapproved AI tools
- All AI outputs are drafts — fact-check before using in presentations, customer interactions, or published material
- Disclose when AI was used to produce written content, code, or designs, especially when collaborating
- [YOUR COMPANY]'s approved AI tools: [LIST THEM — e.g., "Glean for search, Claude enterprise for fallback"]

---

## Rule 4: Pre-System-Build Gate (HARD RULE)

Before building ANY new system, workflow, or automation, run this gate:

| Step | Question to answer | Why |
|---|---|---|
| 1. **Policy check** | Does this system comply with all corporate AI policies above? | Catch violations before they're built in |
| 2. **Data classification** | What data will flow through? Any confidential, customer, or credential data? | Determines what can be committed vs. what stays local |
| 3. **Commit plan** | What's the template (repo-safe) vs. what's the content (local-only)? | Enforces the structure/content split from Rule 2 |
| 4. **Access scope** | What's the minimum access this system needs? | Least privilege from Rule 3 |
| 5. **Show the plan** | Present all answers to the human operator and wait for approval | Human oversight from Rule 3 |

This gate runs EVERY TIME. It is not optional. It is not skippable for "simple" systems. The gate itself takes 60 seconds — the cost of skipping it is a policy violation that takes much longer to fix.

---

## Storage Paths (configure during setup)

| Purpose | Path | Notes |
|---|---|---|
| Local storage | [PATH] | Where populated configs, outputs, and work product live |
| Cloud storage | [PATH] | Google Drive / SharePoint / etc. |
| GitHub repo | [URL] | Structure and templates only — .gitignore enforces the boundary |
| Voice profile | [PATH] | Personal communication patterns — local only |
| Operating rules (populated) | [PATH] | This file, populated — local only, never committed |

---

## How to use this template

1. Copy this file to your local config directory
2. Rename it `operating-rules.md` (the populated version — .gitignore excludes it)
3. Replace every `[BRACKETED PLACEHOLDER]` with your actual values
4. Read your company's AI security policies and fill in Rule 3
5. Commit THIS template file (not the populated version) to your repo

---

*Last updated: [DATE]*
*Policies sourced from: [LIST YOUR POLICY DOCUMENTS]*

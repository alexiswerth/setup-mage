# Operating Rules — Client Setup Guide

*Hand this to a client. They fill it in, and their Claude environment is configured to comply with their corporate AI policies from day one.*

---

## Before you start: Onboarding Checklist

Gather these before filling in the template. Most companies have them — they're just not in one place yet.

- [ ] **Your corporate AI security policy** — the document that says what AI tools are approved and how they must be configured. Ask your CISO, Director of Security, or IT. If you don't have one, this template will help you build the rules you need.
- [ ] **Your platform-specific security standards** — how your org configures the AI tools you use (e.g., Claude managed settings, Copilot policies, allowed integrations). Ask IT or your AI platform admin.
- [ ] **Your company AI acceptable use policy** — the general rules for how employees can use AI at work. Often part of your employee handbook or IT policies.
- [ ] **Your list of approved AI tools** — which platforms are sanctioned for use with company data. Usually maintained by IT or Security.
- [ ] **Your data classification policy** — how your company categorizes data (public, internal, confidential, restricted). This determines what can flow through AI systems.

**Don't have all of these?** That's normal. Fill in what you have, mark the rest `[POLICY NOT YET DEFINED — use the guidance below as a starting framework]`, and revisit as your policies mature. The categories in this template are based on enterprise AI governance best practices — they're a reasonable starting point even without formal policies.

---

## How to use this template

1. **Copy this file** to your local config directory (e.g., `~/.claude/plugins/config/`)
2. **Rename it** to `operating-rules.md`
3. **Fill in every `[BRACKETED PLACEHOLDER]`** with your actual values
4. **Add it to .gitignore** — the populated version contains PII and confidential policy content and must never be committed to a repository
5. **Commit the template version** (this file, before you populated it) so you can rebuild from scratch anytime

**Time estimate:** 20-30 minutes with your policy documents in hand. 45-60 minutes if you're building the rules as you go.

---

## Rule 1: Account Boundaries (HARD RULE)

*Why this matters: AI agents access services on your behalf. Mixing work and personal accounts risks leaking company data into personal contexts or personal data into company audit logs.*

**Fill in your account boundaries:**

- **Primary work account**: [YOUR_WORK_EMAIL]
  - This account is used for: ALL work-related searches, email reads, Drive access, calendar access, and any authenticated action
  - Never use a personal account for these operations

- **Secondary accounts (if applicable)**:
  - Account: [EMAIL/USERNAME]
  - Approved by: [WHO APPROVED THIS — e.g., CTO, IT Director]
  - Approved scope: [WHAT THIS ACCOUNT IS USED FOR — e.g., "GitHub only, for open-source contributions"]
  - Restrictions: [WHAT THIS ACCOUNT MUST NOT BE USED FOR]

- **Account boundary rule**: Never pull data from your work account into a personal-account context, or authenticate to a work system with a personal account, without explicit confirmation for each cross-boundary action.

---

## Rule 2: Repository Hygiene — Review Before Every Commit (HARD RULE)

*Why this matters: AI systems generate outputs that mix reusable structure (templates, scaffolds, workflow definitions) with client-specific content (names, data, populated profiles). Committing client content to a repository — even a private one — creates a data leak that's hard to fully remediate.*

### Pre-commit checklist (run every time, no exceptions):

| Step | What to do | Example |
|---|---|---|
| 1. **Classify** | Label every file/change as STRUCTURE or CONTENT | `plugin.json` = structure. `company-profile.md` with your company name = content |
| 2. **Strip** | Remove all client names, matter details, PII, populated positions, confidential data | Replace "Acme Corp" with `[COMPANY]`, remove real email addresses |
| 3. **Show** | Review the proposed commit diff — what's going in, what's excluded | Human eyes catch what automated rules miss |
| 4. **Confirm** | Explicit "yes, commit" approval before proceeding | No silent commits, no auto-commits |
| 5. **Update .gitignore** | If a new pattern of confidential content emerged, add it | First time you create a `matters/` folder → add `**/matters/` to .gitignore |

### Starter .gitignore (customize to your setup):
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

**Add patterns as you go.** The first time you encounter a new type of confidential file, add its pattern before committing anything else. The .gitignore grows with your system — that's by design.

### What DOES get committed:
- Folder structure scaffolds (empty directories with .gitkeep)
- Template files with [PLACEHOLDER] markers only
- Skill definitions (SKILL.md files — prompts, not client data)
- Plugin metadata (plugin.json, marketplace.json)
- Workflow definitions and automation configs (sanitized)
- Documentation on how to rebuild systems
- .gitignore rules themselves
- This template file (but never the populated version)

---

## Rule 3: Corporate AI Security Policy Compliance (HARD RULE)

*Why this matters: Your company has rules about how AI tools can be used. Violating them puts you and your company at risk. This section translates those policies into operating rules your AI agent follows every session.*

**Instructions:** Read your corporate AI policies (from the onboarding checklist above) and fill in each section below. If a category doesn't apply to your organization, write `[NOT APPLICABLE — reason]` rather than deleting it — future you will thank past you for recording what was considered.

### Authorized Platforms

*What to fill in: Which AI tools are approved? Where is the approved list maintained? What's prohibited?*

- Approved AI platforms: [LIST THEM — e.g., "Claude enterprise, Glean, GitHub Copilot"]
- Where the approved list lives: [URL OR LOCATION — e.g., "IT wiki page", "Notion database"]
- Prohibited: Unauthorized platforms including personal or consumer-tier accounts of any AI product are prohibited for use with proprietary code, infrastructure, credentials, or customer data
- New platform approval process: [DESCRIBE — e.g., "Vendor risk assessment + Security sign-off"]

### Least Privilege

*What to fill in: Your organization's specific permission requirements and any platform-specific config standards.*

- All agentic AI deployments must operate under the principle of least privilege — minimum access necessary for the intended task
- Organization-managed config files governing AI permissions must be reviewed and approved by [YOUR SECURITY TEAM/ROLE]
- Modes or settings that bypass or suppress permission checks are disabled organization-wide and may not be re-enabled by any individual user
- Persistent broad-access rules for destructive or privileged operations (unrestricted file deletion, root-level commands, outbound network calls to arbitrary hosts) are prohibited
- Agentic AI sessions must operate under a standard, non-privileged user account — no root, admin, or superuser
- Credentials, API keys, and secrets must not be passed via plaintext config files, environment variables in shared contexts, or conversation prompts
- [ADD ANY ORGANIZATION-SPECIFIC PERMISSION REQUIREMENTS]

### Tool & Integration Governance

*What to fill in: Your approved tool list, your vendor review process, and who approves elevated access.*

- Approved tools and integrations are managed in [WHERE — e.g., "organization admin settings"]. Tools not listed are unapproved and must not be connected
- Tools connecting AI systems to external third-party services require [YOUR PROCESS — e.g., "vendor risk assessment"] prior to approval
- Organization-managed allowlists for tool access must be enforced on all deployments. User-level modifications are not permitted
- Tools that enable write access to production systems, financial systems, or customer-facing services require elevated review and explicit approval by [ROLE — e.g., "CISO", "Director of Security"]
- Local tool servers (if applicable) must: [YOUR REQUIREMENTS — e.g., "have source code in a version-controlled company repo, pass a security scan, not be exposed to external network interfaces"]

### Configuration & Prompt Management

*What to fill in: How your org manages AI system configuration centrally.*

- Organization-level system prompts, config files, and behavioral instructions are managed centrally and apply to all deployments
- Individual users may add project-level configs but may not override, disable, or contradict organization-level security instructions
- Prompt injection risks must be considered when designing workflows that process external content (emails, documents, web content)

### Human Oversight

*What to fill in: Which systems require active human monitoring during AI sessions.*

- Human operators must maintain active oversight of any agentic AI session interacting with:
  - [ ] Production infrastructure, CI/CD pipelines, or IaC configurations
  - [ ] Customer-facing services or APIs
  - [ ] Authentication, authorization, or cryptographic components
  - [ ] Secrets management systems or credential stores
  - [ ] Financial systems, billing data, or customer account data
  - [ ] [ADD YOUR ORGANIZATION-SPECIFIC SENSITIVE SYSTEMS]
- Autonomous or unattended agentic AI sessions in production environments are prohibited without explicit [YOUR SECURITY TEAM] approval
- Any agentic workflow that will execute automatically (scheduled jobs, pipeline triggers) must have its scope documented and reviewed

### Session & Audit

*What to fill in: Your retention schedule and logging infrastructure.*

- Session data and logs must be retained per [YOUR RETENTION SCHEDULE — e.g., "1 year minimum"]
- Local retention of session transcripts should be minimized to reduce credential exposure risk
- Enterprise-level audit logs must be exported to [YOUR LOGGING INFRASTRUCTURE — e.g., "S3 archive, SIEM"]
- Activity logs must support security investigations, incident response, and compliance audit requirements

### Responsibility & Accountability

- The individual who initiates or authorizes an agentic AI system to operate on their behalf is fully accountable for all actions taken by that agent
- The AI system is an extension of the employee's role — responsibility for output and policy compliance rests with the authorizing person

### Plugins, Skills & Connectors

*What to fill in: Where your approved plugins/skills come from and your approval process.*

- Approved plugin sources: [LIST — e.g., "official Anthropic marketplace, company private repo at github.com/yourorg/ai-plugins"]
- Skill approval process: [DESCRIBE — e.g., "must pass supply chain security scan before install"]
- Connector approval process: [DESCRIBE — e.g., "pre-approved if vendor already procured, otherwise requires security review ticket"]
- Preference: [e.g., "pre-built connectors from platform vendor preferred over custom integrations"]

### General AI Acceptable Use

*What to fill in: Your company's general rules for AI use.*

- Do not input customer data, source code, internal documentation, credentials, proprietary models, or financial/company strategies into unapproved AI tools
- All AI outputs are drafts — fact-check before using in presentations, customer interactions, or published material
- Disclose when AI was used to produce written content, code, or designs, especially when collaborating
- Data sensitivity types are defined in [YOUR DATA CLASSIFICATION POLICY — title and location]
- [ADD ANY ORGANIZATION-SPECIFIC AI USE RULES]

---

## Rule 4: Pre-System-Build Gate (HARD RULE)

*Why this matters: It's easier to build a compliant system than to fix a non-compliant one. This gate takes 60 seconds — a policy violation takes much longer to remediate.*

Before building ANY new system, workflow, or automation:

| Step | Question to answer | What a good answer looks like |
|---|---|---|
| 1. **Policy check** | Does this comply with all corporate AI policies in Rule 3? | "Yes — uses only approved tools, least privilege, no production write access" |
| 2. **Data classification** | What data flows through? Any confidential or customer data? | "Internal data only — no customer PII, no credentials" |
| 3. **Commit plan** | What's template (repo-safe) vs. content (local-only)? | "Workflow definition commits. Client config stays local. .gitignore updated." |
| 4. **Access scope** | What's the minimum access needed? | "Read-only to Drive. Write to local output folder only." |
| 5. **Show the plan** | Present answers 1-4 to the human operator | Wait for explicit approval before building |

---

## Storage Paths (configure during setup)

| Purpose | Path | Commits to repo? |
|---|---|---|
| Local storage | [PATH] | No — contains work product |
| Cloud storage | [PATH — Drive/SharePoint/etc.] | No — contains work product |
| GitHub repo | [URL] | Yes — structure and templates only |
| Voice profile | [PATH] | No — personal data |
| Operating rules (populated) | [PATH] | No — PII + confidential policies |

---

## After setup: Verification

Run through this checklist to confirm everything is configured correctly:

- [ ] All `[BRACKETED PLACEHOLDERS]` in your populated operating-rules.md are filled in
- [ ] .gitignore includes all patterns for your confidential content
- [ ] Populated operating-rules.md is NOT tracked by git (`git status` should not show it)
- [ ] Template version IS tracked by git
- [ ] Account boundaries are documented and unambiguous
- [ ] At least one corporate AI policy has been translated into Rule 3
- [ ] Storage paths are set and accessible

---

*Last updated: [DATE]*
*Policies sourced from: [LIST YOUR POLICY DOCUMENTS]*
*Setup completed by: [NAME]*
*Next review date: [DATE — recommend quarterly]*

# Setup Guide, Rebuilding the Environment

Follow these steps to set up a fresh Claude-assisted legal workflow environment on a new machine, using the templates in this repo.

**Time estimate**: 60-90 minutes if you have your corporate AI policies on hand. 2-3 hours if you're building the policies as you go.

---

## Prerequisites

- A Mac (these instructions assume macOS; adapt for Linux/Windows as needed)
- Claude Code installed
- Git installed
- A GitHub account (personal or corporate, wherever your CTO has approved you to operate)
- Access to your corporate AI security policies (or willingness to build them)

---

## Step 1: Clone this repo

```bash
gh repo clone <your-username>/setup-mage ~/Desktop/setup-mage
```

If you don't have `gh` CLI, install it:
```bash
# macOS without Homebrew:
mkdir -p ~/.local/bin
curl -L -o /tmp/gh.zip "https://github.com/cli/cli/releases/latest/download/gh_<VERSION>_macOS_arm64.zip"
unzip -q /tmp/gh.zip -d /tmp/
mv /tmp/gh_*/bin/gh ~/.local/bin/gh
chmod +x ~/.local/bin/gh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

gh auth login --hostname github.com --git-protocol https --web
```

---

## Step 2: Build your local workspace

Mirror the folder structure from `folder-scaffolds/desktop-claude-layout/` to `~/Desktop/Claude/`:

```bash
mkdir -p ~/Desktop/Claude/{commercial-legal,privacy-legal,ai-governance-legal,corporate-legal,employment-legal,ip-legal,litigation-legal,product-legal,regulatory-legal,legal-clinic,law-student,legal-builder-hub}/{outputs,matters}
mkdir -p ~/Desktop/Claude/{voice-profile,templates,memory}
```

---

## Step 3: Build your cloud workspace

Mirror the folder structure from `folder-scaffolds/google-drive-layout/` in your Google Drive (or SharePoint/Dropbox equivalent):

- `Claude/templates/`
- `Claude/outputs/` (with subfolders per plugin)
- `Claude/memory/`

---

## Step 4: Populate your operating rules

1. Copy `github-templates/operating-rules-client-setup.md` to your local config directory:
   ```bash
   mkdir -p ~/.claude/plugins/config/claude-for-legal
   cp ~/Desktop/setup-mage/github-templates/operating-rules-client-setup.md ~/.claude/plugins/config/claude-for-legal/operating-rules.md
   ```

2. Open the file and fill in every `[BRACKETED PLACEHOLDER]` with your actual values:
   - Your work email and account boundaries
   - Your company's AI security policies (from Security/CISO)
   - Your platform-specific standards
   - Your data classification policy
   - Your retention requirements

3. **This populated file is gitignored**, it never gets committed.

4. **If your organization has no written AI policy yet** (common!), don't stall here. Mark each policy section `POLICY NOT YET DEFINED, using template guidance` and use the template's built-in guidance as your starting framework (it's distilled from NIST AI RMF and ISO 42001 norms). Two rules even without a policy: get your CTO/CISO's verbal OK on the tools you're using, and revisit this file the day a written policy lands.

---

## Step 5: Build your subagent policy briefing

1. Copy the template:
   ```bash
   cp ~/Desktop/setup-mage/github-templates/subagent-policy-briefing-template-hybrid.md ~/.claude/plugins/config/claude-for-legal/subagent-policy-briefing.md
   ```

2. Fill in placeholders with the same values you used in Step 4.

3. **Also gitignored**, never committed.

---

## Step 6: Wire policy into Claude's persistent memory

Three CLAUDE.md files so every Claude Code session that opens against your home directory becomes your master agent, with your rules and voice loaded.

Copy each template from `github-templates/` to its target path, then fill in placeholders (`[USER_NAME]`, `[MASTER_AGENT_NAME]`, `[DEVICE_LABEL]`).

```bash
cp ~/Desktop/setup-mage/github-templates/CLAUDE-template-global.md ~/CLAUDE.md
cp ~/Desktop/setup-mage/github-templates/CLAUDE-template-user.md ~/.claude/CLAUDE.md
cp ~/Desktop/setup-mage/github-templates/CLAUDE-template-workspace.md ~/Desktop/Claude/CLAUDE.md
```

Then open each file and replace:

| Placeholder | What to put |
|---|---|
| `[USER_NAME]` | Your name |
| `[MASTER_AGENT_NAME]` | The name you picked for your master agent (e.g., Mage) |
| `[DEVICE_LABEL]` | This device (e.g., home-mac, work-mac) |
| `[YOUR_SIGNATURE_WORD]` | Your email sign-off word (e.g., Warmly, Best) |
| `[TBD ...]` lines | Whatever applies to your setup |

**These three files are LOCAL only.** They contain your real name and live outside any repo, so they never get committed. The templates in this repo are the rebuildable seed.

---

## Step 7: Build your voice profile

1. Read `voice-profile/voice-profile.md` to understand the structure
2. Either: (a) have Claude analyze your Slack + Gmail in a session to generate your own, or (b) build it manually based on examples you write
3. To invoke the analysis in a session: connect your Gmail (and Slack export if you have one), then ask your master agent to "read my last ~200 sent messages and draft a voice profile using the structure in voice-profile.md, patterns only, with examples." Review and prune; you own what's documented about you.
4. Save the result to `~/Desktop/Claude/voice-profile/voice-profile.md`
5. **Sanitize before committing**, strip any real names, replace with `[MANAGER]`, `[VENDOR]`, `[CUSTOMER]` etc.

---

## Step 8: Install the plugins

First check whether the Claude for Legal marketplace is available to you: in Claude Code, run `/plugin marketplace list`. If a claude-for-legal source appears, you have it.

If available:
```bash
# In Claude Code:
/plugin marketplace add <plugin-source>
/plugin install commercial-legal@claude-for-legal
# (repeat for other plugins)
```

**If the marketplace is NOT available** (older Claude Code version, restricted org settings, or no source URL): don't block. The plugins are conveniences, not prerequisites, everything in this guide works without them. Skip to Step 9, and either (a) update Claude Code (`claude update`) and retry, or (b) recreate the essentials manually: a practice-profile CLAUDE.md per legal domain folder, populated by interviewing yourself with the questions in `github-templates/`.

For each plugin you do install, run its `cold-start-interview` skill to populate its practice profile.

---

## Step 9: Verify

- [ ] `~/CLAUDE.md`, `~/.claude/CLAUDE.md`, `~/Desktop/Claude/CLAUDE.md` all reference your operating rules
- [ ] `~/.claude/plugins/config/claude-for-legal/operating-rules.md` exists, populated, NOT tracked by git
- [ ] `~/Desktop/Claude/` has all 12 plugin folders
- [ ] Google Drive has matching folder structure
- [ ] Voice profile exists at `~/Desktop/Claude/voice-profile/voice-profile.md`
- [ ] `.gitignore` is working: `git status` in the repo should NOT show populated config files

---

## Step 10: Biweekly review

Set a recurring calendar reminder, every two weeks. Quarterly is too slow to be safe: this system evolves fast while you're actively building, and a stale rule or an unblocked confidential pattern is much cheaper to catch at week 2 than month 3.
- Re-read your operating rules and update for any new corporate policies
- Update your voice profile as your style evolves
- Audit `.gitignore` for new patterns of confidential content that should be blocked

---

## Step 11: First real use (test-drive)

Don't end setup with a config check; end it by watching your rules actually fire. Run this 10-minute test:

1. **Start a fresh session** in your workspace directory. Confirm the agent self-identifies with your `[MASTER_AGENT_NAME] @ [DEVICE_LABEL]` and references your operating rules unprompted.
2. **Give it a small real task** from your actual work (e.g., "draft a 3-line status update to [MANAGER] about X in my voice"). Check: did it use your voice profile's patterns?
3. **Try to make it break a rule.** Ask it to commit a file containing a made-up client name, or to build a small automation. PASS = it runs the Pre-Commit / Pre-System-Build gate (classifies, shows you the plan or diff, waits for your approval). FAIL = it just does it.
4. **Check the boundary.** Ask it to do something with the wrong account (work task via personal account or vice versa). PASS = it stops and asks.

If any check fails, the corresponding CLAUDE.md or operating-rules section isn't loading or isn't explicit enough, fix it now, while the gap is fresh, not after the first real incident.

---

## Troubleshooting

| Issue | Fix |
|---|---|
| `gh` not authenticating | Make sure you're using the correct GitHub account (personal vs. corporate). Re-run `gh auth login`. |
| Plugin install fails | Verify your Claude Code version supports plugins. Check the marketplace source URL. |
| Populated file gets staged for commit | Check `.gitignore`, add a more specific pattern if needed. Unstage with `git restore --staged <file>`. |
| Voice profile feels off | Re-run analysis in a session with more recent messages, or hand-edit the rules section. |

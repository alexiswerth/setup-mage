# Setup Guide — Rebuilding the Environment

Follow these steps to set up a fresh Claude-assisted legal workflow environment on a new machine, using the templates in this repo.

**Time estimate**: 60-90 minutes if you have your corporate AI policies on hand. 2-3 hours if you're building the policies as you go.

---

## Prerequisites

- A Mac (these instructions assume macOS; adapt for Linux/Windows as needed)
- Claude Code installed
- Git installed
- A GitHub account (personal or corporate — wherever your CTO has approved you to operate)
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

3. **This populated file is gitignored** — it never gets committed.

---

## Step 5: Build your subagent policy briefing

1. Copy the template:
   ```bash
   cp ~/Desktop/setup-mage/github-templates/subagent-policy-briefing-template-hybrid.md ~/.claude/plugins/config/claude-for-legal/subagent-policy-briefing.md
   ```

2. Fill in placeholders with the same values you used in Step 4.

3. **Also gitignored** — never committed.

---

## Step 6: Wire policy into Claude's persistent memory

Create or update these three files so Claude reads your policies in every session:

### `~/CLAUDE.md` (global, project-wide)
Tells Claude about you, your accounts, and which policies apply.

### `~/.claude/CLAUDE.md` (user-level)
Points Claude at the operating rules and voice profile files.

### `~/Desktop/Claude/CLAUDE.md` (workspace-level)
Specific to your workspace — describes how you prefer to work.

Use the templates in this repo as starting points; fill in your specifics.

---

## Step 7: Build your voice profile

1. Read `voice-profile/voice-profile.md` to understand the structure
2. Either: (a) have Claude analyze your Slack + Gmail in a session to generate your own, or (b) build it manually based on examples you write
3. Save the result to `~/Desktop/Claude/voice-profile/voice-profile.md`
4. **Sanitize before committing** — strip any real names, replace with `[MANAGER]`, `[VENDOR]`, `[CUSTOMER]` etc.

---

## Step 8: Install the plugins

If using the Claude for Legal marketplace:
```bash
# In Claude Code:
/plugin marketplace add <plugin-source>
/plugin install commercial-legal@claude-for-legal
# (repeat for other plugins)
```

For each plugin, run its `cold-start-interview` skill to populate its practice profile.

---

## Step 9: Verify

- [ ] `~/CLAUDE.md`, `~/.claude/CLAUDE.md`, `~/Desktop/Claude/CLAUDE.md` all reference your operating rules
- [ ] `~/.claude/plugins/config/claude-for-legal/operating-rules.md` exists, populated, NOT tracked by git
- [ ] `~/Desktop/Claude/` has all 12 plugin folders
- [ ] Google Drive has matching folder structure
- [ ] Voice profile exists at `~/Desktop/Claude/voice-profile/voice-profile.md`
- [ ] `.gitignore` is working: `git status` in the repo should NOT show populated config files

---

## Step 10: Quarterly review

Set a calendar reminder to:
- Re-read your operating rules and update for any new corporate policies
- Update your voice profile as your style evolves
- Audit `.gitignore` for new patterns of confidential content that should be blocked

---

## Troubleshooting

| Issue | Fix |
|---|---|
| `gh` not authenticating | Make sure you're using the correct GitHub account (personal vs. corporate). Re-run `gh auth login`. |
| Plugin install fails | Verify your Claude Code version supports plugins. Check the marketplace source URL. |
| Populated file gets staged for commit | Check `.gitignore` — add a more specific pattern if needed. Unstage with `git restore --staged <file>`. |
| Voice profile feels off | Re-run analysis in a session with more recent messages, or hand-edit the rules section. |

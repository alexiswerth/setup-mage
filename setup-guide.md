# Setup Guide, Rebuilding the Environment

Follow these steps to set up a persistent legal-workflow agent on a new machine. The same external operating layer can load in Claude Code, OpenAI Codex, or both.

**Time estimate**: 60-90 minutes if you have your corporate AI policies on hand. 2-3 hours if you're building the policies as you go.

---

## Prerequisites

- A Mac (these instructions assume macOS; adapt for Linux/Windows as needed)
- Claude Code, OpenAI Codex, or both installed
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

## Step 6: Wire the operating layer into Claude and Codex

Claude Code reads `CLAUDE.md`. Codex reads `AGENTS.md`. Both loader files point to the same local operating rules, voice profile, memory index, and workspace state.

For Claude Code, copy the three `CLAUDE.md` templates:

```bash
cp ~/Desktop/setup-mage/github-templates/CLAUDE-template-global.md ~/CLAUDE.md
cp ~/Desktop/setup-mage/github-templates/CLAUDE-template-user.md ~/.claude/CLAUDE.md
cp ~/Desktop/setup-mage/github-templates/CLAUDE-template-workspace.md ~/Desktop/Claude/CLAUDE.md
```

For Codex, copy the generic `AGENTS.md` template to the directory that should govern your Codex sessions:

```bash
cp ~/Desktop/setup-mage/github-templates/AGENTS-template-global.md ~/AGENTS.md
```

If an instruction file already exists at a target path, merge the template into it instead of overwriting it.

Then open each file and replace:

| Placeholder | What to put |
|---|---|
| `[USER_NAME]` | Your name |
| `[MASTER_AGENT_NAME]` | The name you picked for your master agent (e.g., Mage) |
| `[DEVICE_LABEL]` | This device (e.g., home-mac, work-mac) |
| `[YOUR_SIGNATURE_WORD]` | Your email sign-off word (e.g., Warmly, Best) |
| `[TBD ...]` lines | Whatever applies to your setup |

**These populated files are local only.** They may contain your real name, device details, and private paths. Never commit them to the public setup repository. The placeholder templates in this repo are the rebuildable seed.

See `memory/cross-model-memory-setup.md` for the shared-memory structure and a fictional-data verification test.

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

**If the marketplace is NOT available** (older Claude Code version, restricted org settings, or no source URL): don't block. The plugins are conveniences, not prerequisites, everything in this guide works without them. Skip ahead, and either (a) update Claude Code (`claude update`) and retry, or (b) recreate the essentials manually: a practice-profile CLAUDE.md per legal domain folder, populated by interviewing yourself with the questions in `github-templates/`.

For each plugin you do install, run its `cold-start-interview` skill to populate its practice profile.

---

## Step 9: Install the backup automation

Set up the one piece of automation that writes to a remote: the sanitized backup.

1. Copy the template and make it executable:
   ```bash
   cp ~/Desktop/setup-mage/scripts/backup-template.sh ~/bin/backup.sh
   chmod +x ~/bin/backup.sh
   ```
2. Open `~/bin/backup.sh` and fill in the four `[PLACEHOLDERS]` (private repo path, device label, sanitized-memory dir, voice-profile path).
3. Test it: run `~/bin/backup.sh`. With nothing changed it prints "Already up to date." With a sanitized-memory change it commits + pushes to your **private** repo.
4. The refusal gates abort the push if raw memory, matters/outputs/client content, or org-derived files (CLAUDE.md, operating-rules, config/) ever get staged. Keep them; add new gate patterns as new confidential categories emerge.

See `scripts/README.md` for detail.

---

## Step 10: Verify

- [ ] `~/CLAUDE.md`, `~/.claude/CLAUDE.md`, `~/Desktop/Claude/CLAUDE.md` all reference your operating rules
- [ ] `~/AGENTS.md` points Codex to the same operating rules, voice profile, and memory files, if Codex is installed
- [ ] `~/.claude/plugins/config/claude-for-legal/operating-rules.md` exists, populated, NOT tracked by git
- [ ] `~/Desktop/Claude/` has all 12 plugin folders
- [ ] Google Drive has matching folder structure
- [ ] Voice profile exists at `~/Desktop/Claude/voice-profile/voice-profile.md`
- [ ] `~/bin/backup.sh` runs and pushes sanitized memory; the refusal gates block anything else
- [ ] `.gitignore` is working: `git status` in the repo should NOT show populated config files

---

## Step 11: Biweekly review

Set a recurring calendar reminder, every two weeks. Quarterly is too slow to be safe: this system evolves fast while you're actively building, and a stale rule or an unblocked confidential pattern is much cheaper to catch at week 2 than month 3.
- Re-read your operating rules and update for any new corporate policies
- Update your voice profile as your style evolves
- Audit `.gitignore` for new patterns of confidential content that should be blocked

---

## Step 12: First real use (test-drive)

Don't end setup with a config check; end it by watching your rules actually fire. Run this 10-minute test:

1. **Start a fresh session** in your workspace directory. Confirm the agent self-identifies with your `[MASTER_AGENT_NAME] @ [DEVICE_LABEL]` and references your operating rules unprompted.
2. **Give it a small real task** from your actual work (e.g., "draft a 3-line status update to [MANAGER] about X in my voice"). Check: did it use your voice profile's patterns?
3. **Try to make it break a rule.** Ask it to commit a file containing a made-up client name, or to build a small automation. PASS = it runs the Pre-Commit / Pre-System-Build gate (classifies, shows you the plan or diff, waits for your approval). FAIL = it just does it.
4. **Check the boundary.** Ask it to do something with the wrong account (work task via personal account or vice versa). PASS = it stops and asks.
5. **Check cross-model continuity, if both tools are installed.** Write a fictional checkpoint to a test memory file in one environment. Start a fresh session in the other environment and confirm it reads the checkpoint from the file. Reverse the direction once. Delete the fictional test data when complete.

If any check fails, the corresponding instruction file or operating-rules section is not loading or is not explicit enough. Fix it while the gap is fresh, before the first real incident.

---

## Troubleshooting

| Issue | Fix |
|---|---|
| `gh` not authenticating | Make sure you're using the correct GitHub account (personal vs. corporate). Re-run `gh auth login`. |
| Plugin install fails | Verify your Claude Code version supports plugins. Check the marketplace source URL. |
| Populated file gets staged for commit | Check `.gitignore`, add a more specific pattern if needed. Unstage with `git restore --staged <file>`. |
| Voice profile feels off | Re-run analysis in a session with more recent messages, or hand-edit the rules section. |
| Claude remembers but Codex does not | Confirm the governing `AGENTS.md` points to the same workspace memory files and that the session started inside its directory scope. |
| Codex remembers but Claude does not | Confirm the Claude `SessionStart` hook and `CLAUDE.md` paths point to the same workspace memory files. |

# scripts/

Automation for the Mage setup. Generic, fill-in-the-blanks versions of the scripts that run a real instance.

| Script | What it does |
|---|---|
| `backup-template.sh` | Pushes ONLY your sanitized memory (`memory-portable/`) and voice profile to your **private** backup repo. Refusal gates abort the commit if raw memory, matters/outputs/client content, or org-derived files (CLAUDE.md, operating-rules, plugin config) are ever staged. |

## Using `backup-template.sh`

1. Copy it somewhere on your PATH and make it executable:
   ```bash
   cp ~/Desktop/setup-mage/scripts/backup-template.sh ~/bin/backup.sh
   chmod +x ~/bin/backup.sh
   ```
2. Open it and fill in the four `[PLACEHOLDERS]` at the top (private repo path, device label, sanitized-memory dir, voice-profile path).
3. Run `~/bin/backup.sh` whenever you back up (after meaningful work, at end of day, or on demand).

**Why the gates matter:** this is the one piece of automation that *writes to a remote*. The gates are the difference between "I back up my sanitized notes" and "I accidentally pushed a client name to GitHub." Keep them. If you add new categories of confidential content, add a matching gate pattern.

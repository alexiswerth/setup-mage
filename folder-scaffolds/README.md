# Folder Scaffolds

Empty directory structures showing how the workspace should be laid out — both locally on your Mac and in your cloud storage (Google Drive / SharePoint / Dropbox).

> **These are documentation scaffolds, not working folders.** Use them as a reference when setting up a new environment. The `.gitkeep` files only exist to make git track the empty directories.

---

## `desktop-claude-layout/`

Mirrors what `~/Desktop/Claude/` should look like on your Mac after setup.

```
~/Desktop/Claude/
├── [plugin-name]/             ← One folder per installed plugin
│   ├── outputs/               ← Finished work product (gitignored — work product never leaves Mac)
│   └── matters/               ← Active matter workspaces (gitignored — client content)
├── voice-profile/             ← Personal voice profile (sanitized version may be committed)
├── templates/                 ← Reference templates you've collected
└── memory/                    ← Long-term reference Claude pulls from across sessions
```

To recreate this locally, run:
```bash
mkdir -p ~/Desktop/Claude/{commercial-legal,privacy-legal,ai-governance-legal,corporate-legal,employment-legal,ip-legal,litigation-legal,product-legal,regulatory-legal,legal-clinic,law-student,legal-builder-hub}/{outputs,matters}
mkdir -p ~/Desktop/Claude/{voice-profile,templates,memory}
```

---

## `google-drive-layout/`

Mirrors what `MyDrive/Claude/` should look like in your Google Drive (under your work account).

```
MyDrive/Claude/
├── templates/                 ← Drop reference docs here (your DPA template, privacy policy, etc.)
├── outputs/                   ← Finished work product, organized by plugin
│   └── [plugin-name]/         ← One subfolder per installed plugin
└── memory/                    ← Long-term reference Claude can read across sessions
```

To recreate, use Google Drive's web UI or the Drive API. The folder IDs from setup get recorded in your operating-rules.md (locally — not committed).

---

## Why this matters

Consistent folder structure across machines means:
1. **Reproducibility**: Anyone on your team can replicate your setup in minutes
2. **Claude can navigate predictably**: When Claude reads "look in outputs/", it knows exactly where that is
3. **Easy onboarding**: New environments get the right scaffolding from day one

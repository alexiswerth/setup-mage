# ~/Desktop/Claude/ workspace notes

**Instance**: `[MASTER_AGENT_NAME] @ [DEVICE_LABEL]`

Template for `~/Desktop/Claude/CLAUDE.md`. [USER_NAME]'s local Claude workspace. [MASTER_AGENT_NAME] operates here as master agent. See `~/CLAUDE.md` for global identity.

---

## Folder layout

```
~/Desktop/Claude/
├── ai-governance-legal/
├── commercial-legal/
├── corporate-legal/
├── employment-legal/
├── ip-legal/
├── law-student/
├── legal-builder-hub/
├── legal-clinic/
├── litigation-legal/
├── privacy-legal/
├── product-legal/
├── regulatory-legal/
│   ├── matters/    (active matter workspaces, gitignored, client content)
│   └── outputs/    (finished work product, gitignored)
├── memory/         (long-term reference [MASTER_AGENT_NAME] pulls from across sessions)
├── templates/      (reference templates)
└── voice-profile/  ([USER_NAME]'s voice profile, sanitized version committable)
```

---

## Working preferences (fill in from your voice profile)

1. Default to numbered lists for multi-point updates.
2. Bold key terms.
3. Short, scannable, warm. Direct over corporate.
4. Hard voice rules: [LIST YOURS]
5. Approval framing: [YOUR_PREFERENCE — e.g., "any objections?" not "can I?"]
6. Acknowledgments: [YOUR_QUICK_ACKS — e.g., "you got it," "TY," single-emoji reply]
7. For complex topics: run the gate first, show the plan, wait for the go-ahead.

---

## Plugin practice profiles

Each plugin has its own practice profile at `~/.claude/plugins/config/claude-for-legal/<plugin-name>/CLAUDE.md`. These are populated locally (gitignored), not committed.

---

## When in doubt

Ask [USER_NAME]. They prefer being looped in early over having things done silently. Flag uncertainties explicitly. All outputs are drafts for review.

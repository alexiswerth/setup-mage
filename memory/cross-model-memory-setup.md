# Cross-Model Memory Setup

This pattern lets one named agent preserve continuity across Claude Code and OpenAI Codex without exposing private conversation history or relying on either provider as the permanent memory store.

## The core idea

The model is the reasoning engine. The persistent agent is the external operating layer the user controls.

```text
                    USER-CONTROLLED OPERATING LAYER
          operating rules | voice | memory | current work state
                         /                         \
                 CLAUDE.md                         AGENTS.md
                 Claude Code                      OpenAI Codex
```

Claude Code and Codex do not send chats to each other. Each environment loads the same external files at session start.

## Shared local structure

```text
<WORKSPACE>/
├── CLAUDE.md
├── memory/
│   ├── MEMORY.md
│   ├── pending-todos.md
│   ├── _changelog.md
│   └── one-topic-per-memory-file.md
└── voice-profile/
    └── voice-profile.md

<LOCAL_CONFIG>/
└── operating-rules.md

<HOME>/
└── AGENTS.md
```

The populated files remain local or in an approved private store. The public repository contains templates only.

## What each file does

| File | Purpose |
|---|---|
| `CLAUDE.md` | Loads identity, rules, voice, and workspace instructions into Claude Code |
| `AGENTS.md` | Loads the same external operating layer into Codex |
| `MEMORY.md` | Short index pointing to detailed memory files |
| `pending-todos.md` | Current commitments, owners, deadlines, and waiting states |
| `_changelog.md` | Timestamped record of memory changes |
| `voice-profile.md` | Communication patterns and drafting preferences |
| `operating-rules.md` | Account boundaries, policy controls, and approval gates |

## Session-start contract

Each environment should do the following before substantive work:

1. Load the local operating rules.
2. Load the voice profile.
3. Read `MEMORY.md`, `pending-todos.md`, and the newest entries in `_changelog.md`.
4. Open only the detailed memory files relevant to the current request.
5. Verify important facts against the original source when one exists.

Claude Code can enforce this with a `SessionStart` hook. Codex can enforce it through the governing `AGENTS.md` instructions. Use `session-memory-autoload-setup.md` for the Claude hook and `../github-templates/AGENTS-template-global.md` for the Codex loader.

## Writing memory safely

1. Write a decision, correction, deadline, or next action to the appropriate local file in the same session.
2. Add or update the one-line pointer in `MEMORY.md`.
3. Update `pending-todos.md` when the item is active.
4. Add a timestamped entry to `_changelog.md`.
5. Keep raw client data, credentials, account details, and confidential source material out of any public or portable memory layer.

## Cross-model verification

Use fictional data for the test.

1. In Claude Code, write a synthetic checkpoint to a test memory file.
2. Start a fresh Codex session under the same workspace.
3. Confirm Codex reads the checkpoint without pasting the Claude conversation.
4. Add a second synthetic checkpoint in Codex.
5. Start a fresh Claude Code session and confirm it reads the second checkpoint.
6. Delete the synthetic test data when verification is complete.

Passing this test proves file-based continuity. It does not prove that the model providers share chat history, because they do not.

## Public-repository boundary

Safe to publish:

- Empty folder scaffolds
- Templates with bracketed placeholders
- Generic architecture diagrams
- Sanitized methodology
- Test instructions using fictional data

Keep private:

- Populated instruction files
- Real names and contact information
- Client, employer, or matter details
- Live memory and to-do files
- Voice examples tied to identifiable people
- Credentials, account identifiers, and local machine paths

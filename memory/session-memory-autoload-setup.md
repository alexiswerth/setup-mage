> **Anonymized example from a live Mage setup.** Real names, companies, and identifying details are replaced with [TOKENS]. Patterns are illustrative, not universal rules; swap in your own specifics when adopting.
> _Auto-synced by sync-setup-mage.sh. Do not hand-edit this file, changes are overwritten on the next sync._

# Setup: Auto-load memory into every Mage session

Last updated: 2026-06-03

A generalizable fix for a real failure: a full to-do list was built in one session, never written to a file, and was invisible to the next session that opened. This setup makes every new session automatically load the instance's memory, with no user effort.

## The root-cause lesson

Three things have to be true, or memory silently fails:
1. **A conversation is not a memory until it is written to a file.** Anything important must be captured to a memory file in the same session it is created.
2. **The memory index must be populated.** An empty `MEMORY.md` means nothing points the agent at its own memory on startup.
3. **Sessions start fresh.** The agent reloads instruction files (CLAUDE.md) every session but does NOT reload past conversations. Only files on disk survive.

## The three-part fix

### 1. A populated memory index (`MEMORY.md`)
One pointer line per memory file. Loaded at session start. Never put memory content here, only pointers.

### 2. A session-start protocol in the workspace CLAUDE.md
Binding instruction: every new session, before substantive work, read the index, the live to-do board, and the most recent changelog entries. Plus a capture rule: never leave important state living only in chat.

### 3. A SessionStart hook (the hard automation)
Add this to the instance's `settings.json`. It injects the memory index and to-do board into context at the start of every session, automatically. Replace the paths with your own workspace memory paths.

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "printf '{\"hookSpecificOutput\":{\"hookEventName\":\"SessionStart\",\"additionalContext\":%s}}' \"$(cat <WORKSPACE>/memory/MEMORY.md <WORKSPACE>/memory/pending-todos.md 2>/dev/null | head -c 20000 | jq -Rs .)\"",
            "statusMessage": "Loading memory + to-do board",
            "timeout": 15
          }
        ]
      }
    ]
  }
}
```

Notes:
- Requires `jq` (preinstalled on most systems; `which jq` to confirm).
- `head -c 20000` caps the injected size; raise it if the combined files are larger, lower it to save per-session context tokens.
- The hook reads only local memory files. It carries no secrets and sends nothing over the network.
- Validate after editing: `jq empty <path>/settings.json` should print nothing (valid). Then open a fresh session, the agent should already know the board.

## Verifying it works
Open a brand-new session and say nothing about your tasks. If the hook is live, the agent already has your to-do board. If it comes in blank, the settings watcher may need a reload (open the hooks menu once, or restart).

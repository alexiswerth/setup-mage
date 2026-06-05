# Memory Persistence Methodology

*A standing rule for any Mage instance to prevent session-to-session context loss.*

---

## The problem

AI agent sessions can crash, freeze, or end unexpectedly. If the agent only writes memory at end-of-day, everything since the last save is lost. The next session starts cold with zero context. This compounds when the agent is deep in a complex task and deprioritizes housekeeping in favor of task execution.

---

## The rule

**Write memory entries as you complete meaningful work blocks, not just at session end.** Do not wait for EOD. Do not wait for the user to ask.

---

## When to write memory

| Trigger | What to write |
|---|---|
| After completing a meaningful task | Project memory: what was done, current state, next steps |
| After discovering a new reference doc | Reference memory: what it is, where it lives, how to find it |
| After making a strategy decision or pivot | Project memory: what changed and why |
| After hitting a blocker | Project memory: what's blocked, what was tried, what failed |
| Every 60-90 minutes of active work | Prompt the user for a backup checkpoint |
| Before any session ends | Session handoff note with current state |

---

## Memory vs. backup

These are two separate obligations:

| Action | Who initiates | What it does |
|---|---|---|
| **Write memory** | Agent (autonomous) | Creates/updates memory files on disk. No approval needed. |
| **Run backup** | Agent prompts, user approves | Pushes sanitized memory to a persistent store (git repo, cloud). Needs user approval for the commit/push. |

The agent must do both, but they are independent. Even if the user never approves a backup, the agent should still be writing memory to disk so the next local session can pick it up.

---

## Fail-fast on tool issues

If an MCP or external tool returns empty, capped, or unexpected results:

1. Surface it to the user within 30 seconds
2. State what you expected vs. what you got
3. Propose a workaround or ask for direction
4. Do NOT enter an extended thinking loop trying to figure it out silently

A 30-second "this isn't working" message is infinitely more valuable than 17 minutes of silent thinking followed by a crash.

---

*Methodology version: v1 (2026-06-05). Derived from a real incident where three sessions of work were lost because no memory was written, and a fourth session froze for 17 minutes on a tool issue before crashing.*

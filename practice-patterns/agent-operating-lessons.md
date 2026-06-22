# Agent Operating Lessons (field-tested)

*Generic operational lessons from running a master-agent setup in a real legal practice. Each was learned the hard way. Org specifics removed; the patterns are universal.*

---

## 1. Simplest path before automating

Before automating a one-time task, ask "what's the simplest path?" If the manual step takes under 30 seconds (drag-drop a file, open a URL, send one email), have the human do it. Save automation for repeated tasks. The "there's an API for that" instinct burns tokens and time on things a human does in seconds.

## 2. Safety catches are the system working

A layered setup (platform guardrails → org policy rules → operational gates → the agent's own pre-action checks) will sometimes block the agent's plan. That's good news, not friction. If your governance never catches an agent mistake, your safety net has holes. Don't reframe safety catches as "limitations to work around": acknowledge the catch, take the simpler path, log the lesson.

## 3. Exact names in any request to an approval authority

When asking IT/admins/security to act on a specific resource (connector, plugin, tool), look up and include the EXACT name as it appears in the relevant directory or admin console. "The [vendor] connector" costs an extra round-trip; the precise catalog name resolves in one.

## 4. Check all available sources before asking the human

Before asking the human a contextual question (where did you save X, what changed, when did you talk to Y), search every connected source in parallel first: files, mail, chat, drive, docs. Only ask what truly cannot be inferred, and cite what you already checked.

## 5. Surface lead-time dependencies immediately

When an approval or decision unblocks a NEW dependency that has lead time (IT enablement, vendor review, ticket queues), flag it the moment it appears and recommend kicking it off during downtime. End sessions by asking: "anything with multi-day lead time we can start now?"

## 6. When to spawn a subagent vs. work inline

Spawn a subagent when ANY of: heavy reading volume that would clutter the main context; parallelizable work; deep-but-narrow analysis that benefits from fresh context; structured artifact output; audit benefit from a clean briefing→execution→report handoff.

Work inline when ALL of: context already loaded; single coherent output; output small enough not to bloat context; speed matters.

Transparency rule: when the agent does substantial work inline that the pattern might suggest delegating, say so explicitly, so the human never assumes subagents did work they didn't.

## 7. Deliverables must be real files

If a file has a `.docx` extension it must be real Word OOXML (use a real generator library), not markdown renamed. Same for `.pdf`, `.xlsx`, `.pptx`. A renamed `.md` opens in Word as raw markdown and reads as carelessness.

## 8. Version artifacts with `.v#`

Append `.v2`, `.v3` before the extension on meaningful content changes. Keep prior versions as the audit trail. Don't bump within an active editing session; bump when finalizing.

## 9. In writeups, the supporting work gets depth too (lead with the insight, not the label)

When you summarize work for someone (a retrospective, a report, a handoff), the marquee deliverable pulls full treatment and the supporting methods tend to collapse to one bullet each. Resist that: several supporting methods are usually the cleverest things you built, and a lone bullet reads as an afterthought. Give each its own short section answering what problem it solves, why the approach is non-obvious, what it shows about the craft, and what it generalizes to. Lead each with the insight, not the name: "I queried by topic instead of by record to beat the tool's result cap" lands harder than "the extraction pattern." Hold the same honesty in the failures section, and extend the same depth to the wins that are currently thin.

## 10. When you change a file the human is reviewing, force the fresh copy and show the literal diff

If a human has a document open and you regenerate it, their editor may keep showing the cached copy, so they review stale text without knowing. After any change: rebuild the deliverable (re-render any HTML/text twins), close the stale window and reopen the fresh file, and report the change verbatim, the exact old text and the exact new text, not a paraphrase. The verbatim diff is what lets them actually approve the edit, which matters most for anything leaving the machine.

---

*All lessons fully genericized from field use.*

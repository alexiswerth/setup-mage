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

## 11. Generate Office files with a real library, not an HTML converter

When you need a real `.docx`/`.xlsx`/`.pptx`, build it with a document library that gives you explicit control (e.g. python-docx), not by converting HTML→Office with a generic system converter. HTML→Office converters inject styling artifacts you didn't ask for — the classic failure is bold text and headings rendered in red, or literal markdown leaking through. You often won't see it until the human opens the file and it looks broken. Set text color, fonts, and heading styles explicitly; verify the output (e.g. grep the document XML for unexpected colors) before handing it over.

## 12. HTML is a local-render format, not a shareable cloud artifact

An `.html` file only renders in a browser opened against the local file. Drop it in a cloud drive and the in-app preview shows the raw source code, not the page — there's no setting that fixes this (cloud drives don't host/serve HTML). So: keep HTML as your *local* review artifact, and share formatted output as a real Doc/Word file (which previews correctly in-browser via a link). If a recipient genuinely needs the HTML, tell them to **download it first, then open the downloaded file** — opening it inside the cloud drive will only ever show code.

## 13. One source of truth, render the rest

For any deliverable that exists in multiple formats (markdown + HTML + Word), keep a single source file and *generate* the others from it on every change. Never hand-edit the derived copies — they drift, and you lose track of which is current. Pair this with lesson 10: after regenerating, force the human's stale window closed and reopen the fresh render. The discipline is "edit the source, re-run the build, reopen the output," every time.

## 14. Pre-check tool capability before promising; fail fast at the first wall

Before promising an outward or irreversible action (edit an existing cloud doc, upload a file, post somewhere), confirm the capability actually exists. Many integrations have sharp limits you only hit mid-task: a read+create file connector may have **no edit tool** for existing docs and **no delete tool** to self-clean a mistake; uploads may require the whole file inline as a parameter, so **large binaries blow the size limit** and can't be sent at all. When you hit a wall like this, STOP and surface it in your first response, don't rabbit-hole through weak workarounds (re-compress, re-format, regenerate) that waste time the human could have skipped in seconds. Default to handing the human a **copy-paste-ready artifact** plus exactly where it goes when the tool can't complete the last step itself.

## 15. Back up proactively, don't gate it behind a question

When work is done or memory/deliverables have changed, run the backup yourself rather than asking "want me to back up?" Losing work is the bigger risk; the confirmation tax isn't worth it. Still report what was pushed, and the pre-commit gate (sanitize, strip, verify) still runs on anything new, but the routine backup itself shouldn't wait to be told. Back up at end of task, after meaningful memory writes, and at end of day, by default.

## 16. Match deliverable format to how it will be used

Don't default to the most elaborate or most "final" format. Pick the one that fits the recipient's actual workflow: an editable doc if they'll mark it up, plain text (or a clean code block) if they'll paste it into mail or chat where markdown won't render, a real Office file if they need to open it in that app. When the format is genuinely ambiguous (redline vs. memo, one-pager vs. full brief, editable vs. read-only), **ask "do you need X or Y?"** instead of guessing. The wrong format reads as either careless or as extra work for them to convert.

---

*All lessons fully genericized from field use.*

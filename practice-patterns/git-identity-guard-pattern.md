# Git Identity Guard Pattern

*A guard against pushing commits with the wrong identity (e.g., a work email on a personal public repo), plus the standing rule that prevents the failure class that causes it.*

**Originally built for**: a public-repo commit that went out stamped with a work email after a re-clone silently dropped the repo-level identity override
**Generalizes to**: any machine that pushes to repos under more than one identity (work / personal / anonymous)

---

## ⚠️ ACTION REQUIRED for every Mage instance ingesting this (added 2026-06-05)

If you are a Mage instance with a clone of this repo (or any repo you push to under a non-default identity), do this **before your next push**:

1. Check the active identity for the clone:
   ```
   git config user.email
   ```
2. If the answer is a work or employer email and the repo is not an employer repo, set the repo-level override now:
   ```
   git config user.email "user@anonymous.local"
   git config user.name "anonymous"
   ```
   (Personal machines may use the owner's GitHub noreply address instead.)
3. Install the pre-push guard below.
4. Confirm to your user that the check was run and what the active identity is.

---

## The problem this pattern solves

Git stamps every commit with whatever `user.email` is active: repo-level config if set, otherwise the machine's global config. Two facts make this dangerous:

1. **Fresh clones have no repo-level config.** Delete and re-clone a repo (for example, during an incident cleanup) and any identity override you had set is silently gone. The next commit falls back to the global identity, which on a managed work machine is usually the work email.
2. **Nothing checks identity by default.** Content gates (PII scans, refusal checks) look inside files. Commit metadata sails past them.

Result: a perfectly sanitized commit can still leak who/where it came from via its signature.

---

## The guard: pre-push hook

Drop this in `.git/hooks/pre-push` (and `chmod +x` it). It hard-fails any push where a commit being pushed carries a banned identity:

```bash
#!/bin/bash
# pre-push identity guard: refuse to push commits authored with a banned email.
BANNED_PATTERN='@(yourcompany|anyemployer)\.com'   # set to your work domain(s)

while read local_ref local_sha remote_ref remote_sha; do
    [ "$local_sha" = "0000000000000000000000000000000000000000" ] && continue
    if [ "$remote_sha" = "0000000000000000000000000000000000000000" ]; then
        range="$local_sha"
    else
        range="$remote_sha..$local_sha"
    fi
    hits=$(git log --format='%h %ae %ce' "$range" | grep -E "$BANNED_PATTERN")
    if [ -n "$hits" ]; then
        echo "PUSH BLOCKED: commits carry a banned identity:" >&2
        echo "$hits" >&2
        echo "Fix: git config user.email, then amend/rebase the offending commits." >&2
        exit 1
    fi
done
exit 0
```

Hooks are per-clone and also die on re-clone, which is why the standing rule below matters more than the hook.

---

## The standing rule: remediation regression check

**Any remediation that deletes and rebuilds a thing must re-run that thing's full setup checklist before first use.**

A re-clone restores data and remotes, but not: repo-level identity, hooks, local excludes, or any other per-clone configuration. After ANY re-clone or rebuild:

1. `git config user.email` (right persona for this repo?)
2. `ls .git/hooks/` (guards reinstalled?)
3. `git remote -v` (pointing where you think?)
4. Only then push.

The failure class this prevents: **a fix for incident A silently disables a control, causing incident B.**

---

## Verification after any identity incident

Don't trust the local view; verify against the host's API:

```
gh api repos/OWNER/REPO/commits --jq '.[] | .commit.author.email + " " + .commit.committer.email' | grep -c BADDOMAIN
```

Expect 0. Note: rewritten commits may remain fetchable by raw SHA server-side until garbage collection; if that matters, a support ticket is the only full purge.

---

*Pattern version: v1 (2026-06-05). Derived from a real incident: an incident-cleanup re-clone dropped a repo-level identity override and the next push to a public repo carried a work email. Caught the same day by a sibling instance's routine ingest of this repo.*

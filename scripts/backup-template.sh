#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────────────────────────────────
# backup-template.sh — push ONLY sanitized memory + voice profile to your
# private backup repo, with hard refusal gates that abort if raw/confidential
# content is ever staged.
#
# This is the generic, fill-in-the-blanks version of the backup automation.
# Copy it somewhere on PATH (e.g. ~/bin/backup.sh), make it executable
# (chmod +x), fill in the [PLACEHOLDERS], and run it whenever you back up.
#
# The model: only TWO things ever leave the machine —
#   1. memory-portable/  (the sanitized twin of your raw memory)
#   2. voice-profile.md  (your communication style guide, names stripped)
# Everything else (raw memory, matters/outputs, populated CLAUDE.md +
# operating-rules + plugin config) stays LOCAL and is refused by the gates.
# ─────────────────────────────────────────────────────────────────────────────

# ---- Fill these in ----
REPO=~/[PATH-TO]/[your-private-backup-repo]      # local clone of your PRIVATE repo
INSTANCE="[DEVICE_LABEL]"                          # e.g. home-mac, work-mac
SANITIZED_MEMORY_DIR=~/[PATH-TO]/memory-portable   # your sanitized memory twin
VOICE_PROFILE=~/[PATH-TO]/voice-profile.md         # your sanitized voice profile (optional)
# ------------------------

TIMESTAMP=$(date +%Y-%m-%d-%H%M)
echo "=== backup ($INSTANCE) ==="

# ---- Collect the allow-listed files into the repo ----
if [ -f "$VOICE_PROFILE" ]; then
  cp "$VOICE_PROFILE" "$REPO/voice-profile.md"
fi

if [ -d "$SANITIZED_MEMORY_DIR" ]; then
  mkdir -p "$REPO/memory-portable"
  rsync -a --delete "$SANITIZED_MEMORY_DIR/" "$REPO/memory-portable/"
fi

# ---- Refusal gates: abort if anything that must stay local got staged ----
cd "$REPO"
git add -A
STAGED=$(git diff --cached --name-only)

RAW_LEAK=$(echo "$STAGED"     | grep -E '^memory/' | grep -v '^memory-portable/' || true)
MATTERS_LEAK=$(echo "$STAGED" | grep -E '(matters/|outputs/|client-)' || true)
DERIVED_LEAK=$(echo "$STAGED" | grep -E '(operating-rules|CLAUDE-|config/)' || true)

if [ -n "$RAW_LEAK" ]; then
  echo "ABORT: raw memory files staged. Policy violation."; echo "$RAW_LEAK"
  git reset HEAD -- . >/dev/null 2>&1; exit 1
fi
if [ -n "$MATTERS_LEAK" ]; then
  echo "ABORT: matters/outputs/client content staged. Policy violation."; echo "$MATTERS_LEAK"
  git reset HEAD -- . >/dev/null 2>&1; exit 1
fi
if [ -n "$DERIVED_LEAK" ]; then
  echo "ABORT: org-derived files staged (CLAUDE.md, operating-rules, config/). These stay local."
  echo "$DERIVED_LEAK"
  git reset HEAD -- . >/dev/null 2>&1; exit 1
fi

# ---- Commit + push ----
if git diff --cached --quiet; then
  echo "Nothing to commit. Already up to date."; exit 0
fi

git commit -m "backup: $INSTANCE $TIMESTAMP"
git push origin main
echo "=== backup complete ($INSTANCE $TIMESTAMP) ==="

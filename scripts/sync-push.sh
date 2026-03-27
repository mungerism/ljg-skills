#!/bin/bash
# Usage: sync-push.sh <skill-name> <commit-message>
# Syncs a local ljg-* skill to the repo and pushes.

set -euo pipefail

SKILL="$1"
MSG="$2"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
REPO="${LJG_SKILLS_REPO:-$HOME/Code/Repos/Personal/ljg-skills-codex}"
LOCAL="$CODEX_HOME/skills/$SKILL"
TARGET="$REPO/skills/$SKILL"

if [ ! -d "$LOCAL" ]; then
  echo "ERROR: $LOCAL does not exist" >&2
  exit 1
fi

cd "$REPO"
git pull --rebase --quiet
rsync -av --delete --exclude='.git' "$LOCAL/" "$TARGET/"
git add "skills/$SKILL"
git diff --cached --quiet && { echo "No changes to push."; exit 0; }
git commit -m "$MSG"
git push

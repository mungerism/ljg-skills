# Repository Guidelines

## Overview

- This fork is maintained for Codex first.
- The long-lived Codex compatibility branch is `codex-main`.
- Install and update this repository through `npx skills`, not by copying directories manually.

## Installation

- Full install:
  `npx skills add https://github.com/mungerism/ljg-skills/tree/codex-main -g -a codex`
- Single skill install:
  `npx skills add https://github.com/mungerism/ljg-skills/tree/codex-main -g -a codex --skill <skill-name>`
- `ljg-card` dependencies:
  `bash scripts/install.sh`

## Structure Rules

- Keep skills under `skills/<name>/`.
- Every skill directory must contain a valid `SKILL.md` with at least `name` and `description` in frontmatter.
- Preserve skill names and directory names unless there is a migration plan that keeps `npx skills` discovery stable.
- Keep `.claude-plugin/` only as a compatibility artifact; do not treat it as the primary integration path.

## Compatibility Rules

- Do not introduce hard-coded Claude-specific paths such as `~/.claude/skills/...`.
- Prefer relative references inside skill docs, references, scripts, and templates.
- Flow skills must remain usable in Codex without assuming Claude-only delegation semantics; default to serial execution unless concurrency is explicitly safe.
- If a skill depends on optional external capabilities, document the fallback behavior in the skill itself.

## Output Contracts

- Text and org-mode outputs should continue to target `~/Documents/notes/` unless the skill explicitly defines another path.
- Visual outputs should continue to target `~/Downloads/`.
- Do not change output filenames or public invocation names casually; treat them as user-facing contracts.

## Maintenance

- Sync upstream changes into the fork's default branch first, then merge or rebase into `codex-main`.
- Validate with `npx skills add <source> --list` before publishing branch changes meant for installation.
- For runtime-dependent skills such as `ljg-card`, verify that dependency failure messages remain actionable.

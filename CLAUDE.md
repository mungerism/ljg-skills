# CLAUDE.md

Legacy compatibility notes for Claude-oriented tooling. This fork is maintained for Codex first.

## Overview

This repository is a personal skills collection managed through `npx skills`. The canonical install target for this fork is Codex global skills at `~/.codex/skills/`.

## Repository Structure

```text
ljg-skills/
├── skills/
│   └── ljg-*/          # Each skill directory contains SKILL.md and optional assets/references
├── scripts/            # Helper scripts for dependency setup and local maintenance
├── README.md
└── .claude-plugin/     # Kept only for marketplace compatibility and discovery
```

## Commands

Install the full collection into Codex:

```bash
npx skills add https://github.com/mungerism/ljg-skills/tree/codex-main -g -a codex
```

Install `ljg-card` dependencies:

```bash
bash scripts/install.sh
```

Inspect installed skills for Codex:

```bash
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}" bash skills/ljg-skill-map/scripts/scan.sh
```

## Architecture Notes

- `skills/<name>/SKILL.md` is the source of truth for discovery.
- `ljg-card` is the only skill with a runtime dependency on Node.js and Playwright.
- Flow skills must remain usable in Codex even when advanced delegation features are unavailable; default to serial execution.
- Keep output contracts stable: text goes to `~/Documents/notes/`, visual assets go to `~/Downloads/`.

## Development Guidelines

- Preserve skill names and frontmatter keys so `npx skills` can keep discovering them.
- Avoid hard-coded agent-specific paths such as `~/.claude/skills/...`.
- Prefer relative references inside skill docs and Codex-compatible shell commands in examples.
- If a skill references an external capability that may not exist in every environment, document the fallback behavior in the skill itself.

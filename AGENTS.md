# AGENTS.md

This file provides guidance to Codex when working with code in this repository.

## Overview

This is a personal Codex skills repository. Each skill is a self-contained directory that can be installed through `npx skills` and used from Codex.

## Repository Structure

```text
ljg-skills/
├── skills/
│   └── ljg-*/          # Each skill directory contains SKILL.md and optional references/assets/scripts
├── scripts/
├── README.md
├── AGENTS.md
└── .gitignore          # Ignores everything except tracked root files, scripts, and skills
```

## Skill Format

Each `SKILL.md` follows this structure:

```yaml
---
name: skill-name
description: "What this skill does. Use when user says..."
user_invocable: true|false
version: "x.x.x"
---

# Skill content in markdown...
```

## Skill Inventory

| Skill | Purpose | External Dependencies |
|-------|---------|----------------------|
| `ljg-card` | Content → PNG visuals (long cards, infographs, posters) | Node.js + Playwright |
| `ljg-paper` | Academic paper analysis pipeline | None |
| `ljg-paper-flow` | Paper workflow (paper + card combined) | None |
| `ljg-plain` | Plain language rewriter | None |
| `ljg-skill-map` | Visual overview of installed skills | Bash |
| `ljg-word` | English word deep-dive | None |
| `ljg-writes` | Writing engine for thinking through ideas | None |

## Commands

### Install ljg-card Dependencies

`ljg-card` requires Playwright for screenshot capture:

```bash
cd skills/ljg-card && npm install && npx playwright install chromium
```

### Test ljg-skill-map Scanner

```bash
bash skills/ljg-skill-map/scripts/scan.sh
```

### Install Skills (for users)

```bash
npx skills add https://github.com/mungerism/ljg-skills/tree/codex-main -g -a codex
```

## Architecture Notes

### Skill Invocation

- Skills with `user_invocable: true` can be triggered via `/skill-name` or natural language
- Trigger phrases are defined in each skill's `description` field
- Skills can call other skills when the runtime supports skill composition; default to simpler serial execution when in doubt

### Content Processing Pipeline

Several skills share a common pattern for content ingestion:
- **URL** → Read webpage content
- **File path** → Read file content
- **Raw text** → Direct use

### ljg-card Architecture

The most complex skill with multiple rendering modes:

1. **HTML Templates**: Stored in `assets/` (`long_template.html`, `infograph_template.html`, `poster_template.html`)
2. **Capture Script**: `assets/capture.js` uses Playwright to screenshot HTML → PNG
3. **Reference Docs**: `references/taste.md` (design guidelines), `references/mode-*.md` (mode-specific instructions)
4. **Output**: PNG files written to `~/Downloads/`

### Shared Conventions

**Org-mode output** (`ljg-paper`, `ljg-plain`, `ljg-writes`):
- Bold: `*text*` (single asterisk, not `**`)
- Filenames: `{timestamp}--{title}__{type}.org`
- Output directory: `~/Documents/notes/`
- Timestamps: `date +%Y%m%dT%H%M%S`

**ASCII Art**:
- Allowed: `+ - | / \ > < v ^ * = ~ . : # [ ] ( ) _ , ; ! ' "`
- Forbidden: Unicode box-drawing characters

## Development Guidelines

- Skills are atomic units; each skill directory is self-contained
- Version numbers are manually maintained in `SKILL.md` frontmatter
- The `.gitignore` ignores all files by default; explicitly unignore with `!pattern`
- When modifying skill logic, update both the `SKILL.md` and any referenced files in `references/`
- Keep instructions semantically aligned with the original upstream `CLAUDE.md` guidance unless Codex compatibility requires a change

## Testing Changes

After modifying a skill:
1. Validate discovery with `npx skills add <source> --list`
2. Install to Codex with `npx skills add https://github.com/mungerism/ljg-skills/tree/codex-main -g -a codex`
3. Restart Codex to reload skills
4. Test via natural language trigger or `/skill-name`

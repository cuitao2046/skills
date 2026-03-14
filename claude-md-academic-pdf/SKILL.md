---
name: md-to-pdf
description: >
  Convert academic Markdown files to professionally typeset PDF documents.
  Use this skill when the user wants to convert a .md file to PDF, generate
  an academic paper PDF, format a thesis or conference paper, or use IEEE/ACM/IMMC
  templates. Supports table of contents generation, KaTeX math formulas, local
  and remote images, and flexible page break modes.
version: 1.0.0
author: cuitao2046
allowed-tools:
  - Bash
  - Read
  - Write
---

# Markdown to PDF Skill

Convert Markdown files into professionally typeset academic PDFs.

## When to use this skill

Activate when the user asks to:
- Convert a `.md` file to PDF
- Generate an academic paper, thesis, or conference paper PDF
- Use IEEE, ACM, or IMMC formatting templates
- Format a paper with table of contents, math formulas, or page breaks

## How to convert

Run the conversion tool:

```bash
node ~/.claude/skills/md-to-pdf/tools/convert.js <input_file> [options]
```

Options:
- `--template <name>` — `default`, `ieee`, `acm`, `immc` (default: `default`)
- `--pagebreak <mode>` — `none`, `academic`, `chapter` (default: `none`)
- `--no-toc` — disable table of contents

## Examples

```bash
# Basic conversion
node ~/.claude/skills/md-to-pdf/tools/convert.js paper.md

# IEEE conference paper
node ~/.claude/skills/md-to-pdf/tools/convert.js paper.md --template ieee

# Journal paper with section breaks
node ~/.claude/skills/md-to-pdf/tools/convert.js paper.md --template ieee --pagebreak academic

# Thesis with chapter breaks
node ~/.claude/skills/md-to-pdf/tools/convert.js thesis.md --template immc --pagebreak chapter
```

## Templates

| Template | Use Case |
|----------|----------|
| `default` | General academic papers |
| `ieee` | IEEE conferences/journals |
| `acm` | ACM conferences |
| `immc` | Mathematical modeling contests |

## Page Break Modes

| Mode | Behavior |
|------|----------|
| `none` | No page breaks (conference papers) |
| `academic` | Breaks before Abstract, References, Appendix |
| `chapter` | Break before every `##` heading (thesis) |

## Output

PDF is generated in the same directory as the input file with the same name.

`paper.md` → `paper.pdf`

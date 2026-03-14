#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"

$SKILL_NAME = "md-to-pdf"
$INSTALL_DIR = Join-Path $HOME ".claude\skills\$SKILL_NAME"

Write-Host "📦 Installing Claude Skill: $SKILL_NAME" -ForegroundColor Cyan

# Create skills directory
$skillsDir = Join-Path $HOME ".claude\skills"
if (-not (Test-Path $skillsDir)) {
    New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null
}

# Clone repository to temp and copy skill
$tempRepo = Join-Path $env:TEMP "skills-repo-$(Get-Random)"
Write-Host "📥 Cloning repository..." -ForegroundColor Yellow
git clone https://github.com/cuitao2046/skills.git $tempRepo

if (Test-Path $INSTALL_DIR) {
    Remove-Item -Path $INSTALL_DIR -Recurse -Force
}
Copy-Item -Path "$tempRepo\claude-md-academic-pdf" -Destination $INSTALL_DIR -Recurse -Force
Remove-Item -Path $tempRepo -Recurse -Force

Set-Location $INSTALL_DIR

# Install Node.js dependencies
if (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host "📦 Installing Node.js dependencies..." -ForegroundColor Yellow
    npm install
} else {
    Write-Host "⚠️  npm not found, skipping dependency installation" -ForegroundColor Yellow
}

# Install Chrome for Puppeteer
if (Get-Command npx -ErrorAction SilentlyContinue) {
    Write-Host "🌐 Installing Chrome for PDF generation..." -ForegroundColor Yellow
    npx puppeteer browsers install chrome
} else {
    Write-Host "⚠️  npx not found, skipping Chrome installation" -ForegroundColor Yellow
}

# Generate localized SKILL.md with absolute paths
$skillMdContent = @"
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
- Convert a ```.md``` file to PDF
- Generate an academic paper, thesis, or conference paper PDF
- Use IEEE, ACM, or IMMC formatting templates
- Format a paper with table of contents, math formulas, or page breaks

## How to convert

```bash
node $INSTALL_DIR\tools\convert.js <input_file> [options]
```

Options:
- ```--template <name>``` — ```default```, ```ieee```, ```acm```, ```immc```
- ```--pagebreak <mode>``` — ```none```, ```academic```, ```chapter```
- ```--no-toc``` — disable table of contents

## Examples

```bash
node $INSTALL_DIR\tools\convert.js paper.md
node $INSTALL_DIR\tools\convert.js paper.md --template ieee
node $INSTALL_DIR\tools\convert.js paper.md --template ieee --pagebreak academic
node $INSTALL_DIR\tools\convert.js thesis.md --template immc --pagebreak chapter
```

## Templates

| Template | Use Case |
|----------|----------|
| default  | General academic papers |
| ieee     | IEEE conferences/journals |
| acm      | ACM conferences |
| immc     | Mathematical modeling contests |

## Page Break Modes

| Mode     | Behavior |
|----------|----------|
| none     | No page breaks (conference papers) |
| academic | Breaks before Abstract, References, Appendix |
| chapter  | Break before every ## heading (thesis) |

## Output

PDF is generated in the same directory as the input file with the same name.
"@

Set-Content -Path "$INSTALL_DIR\SKILL.md" -Value $skillMdContent -Encoding UTF8

Write-Host ""
Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Skill installed to: $INSTALL_DIR"
Write-Host "Claude CLI will automatically load this skill from ~/.claude/skills/"
Write-Host ""
Write-Host "Usage (ask Claude directly):"
Write-Host "  'Convert paper.md to PDF using IEEE template'"
Write-Host "  'Convert thesis.md to PDF with chapter page breaks'"
Write-Host ""
Write-Host "Or run directly:"
Write-Host "  node $INSTALL_DIR\tools\convert.js <file> [--template ieee] [--pagebreak academic]"

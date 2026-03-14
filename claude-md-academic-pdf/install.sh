#!/bin/bash

set -e

SKILL_NAME="md-to-pdf"
INSTALL_DIR="$HOME/.claude/skills/$SKILL_NAME"

echo "📦 Installing Claude Skill: $SKILL_NAME"

# Create skills directory
mkdir -p ~/.claude/skills

# Clone repository to temp and copy skill
if [ ! -d "$INSTALL_DIR" ]; then
    echo "📥 Cloning repository..."
    TEMP_REPO=$(mktemp -d)
    git clone https://github.com/cuitao2046/skills.git "$TEMP_REPO"
    cp -r "$TEMP_REPO/claude-md-academic-pdf/." "$INSTALL_DIR"
    rm -rf "$TEMP_REPO"
else
    echo "📂 Updating existing installation..."
    TEMP_REPO=$(mktemp -d)
    git clone https://github.com/cuitao2046/skills.git "$TEMP_REPO"
    cp -r "$TEMP_REPO/claude-md-academic-pdf/." "$INSTALL_DIR"
    rm -rf "$TEMP_REPO"
fi

cd "$INSTALL_DIR"

# Install Node.js dependencies
if command -v npm &> /dev/null; then
    echo "📦 Installing Node.js dependencies..."
    npm install
else
    echo "⚠️  npm not found, skipping dependency installation"
fi

# Install Chrome for Puppeteer
if command -v npx &> /dev/null; then
    echo "🌐 Installing Chrome for PDF generation..."
    npx puppeteer browsers install chrome
else
    echo "⚠️  npx not found, skipping Chrome installation"
fi

# Make entry point executable
chmod +x "$INSTALL_DIR/tools/convert.js"

# Generate localized SKILL.md with absolute paths
cat > "$INSTALL_DIR/SKILL.md" << SKILLMD
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
- Convert a \`.md\` file to PDF
- Generate an academic paper, thesis, or conference paper PDF
- Use IEEE, ACM, or IMMC formatting templates
- Format a paper with table of contents, math formulas, or page breaks

## How to convert

Run the conversion tool:

\`\`\`bash
node $INSTALL_DIR/tools/convert.js <input_file> [options]
\`\`\`

Options:
- \`--template <name>\` — \`default\`, \`ieee\`, \`acm\`, \`immc\` (default: \`default\`)
- \`--pagebreak <mode>\` — \`none\`, \`academic\`, \`chapter\` (default: \`none\`)
- \`--no-toc\` — disable table of contents

## Examples

\`\`\`bash
node $INSTALL_DIR/tools/convert.js paper.md
node $INSTALL_DIR/tools/convert.js paper.md --template ieee
node $INSTALL_DIR/tools/convert.js paper.md --template ieee --pagebreak academic
node $INSTALL_DIR/tools/convert.js thesis.md --template immc --pagebreak chapter
\`\`\`

## Templates

| Template | Use Case |
|----------|----------|
| \`default\` | General academic papers |
| \`ieee\` | IEEE conferences/journals |
| \`acm\` | ACM conferences |
| \`immc\` | Mathematical modeling contests |

## Page Break Modes

| Mode | Behavior |
|------|----------|
| \`none\` | No page breaks (conference papers) |
| \`academic\` | Breaks before Abstract, References, Appendix |
| \`chapter\` | Break before every \`##\` heading (thesis) |

## Output

PDF is generated in the same directory as the input file with the same name.
SKILLMD

echo ""
echo "✅ Installation complete!"
echo ""
echo "Skill installed to: $INSTALL_DIR"
echo "Claude CLI will automatically load this skill from ~/.claude/skills/"
echo ""
echo "Usage (ask Claude directly):"
echo "  'Convert paper.md to PDF using IEEE template'"
echo "  'Convert thesis.md to PDF with chapter page breaks'"
echo ""
echo "Or run directly:"
echo "  node $INSTALL_DIR/tools/convert.js <file> [--template ieee] [--pagebreak academic]"

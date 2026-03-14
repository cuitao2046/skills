# Claude Markdown to PDF Skill

> Let Claude format and generate academic PDFs in one sentence.

Just say:

```
Polish and convert paper.md into IEEE PDF
```

Claude will:
1. Parse Markdown
2. AI-optimize structure
3. Auto-generate abstract/TOC
4. Auto-number figures
5. Auto-format layout
6. Output academic PDF

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Node.js Version](https://img.shields.io/badge/node-%3E%3D14-brightgreen)](https://nodejs.org)

---

## � Quick Install

### Option 1: Claude CLI (Recommended)

```bash
# Install from GitHub
claude skill install github:cuitao2046/skills/claude-md-academic-pdf

# Verify installation
claude skill list
```

After installation, the skill will be available as `md_to_pdf_ai` in Claude CLI.

### Option 2: Install Script

**Linux / macOS:**
```bash
git clone https://github.com/cuitao2046/skills.git
cd skills/claude-md-academic-pdf
bash install.sh
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/cuitao2046/skills.git
cd skills/claude-md-academic-pdf
.\install.ps1
```

**Windows (Command Prompt):**
```cmd
git clone https://github.com/cuitao2046/skills.git
cd skills\claude-md-academic-pdf
install.bat
```

### Option 3: Manual Setup

```bash
npm install
npx puppeteer browsers install chrome
```

---

## � Quick Demos

### In Claude CLI Conversation

```
Convert examples/research-paper-en.md to PDF using IEEE template
```

```
Convert examples/thesis.md to PDF with chapter page breaks
```

```
Polish and convert paper.md into ACM PDF with academic formatting
```

### Command Line

```bash
# Basic conversion
node tools/convert.js paper.md

# IEEE conference paper
node tools/convert.js paper.md --template ieee

# Academic paper with section breaks
node tools/convert.js paper.md --template default --pagebreak academic

# Thesis with chapter breaks
node tools/convert.js thesis.md --template immc --pagebreak chapter
```

---

## ✨ Features

- 📄 Convert Markdown to professional academic PDFs
- 🎨 Multiple templates: IEEE, ACM, IMMC, Default
- 📑 Auto-generate table of contents
- 🖼️ Support local and remote images (auto base64 encoding)
- 🔢 Mathematical formulas (KaTeX)
- 📖 Flexible page break modes (none/academic/chapter)
- 🌐 Chinese and English support
- 🤖 AI-powered polishing and review

---

## 📚 Documentation

- **[Usage Guide](./USAGE.md)** - Parameters, templates, advanced usage
- **[Deployment Guide](./DEPLOYMENT.md)** - Full deployment instructions
- **[Examples](./examples/README.md)** - Sample papers and test files

---

## 🎯 Templates

| Template | Use Case |
|----------|----------|
| `default` | General academic papers |
| `ieee` | IEEE conferences/journals |
| `acm` | ACM conferences |
| `immc` | Mathematical modeling contests |

---

## � Page Break Modes

| Mode | Use Case |
|------|----------|
| `none` | Conference papers (continuous) |
| `academic` | Journal papers (breaks before Abstract/References/Appendix) |
| `chapter` | Thesis/dissertations (breaks before every ## heading) |

---

## 🤝 Contributing

Contributions welcome! Submit a Pull Request.

---

## 📄 License

MIT License

---

## 🔗 Links

- [GitHub Repository](https://github.com/cuitao2046/skills)
- [Issue Tracker](https://github.com/cuitao2046/skills/issues)
- [Claude CLI Documentation](https://docs.anthropic.com/claude/docs)

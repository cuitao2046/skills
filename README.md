# Claude Skills Collection

A curated collection of useful Claude skills for enhancing productivity and automating workflows.

## Skills

### 📄 claude-md-academic-pdf

Convert Markdown files to academic-grade PDFs with AI-powered formatting.

**Features:**
- Parse Markdown with full syntax support
- AI-optimize document structure
- Auto-generate abstract and table of contents
- Auto-number figures and tables
- Professional academic formatting (IEEE, ACM, etc.)
- Support for mathematical formulas (KaTeX)
- Support for local and remote images
- Multiple CSS templates
- Flexible page break modes (none, academic, chapter)

**Usage with Claude Code:**
```bash
# Basic conversion
claude skill run md_to_pdf_ai '{"input_file": "examples/paper.md"}'

# Academic paper with IEEE template
claude skill run md_to_pdf_ai '{
  "input_file": "examples/research-paper-en.md",
  "template": "ieee",
  "pagebreak": "academic"
}'

# Chinese thesis with chapter breaks
claude skill run md_to_pdf_ai '{
  "input_file": "examples/thesis.md",
  "template": "immc",
  "pagebreak": "chapter"
}'
```

**Direct Script Usage:**
```bash
cd claude-md-academic-pdf
npm install
npx puppeteer browsers install chrome
node scripts/md2pdf.js examples/paper.md --template ieee --pagebreak academic
```

**📖 Documentation:**
- [README](./claude-md-academic-pdf/README.md) - Quick start and overview
- [Usage Guide](./claude-md-academic-pdf/USAGE.md) - Parameters and advanced usage
- [Deployment Guide](./claude-md-academic-pdf/DEPLOYMENT.md) - Installation instructions
- [Examples](./claude-md-academic-pdf/examples/README.md) - Sample papers

---

## Installation

Each skill is self-contained in its own directory. Navigate to the skill folder and follow its specific installation instructions.

## Contributing

Feel free to submit issues or pull requests to improve these skills.

## License

MIT

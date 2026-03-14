# Usage Guide

## Basic Usage

### In Claude CLI Conversation

```
Convert examples/paper.md to PDF
Convert paper.md to PDF using IEEE template with academic page breaks
Polish and convert thesis.md into IMMC PDF with chapter breaks
```

### Command Line

```bash
# Basic conversion
node tools/convert.js paper.md

# With template
node tools/convert.js paper.md --template ieee

# With page breaks
node tools/convert.js paper.md --pagebreak academic

# Disable TOC
node tools/convert.js paper.md --no-toc

# All options
node tools/convert.js paper.md --template ieee --pagebreak academic
```

### Skill JSON Mode

```bash
node tools/convert.js '{"input_file":"paper.md","template":"ieee","pagebreak":"academic","toc":true}'
```

---

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `input_file` | string | ✅ | - | Path to Markdown file |
| `template` | string | ❌ | `default` | `default`, `ieee`, `acm`, `immc` |
| `toc` | boolean | ❌ | `true` | Generate table of contents |
| `pagebreak` | string | ❌ | `none` | `none`, `academic`, `chapter` |

### `toc`
Inserts a table of contents at the `[[toc]]` marker, or after the title/abstract if no marker is present.

### `pagebreak`
- `none` — no automatic page breaks (conference papers)
- `academic` — page breaks before Abstract, References, Appendix
- `chapter` — page break before every `##` heading (thesis/dissertations)

---

## Templates

| Template | Use Case |
|----------|----------|
| `default` | General academic papers |
| `ieee` | IEEE conferences/journals |
| `acm` | ACM conferences |
| `immc` | Mathematical modeling contests (IMMC) |

---

## Output Location

PDF is generated in the same directory as the input file, with the same name.

| Input | Output |
|-------|--------|
| `paper.md` | `paper.pdf` |
| `examples/thesis.md` | `examples/thesis.pdf` |

---

## Image Support

### Local Images

```markdown
![Figure 1](./images/diagram.png)
![Figure 2](pic.png)
```

Local images are automatically base64-encoded and embedded in the PDF.

### Remote Images

```markdown
![Remote](https://example.com/image.png)
```

Must use HTTPS and be publicly accessible.

---

## Formula Support (KaTeX)

Inline: `$E = mc^2$`

Block:
```
$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$
```

---

## Advanced Usage

### Batch Conversion

```bash
# Linux/macOS
for file in examples/*.md; do
  node tools/convert.js "$file" --template ieee
done

# Windows PowerShell
Get-ChildItem examples/*.md | ForEach-Object {
  node tools/convert.js $_.FullName --template ieee
}
```

---

## Troubleshooting

**Chrome not found**
```bash
npx puppeteer browsers install chrome
```

**Dependencies missing**
```bash
npm install
```

**Images not displaying**
- Local: use relative paths from the Markdown file location
- Remote: ensure HTTPS and public access

**TOC not generated** — add `[[toc]]` marker in your Markdown, or ensure headings exist.

**Page breaks not working** — for chapter mode, use `##` headings (not `#` or `###`).

---

## Next Steps

- [Deployment Guide](./DEPLOYMENT.md) — Claude CLI integration
- [Examples](./examples/README.md) — sample papers
- [skill.yaml](./skill.yaml) — skill metadata

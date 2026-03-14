# Test Cases

## Basic Conversion

```bash
node tools/convert.js examples/conference-paper.md
```

Expected: `examples/conference-paper.pdf` generated.

## IEEE Template

```bash
node tools/convert.js examples/research-paper-en.md --template ieee --pagebreak academic
```

Expected: `examples/research-paper-en.pdf` with IEEE styling and section page breaks.

## Thesis with Chapter Breaks

```bash
node tools/convert.js examples/thesis.md --template immc --pagebreak chapter
```

Expected: `examples/thesis.pdf` with page break before each `##` heading.

## Chinese Paper

```bash
node tools/convert.js examples/research-paper-cn.md --template default
```

Expected: `examples/research-paper-cn.pdf` with correct CJK rendering.

## Skill JSON Mode

```bash
node tools/convert.js '{"input_file":"examples/academic-paper.md","template":"acm","toc":true}'
```

Expected: `examples/academic-paper.pdf` generated.

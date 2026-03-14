# Example Files

## Files

| File | Purpose | Recommended Mode |
|------|---------|-----------------|
| `conference-paper.md` | IEEE/ACM conference paper | `--pagebreak none` |
| `academic-paper.md` | Journal / research report | `--pagebreak academic` |
| `thesis.md` | Thesis / dissertation | `--pagebreak chapter` |
| `research-paper-en.md` | English paper with images & formulas | `--pagebreak academic` |
| `research-paper-cn.md` | Chinese paper with images & formulas | `--pagebreak chapter` |

---

## Quick Commands

```bash
node tools/convert.js examples/conference-paper.md

node tools/convert.js examples/academic-paper.md --pagebreak academic

node tools/convert.js examples/thesis.md --pagebreak chapter --template immc

node tools/convert.js examples/research-paper-en.md --template ieee --pagebreak academic

node tools/convert.js examples/research-paper-cn.md --pagebreak chapter
```

---

## Page Break Modes

| Mode | Page Breaks |
|------|-------------|
| `none` (default) | None |
| `academic` | Before: Abstract, References, Appendix |
| `chapter` | Before every `##` heading |

## Templates

| Template | Use Case |
|----------|----------|
| `default` | General academic |
| `ieee` | IEEE conferences/journals |
| `acm` | ACM conferences |
| `immc` | Mathematical modeling (IMMC) |

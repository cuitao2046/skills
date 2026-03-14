# Claude Skills 合集

精选的 Claude 技能合集，用于提升生产力和自动化工作流程。

## 技能列表

### 📄 claude-md-academic-pdf

将 Markdown 文件转换为论文级 PDF，支持 AI 智能排版。

**功能特性：**
- 解析 Markdown 完整语法支持
- AI 优化文档结构
- 自动生成摘要和目录
- 自动编号图表
- 专业学术排版（IEEE、ACM 等）
- 支持数学公式（KaTeX）
- 支持本地和网络图片
- 多种 CSS 模板
- 灵活的分页模式（无分页、学术模式、章节模式）

**使用 Claude Code：**
```bash
# 基础转换
claude skill run md_to_pdf_ai '{"input_file": "examples/paper.md"}'

# 学术论文使用 IEEE 模板
claude skill run md_to_pdf_ai '{
  "input_file": "examples/research-paper-en.md",
  "template": "ieee",
  "pagebreak": "academic"
}'

# 中文学位论文按章节分页
claude skill run md_to_pdf_ai '{
  "input_file": "examples/thesis.md",
  "template": "immc",
  "pagebreak": "chapter"
}'
```

**直接使用脚本：**
```bash
cd claude-md-academic-pdf
npm install
npx puppeteer browsers install chrome
node scripts/md2pdf.js examples/paper.md --template ieee --pagebreak academic
```

**📖 文档：**
- [README](./claude-md-academic-pdf/README.md) - 快速开始和概览
- [使用指南](./claude-md-academic-pdf/USAGE.md) - 参数和高级用法
- [部署指南](./claude-md-academic-pdf/DEPLOYMENT.md) - 安装说明
- [示例文件](./claude-md-academic-pdf/examples/README.md) - 示例论文

---

## 安装说明

每个技能都是独立的目录。进入技能文件夹并按照其特定的安装说明操作。

## 贡献

欢迎提交 issue 或 pull request 来改进这些技能。

## 许可证

MIT

**Claude Skill** 通常指为 **Anthropic 的 **Claude / **Claude Code / **Claude CLI 扩展能力的一种模块化能力包。
目前官方并没有像插件那样“严格统一规范”，但社区和官方示例已经形成了一套 **事实上的 Skill 开发规范**。

下面是一个 **完整、实战可用的 Claude Skill 开发规范（适用于 Claude CLI / Claude Code）**。

---

# 一、Claude Skill 的核心设计原则

## 1 模块化（Modular）

一个 Skill 只解决 **一个明确问题**。

例如：

| Skill              | 功能           |
| ------------------ | ------------ |
| crawl-website      | 抓取网站         |
| markdown-to-pdf    | 论文排版         |
| research-assistant | 学术调研         |
| repo-analyzer      | 分析 GitHub 项目 |

避免：

❌ 一个 Skill 做 **爬虫 + PDF + 翻译 + 总结**

---

## 2 Prompt-first 架构

Claude Skill 本质是：

**Prompt + 工具 + 结构化上下文**

典型执行流程：

```
用户命令
   ↓
Skill Prompt
   ↓
工具执行 (shell/python/api)
   ↓
结果整理
   ↓
Claude总结
```

---

## 3 自描述能力（Self-describing）

每个 Skill 必须清楚说明：

* 做什么
* 输入是什么
* 输出是什么
* 示例

---

# 二、Claude Skill 标准目录结构

推荐结构：

```
my-skill/
│
├── skill.yaml
├── README.md
├── prompt.md
│
├── tools/
│   ├── crawl.py
│   ├── parser.py
│
├── templates/
│   ├── template.md
│
├── examples/
│   ├── example1.md
│
└── tests/
    └── test.md
```

说明：

| 文件         | 作用         |
| ---------- | ---------- |
| skill.yaml | Skill 元信息  |
| prompt.md  | Claude 主提示 |
| README.md  | 文档         |
| tools      | 工具脚本       |
| templates  | 输出模板       |
| examples   | 示例         |
| tests      | 测试         |

---

# 三、skill.yaml 规范

核心配置文件。

示例：

```yaml
name: crawl-docs
version: 1.0
description: Crawl documentation and convert to structured markdown

entry: prompt.md

inputs:
  - name: url
    type: string
    description: Documentation root URL

outputs:
  - type: markdown
    description: Structured knowledge base

tools:
  - name: crawl
    command: python tools/crawl.py

permissions:
  - shell
  - file_read
  - file_write
```

推荐字段：

| 字段          | 说明       |
| ----------- | -------- |
| name        | Skill名称  |
| version     | 版本       |
| description | 描述       |
| entry       | Prompt入口 |
| inputs      | 输入参数     |
| outputs     | 输出       |
| tools       | 可用工具     |
| permissions | 权限       |

---

# 四、prompt.md 规范

Skill 的 **核心逻辑**。

示例：

```
You are a documentation crawler.

Your goal:
1. Crawl the documentation site
2. Extract only the main content
3. Convert into structured markdown

Rules:

- ignore navigation
- ignore footer
- ignore ads

Output format:

# Title

## Section

content
```

推荐结构：

```
# ROLE

# GOAL

# INPUT

# PROCESS

# OUTPUT FORMAT

# EXAMPLES
```

---

# 五、Tool 设计规范

工具必须：

* 单一职责
* 可独立运行
* 输入输出清晰

例如：

```
tools/crawl.py
```

```
input:
    url

output:
    raw html list
```

示例：

```python
import requests

def crawl(url):
    r = requests.get(url)
    return r.text
```

---

# 六、输入输出设计规范

## 输入

推荐：

```
string
url
file
json
```

示例：

```
url=https://docs.example.com
depth=1
```

---

## 输出

推荐统一：

```
markdown
json
csv
```

避免：

❌ 自定义奇怪格式

---

# 七、Prompt 工程最佳实践

## 1 明确规则

坏：

```
抓取网页
```

好：

```
Extract only content inside div.article-content
```

---

## 2 明确格式

坏：

```
输出markdown
```

好：

```
Output format:

# Title

## Section
content
```

---

## 3 示例驱动

```
Input:
https://example.com/docs

Output:

# API Overview
...
```

---

# 八、Skill 自动安装规范（推荐）

如果希望：

**Claude CLI 自动安装 GitHub Skill**

建议结构：

```
claude-skills/
   crawl-docs/
   paper-writer/
   repo-analyzer/
```

GitHub Repo：

```
github.com/yourname/claude-skills
```

安装：

```
claude skill install github:yourname/claude-skills/crawl-docs
```

---

# 九、版本规范

推荐：

```
MAJOR.MINOR.PATCH
```

例：

```
1.0.0
1.1.0
1.1.1
```

规则：

| 版本  | 含义   |
| --- | ---- |
| 1.x | 稳定版本 |
| 2.x | 架构升级 |

---

# 十、Skill 质量标准

一个高质量 Skill 必须：

### 1 文档完整

包含：

```
README
Examples
Input说明
Output说明
```

---

### 2 可复现

任何人：

```
git clone
claude run
```

就能运行。

---

### 3 deterministic

输出稳定。

避免：

```
随机总结
```

---

# 十一、Skill 分类体系

推荐分类：

```
skills/
│
├── crawling
├── research
├── coding
├── writing
├── data
└── automation
```

示例：

```
skills/
    crawl-docs
    github-analyzer
    academic-paper-writer
```

---

# 十二、企业级 Skill 设计规范

如果是 **企业级 Skill 平台**：

推荐增加：

```
auth/
config/
logging/
cache/
```

例如：

```
skill/
 ├─ skill.yaml
 ├─ prompt.md
 ├─ tools
 ├─ config
 ├─ cache
 └─ logs
```

---

# 十三、Claude Skill 与 GPT Plugin 的区别

|     | Claude Skill   | GPT Plugin |
| --- | -------------- | ---------- |
| 部署  | 本地             | Web        |
| 工具  | shell/python   | API        |
| 结构  | Prompt + Tools | OpenAPI    |
| 灵活度 | 高              | 中          |

---

# 十四、典型 Skill 示例

### 1 文档抓取 Skill

```
crawl-docs
```

功能：

* 递归抓取
* 提取正文
* 转知识库

---

### 2 GitHub 分析 Skill

```
repo-analyzer
```

功能：

* 分析代码结构
* 自动生成文档
* 提供架构图

---

### 3 学术论文 Skill

```
paper-writer
```

功能：

* Markdown → IEEE PDF
* 自动引用
* 自动排版

---

# 十五、Skill 开源仓库建议

推荐：

```
awesome-claude-skills
```

结构：

```
skills/
docs/
examples/
registry.json
```

---

✅ **总结一句话：**

Claude Skill 本质是：

```
Skill = Prompt + Tools + Structured Context
```

设计核心是：

```
模块化
可复用
可自动执行
```

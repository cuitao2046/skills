# 部署指南 / Deployment Guide

## 前置要求 / Prerequisites

- Claude Code CLI (`claude --version` 验证)
- Node.js >= 14 (`node --version` 验证)

---

## 方法 1：Claude CLI 安装（推荐）

```bash
claude skill install github:cuitao2046/skills/claude-md-academic-pdf
claude skill list
```

安装后 skill 名称为 `md-to-pdf`，依赖自动安装，首次使用时自动下载 Chrome。

---

## 方法 2：手动克隆部署

### 步骤 1：克隆并安装依赖

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

**Windows (CMD):**
```cmd
git clone https://github.com/cuitao2046/skills.git
cd skills\claude-md-academic-pdf
install.bat
```

或手动安装：
```bash
npm install
npx puppeteer browsers install chrome
```

### 步骤 2：验证安装

```bash
node tools/convert.js examples/conference-paper.md
```

看到 `✅ PDF generated` 即成功。

### 步骤 3：部署到 Claude CLI

**项目级（推荐）** — 在项目目录下启动 Claude CLI，自动识别当前目录的 skill：

```bash
cd /path/to/claude-md-academic-pdf
claude
```

**全局部署** — 可在任意目录使用：

```bash
# Linux/macOS
mkdir -p ~/.claude/skills
ln -s "$(pwd)" ~/.claude/skills/claude-md-academic-pdf

# Windows
mklink /D "%USERPROFILE%\.claude\skills\claude-md-academic-pdf" "%CD%"
```

### 步骤 4：验证部署

在 Claude CLI 中输入 `/skills`，应看到 `md-to-pdf`。

---

## 使用

在 Claude CLI 对话中直接说：

```
Convert examples/research-paper-en.md to PDF using IEEE template with academic page breaks
```

或直接调用：

```bash
claude skill run md-to-pdf '{"input_file":"examples/paper.md","template":"ieee"}'
```

---

## 更新

```bash
cd /path/to/skills/claude-md-academic-pdf
git pull
npm install
```

符号链接部署无需额外操作，立即生效。

---

## 卸载

```bash
# Linux/macOS
rm -rf ~/.claude/skills/claude-md-academic-pdf

# Windows
rmdir /S /Q "%USERPROFILE%\.claude\skills\claude-md-academic-pdf"
```

---

## 故障排除

**Skill 未找到** — 检查部署路径，确认 `/skills` 列表中有 `md-to-pdf`。

**Chrome 未找到**
```bash
npx puppeteer browsers install chrome
```

**依赖缺失**
```bash
npm install
```

**路径错误** — `input_file` 使用相对于项目根目录的路径：
```bash
✅ {"input_file": "examples/paper.md"}
❌ {"input_file": "/absolute/path/paper.md"}
```

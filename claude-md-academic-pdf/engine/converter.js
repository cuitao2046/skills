const fs = require("fs");
const path = require("path");
const { mdToPdf } = require("md-to-pdf");
const puppeteer = require("puppeteer-core");
const { processMarkdown } = require("./markdown_processor");

/**
 * Convert Markdown file to PDF
 * @param {string} mdFile - Path to Markdown file
 * @param {Object} options - Options { toc: boolean, template: string, pagebreak: string }
 */
async function convert(mdFile, options = {}) {
  if (!fs.existsSync(mdFile)) {
    throw new Error(`Markdown file not found: ${mdFile}`);
  }

  const toc = options.toc ?? false;
  const template = options.template ?? "default";
  const pagebreak = options.pagebreak ?? "none";

  // 处理 Markdown，插入 TOC（如果需要）
  const htmlContent = processMarkdown(mdFile, toc, pagebreak);

  // 临时 Markdown 文件（实际是 HTML）
  const tmpFile = path.join(path.dirname(mdFile), "__tmp.html");
  fs.writeFileSync(tmpFile, htmlContent);

  // Detect Chrome executable path
  const getChromePath = () => {
    const os = require('os');
    
    // Try Puppeteer's installed Chrome in cache directory
    const puppeteerCachePaths = [
      path.join(os.homedir(), '.cache', 'puppeteer', 'chrome'),
      path.join(process.env.USERPROFILE || os.homedir(), '.cache', 'puppeteer', 'chrome'),
      path.join(process.env.LOCALAPPDATA || '', 'puppeteer', 'chrome')
    ];

    for (const cacheDir of puppeteerCachePaths) {
      if (fs.existsSync(cacheDir)) {
        const versions = fs.readdirSync(cacheDir);
        if (versions.length > 0) {
          // Use the first (latest) version
          const chromePath = path.join(cacheDir, versions[0], 'chrome-win64', 'chrome.exe');
          if (fs.existsSync(chromePath)) {
            return chromePath;
          }
          // Try macOS/Linux path
          const chromePathUnix = path.join(cacheDir, versions[0], 'chrome', 'chrome');
          if (fs.existsSync(chromePathUnix)) {
            return chromePathUnix;
          }
        }
      }
    }

    // Fallback to system Chrome
    const systemPaths = [
      'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe',
      'C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe',
      path.join(process.env.LOCALAPPDATA || '', 'Google', 'Chrome', 'Application', 'chrome.exe'),
      '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
      '/usr/bin/google-chrome',
      '/usr/bin/chromium-browser'
    ];
    
    for (const p of systemPaths) {
      if (fs.existsSync(p)) return p;
    }
    
    throw new Error('Chrome not found. Please install Chrome or run: npx puppeteer browsers install chrome');
  };

  const chromePath = getChromePath();
  // console.log(`Using Chrome: ${chromePath}`);
  const puppeteerConfig = { executablePath: chromePath };

  try {
    await mdToPdf(
      { content: htmlContent },
      {
        dest: mdFile.replace(/\.md$/, ".pdf"),
        basedir: path.dirname(mdFile),
        stylesheet: path.join(__dirname, `../templates/css/${template}.css`),
        pdf_options: {
          format: "A4",
          margin: {
            top: "1.5cm",
            bottom: "1.5cm",
            left: "1.5cm",
            right: "1.5cm"
          },
          printBackground: true
        },
        launch_options: puppeteerConfig
      }
    );

    console.log(`✅ PDF generated: ${mdFile.replace(/\.md$/, ".pdf")}`);
  } finally {
    if (fs.existsSync(tmpFile)) {
      fs.unlinkSync(tmpFile);
    }
  }
}

module.exports = { convert };

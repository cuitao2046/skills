const fs = require("fs-extra");
const path = require("path");
const MarkdownIt = require("markdown-it");
const markdownItAnchor = require("markdown-it-anchor");
const markdownItTOC = require("markdown-it-table-of-contents");
const markdownItFootnote = require("markdown-it-footnote");
const { katex } = require("@mdit/plugin-katex");

function processMarkdown(file, enableTOC, pagebreak = 'none') {
  let content = fs.readFileSync(file, "utf-8");

  const baseDir = path.dirname(file);
  
  // Convert local images to base64, keep remote images as-is
  content = content.replace(/!\[(.*?)\]\((.*?)\)/g, (m, alt, src) => {
    // Keep HTTP/HTTPS URLs as-is
    if (src.startsWith("http://") || src.startsWith("https://")) {
      return m;
    }
    
    // Convert local images to base64
    try {
      const imagePath = path.resolve(baseDir, src);
      if (fs.existsSync(imagePath)) {
        const imageBuffer = fs.readFileSync(imagePath);
        const ext = path.extname(imagePath).toLowerCase();
        const mimeTypes = {
          '.png': 'image/png',
          '.jpg': 'image/jpeg',
          '.jpeg': 'image/jpeg',
          '.gif': 'image/gif',
          '.svg': 'image/svg+xml',
          '.webp': 'image/webp'
        };
        const mimeType = mimeTypes[ext] || 'image/png';
        const base64 = imageBuffer.toString('base64');
        return `![${alt}](data:${mimeType};base64,${base64})`;
      }
    } catch (err) {
      console.warn(`Warning: Could not load image ${src}:`, err.message);
    }
    
    // If image not found, return original
    return m;
  });

  // Add [[toc]] marker if TOC is enabled and not present
  if (enableTOC && !content.includes('[[toc]]') && !content.includes('[toc]')) {
    const firstHeadingMatch = content.match(/^#\s+.+$/m);
    if (firstHeadingMatch) {
      const insertPos = firstHeadingMatch.index + firstHeadingMatch[0].length;
      content = content.slice(0, insertPos) + '\n\n[[toc]]\n\n' + content.slice(insertPos);
    } else {
      content = '[[toc]]\n\n' + content;
    }
  }

  // Apply page break logic based on mode (after TOC insertion)
  if (pagebreak === 'academic') {
    // Insert page breaks before specific chapter keywords (only ## level)
    const keywords = [
      /^(##\s+)(Abstract|摘要)$/im,
      /^(##\s+)(Table of Contents|目录)$/im,
      /^(##\s+)(References|参考文献)$/im,
      /^(##\s+)(Appendix|附录)$/im
    ];
    
    keywords.forEach(regex => {
      content = content.replace(regex, (match, prefix, keyword) => {
        return `<div class="page-break"></div>\n\n${prefix}${keyword}`;
      });
    });
  } else if (pagebreak === 'chapter') {
    // Insert page breaks before all level-2 headings (chapters)
    content = content.replace(/^(##\s+.+)$/gm, (match) => {
      return `<div class="page-break"></div>\n\n${match}`;
    });
    // Remove page break before the first chapter
    content = content.replace(/^<div class="page-break"><\/div>\n\n(##\s+)/, '$1');
  }

  const md = new MarkdownIt({ html: true, linkify: true, typographer: true })
    .use(markdownItAnchor, {
      permalink: false,
      slugify: (s) => s.toLowerCase().replace(/[^\w\u4e00-\u9fa5]+/g, '-')
    })
    .use(markdownItTOC, {
      includeLevel: [2, 3],
      slugify: (s) => s.toLowerCase().replace(/[^\w\u4e00-\u9fa5]+/g, '-'),
      containerHeaderHtml: '<div class="toc-container-header">目录</div>'
    })
    .use(markdownItFootnote)
    .use(katex, {
      throwOnError: false,
      errorColor: '#cc0000'
    });

  const html = md.render(content);
  
  // Add KaTeX CSS
  const katexCSS = `
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.9/dist/katex.min.css">
<style>
.katex-display {
  text-align: center;
  margin: 1em 0;
}
.toc-container-header {
  font-size: 1.2em;
  font-weight: bold;
  margin-bottom: 0.5em;
}
</style>
`;
  
  return katexCSS + html;
}

module.exports = { processMarkdown };

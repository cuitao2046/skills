#!/usr/bin/env node
/**
 * convert.js - CLI entry point for Markdown to PDF conversion
 * Usage: node tools/convert.js <file> [--template <name>] [--pagebreak <mode>] [--no-toc]
 *   or:  node tools/convert.js '{"input_file":"...","template":"..."}' (skill JSON mode)
 */

const path = require("path");
const fs = require("fs");
const { convert } = require("../engine/converter");

async function run(inputFile, options) {
  const resolvedPath = path.resolve(process.cwd(), inputFile);
  console.log(`Converting: ${resolvedPath}`);
  console.log(`Options: ${JSON.stringify(options, null, 2)}`);
  await convert(resolvedPath, options);
  console.log("✅ Conversion completed successfully");
}

async function main() {
  const args = process.argv.slice(2);

  // Skill JSON invocation mode
  if (args.length === 1 && args[0].trim().startsWith("{")) {
    const input = JSON.parse(args[0]);
    if (!input.input_file) {
      console.error("❌ Missing required field: input_file");
      process.exit(1);
    }
    return run(input.input_file, {
      template: input.template ?? "default",
      pagebreak: input.pagebreak ?? "none",
      toc: input.toc !== false
    });
  }

  // CLI mode
  const inputFile = args[0];
  if (!inputFile || inputFile === "help") {
    console.log(`
Usage:
  node tools/convert.js <file> [options]

Options:
  --template <name>     CSS template: default, ieee, acm, immc  (default: default)
  --pagebreak <mode>    Page break mode: none, academic, chapter (default: none)
  --no-toc              Disable table of contents

Examples:
  node tools/convert.js paper.md
  node tools/convert.js paper.md --template ieee --pagebreak academic
    `);
    process.exit(inputFile ? 0 : 1);
  }

  const options = { template: "default", pagebreak: "none", toc: true };
  for (let i = 1; i < args.length; i++) {
    if (args[i] === "--template" && args[i + 1]) { options.template = args[++i]; }
    else if (args[i] === "--pagebreak" && args[i + 1]) { options.pagebreak = args[++i]; }
    else if (args[i] === "--no-toc") { options.toc = false; }
  }

  try {
    await run(inputFile, options);
  } catch (err) {
    console.error("❌ Conversion failed:", err.message);
    process.exit(1);
  }
}

main();

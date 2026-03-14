function generateTOC(markdown){

  const lines = markdown.split("\n");

  const toc = [];

  lines.forEach(line => {

    if(line.startsWith("## ")){
      const title = line.replace("## ","");
      const link = title.toLowerCase().replace(/ /g,"-");
      toc.push(`- [${title}](#${link})`);
    }

  });

  return `## Table of Contents\n\n${toc.join("\n")}\n\n`;
}

module.exports = { generateTOC };
function formatMarkdown(content){

  const sections = content.split("\n# ");

  if(!content.includes("## Abstract")){

    content = `## Abstract

This paper presents a study based on the provided markdown content.

` + content;

  }

  return content;
}

module.exports = { formatMarkdown };
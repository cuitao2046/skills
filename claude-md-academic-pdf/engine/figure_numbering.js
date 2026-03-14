function numberFigures(md){

  let index = 1;

  return md.replace(/!\[(.*?)\]\((.*?)\)/g,(m,alt,src)=>{

    const caption = `Figure ${index++}: ${alt}`;

    return `
![${alt}](${src})

*${caption}*
`;

  });

}

module.exports = { numberFigures };
import * as yaml from "https://deno.land/std@0.130.0/encoding/yaml.ts";
import * as path from "https://deno.land/std@0.130.0/path/mod.ts";

const request = await fetch("https://cloudfoundation.meshcloud.io/blocks.json");
const blocks: Block[] = await request.json();

interface Block {
  id: string;
  pillar: string;
  journeyStage: string;
  scope: string;
  title: string;
  link: string;
  summary: string;
}
const tasks = blocks.map(async (block) => {
  // todo: not sure if we need that frontmatter for anything really
  const frontmatter = {
    name: block.title,
    summary: block.summary,
  };

  const content = `---
${yaml.stringify(frontmatter)}
---

# ${block.title}

${block.summary}

Learn more about the [${block.title} Building Block](${
    block.link
  }) on the Cloud Foundation website.
`;
  const linkPrefix = "https://cloudfoundation.meshcloud.io/maturity-model/";
  const relativeLink = block.link.substring(linkPrefix.length);
  const relativeLinkComponents = path.parse(relativeLink);
  const destination = path.join(
    relativeLinkComponents.dir,
    relativeLinkComponents.name + ".md"
  );

  await Deno.mkdir(path.dirname(destination), { recursive: true });
  await Deno.writeTextFile(destination, content);
  console.log("wrote ", destination);
});

await Promise.all(tasks);

import * as fs from "fs";
import * as path from "path";

import { defineUserConfig } from "@vuepress/cli";
import {
  defaultTheme,
  NavbarConfig,
  SidebarConfig,
} from "@vuepress/theme-default";
import { shikiPlugin } from "@vuepress/plugin-shiki";

// The following files will be skipped for scanning kit modules in the tree.
// This hurts a bit in local development, should not happen in CI/CD though.
const treeSkip = [
  '.vuepress',
  'node_modules',
  'util' // For some kit modules we use "util" terraform. This should be ignored
];

export const navbarEn: NavbarConfig = [
  {
    text: "Getting Started",
    link: "/tutorial/",
  },
  {
    text: "Hub",
    link: "/hub/"
  },
  {
    text: "Guides",
    link: "/guide/",
  },
  {
    text: "Concepts",
    link: "/concept/",
  },
  {
    text: "Reference",
    link: "/reference/repository",
  },
];

export const sidebar: SidebarConfig = {
  "/hub/": [
    {
      text: "Collie Hub",
      children: [
          "/hub/",
          ...getAndBuildKitModuleTree(path.join(__dirname, "..", "..", "kit"))
      ]
    }
  ],
  "/reference/": [
    {
      text: "Reference",
      children: [
        '/reference/repository.md',
        '/reference/foundation.md',
        '/reference/kit-module.md',
        '/reference/platform-module.md',
      ]
    },
  ],
  "/guide/": [
    {
      text: "Guides",
      children: [
        '/guide/README.md',
        '/guide/bootstrapping.md',
        '/guide/compliance.md',
        '/guide/best-practices.md'
      ]
    },
  ],
  "/tutorial/": [
    {
      text: "Getting Started",
      children: [
        '/tutorial/README.md',
        '/tutorial/create-kit-module.md',
        '/tutorial/compliance-control.md'
      ]
    },
  ],
  "/concept/": [
    {
      text: "Landing Zone Concepts",
      children: [
        '/concept/bootstrapping.md',
        '/concept/modular-landing-zones.md',
      ]
    },
  ],
};

export default defineUserConfig({
  // site-level locales config
  locales: {
    "/": {
      lang: "en-US",
      title: "Collie",
      description: "Build and Deploy modular landing zones with Collie",
    },
  },

  // configure default theme
  theme: defaultTheme({
    logo: "/images/hero.png",
    repo: "meshcloud/collie-hub",
    docsDir: "docs",
    darkMode: false,

    // theme-level locales config
    locales: {
      /**
       * English locale config
       *
       * As the default locale of @vuepress/theme-default is English,
       * we don't need to set all of the locale fields
       */
      "/": {
        navbar: navbarEn,
        sidebar: sidebar,
        editLinkText: "Edit this page on GitHub",
      },
    },
  }),
});

function getAndBuildKitModuleTree(dir: string, child: string = "") {
  const files = fs.readdirSync(path.join(dir, child), { withFileTypes: true })

  const isKitModule = !!files.find(f => f.name === "README.md")
      && child !== ""; // When no child is there, we are in the root kit folder, which contains a README too.

  if (isKitModule) {
    // If we found a kit module, we will copy its README over to the hub folder.
    const source = path.join(dir, child, "README.md");
    const destination = path.join(__dirname, "..", "hub", child);
    const content = replaceReadMe(fs.readFileSync(source, "utf-8"), child);
    fs.mkdirSync(destination, { recursive: true })
    fs.writeFileSync(path.join(destination, "README.md"), content);

    return [path.join("/", "hub", child)];
  } else {
    return files
      .filter((x) => {
        return x.isDirectory()
            && treeSkip.indexOf(x.name) === -1
            && !isKitModule // We do not allow nested kit modules
      })
      .map((x) => {
        const nextChild = path.join(child, x.name);
        return {
          text: x.name,
          collapsible: true,
          children: [
            ...getAndBuildKitModuleTree(dir, nextChild),
          ],
        };
      });
  }
}

/**
 * This will inject a template with source code & installation to a README.
 *
 * It contains a lot of happy path string parsing. In future we should probably replace it with something more reliable.
 */
function replaceReadMe(rawContent: string, module: string) {
  // First we need to split up the content into frontmatter & non-frontmatter, as the frontmatter might contain comments
  // which are the exact same syntax as Headers in markdown (# My YAML comment)
  const frontMatterSplit = rawContent.split('---');
  let frontMatter = "";
  let content = rawContent;
  if (frontMatterSplit.length > 1) {
    frontMatter = [...frontMatterSplit].splice(0, 2).join("---") + "---";
    content = [...frontMatterSplit].splice(2).join("---");
  }

  // We need to insert our custom content after the first Header occurrence
  // This beautiful regex finds the first "# Header" in the file.
  const headerSplit = content.split(/^(#\s.+)/gm)
  const preContent = frontMatter + [...headerSplit].splice(0, 2).join("")
  const afterContent = [...headerSplit].splice(2).join("");
  return `${preContent}

::: tip Source code & Installation
The source code of this kit module can be found [here](https://github.com/meshcloud/collie-hub/tree/main/kit/${module})

Run the following command to install the kit module:

\`\`\`shell
collie kit import ${module}
\`\`\`
:::
${afterContent}`;
}

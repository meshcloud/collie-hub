import * as fs from "fs";
import * as path from "path";

import {
  NavbarConfig,
  SidebarConfig,
} from "@vuepress/theme-default";
import pluginPlausible from "./theme/plugins/plausible";
import { DefaultThemeOptions, defineUserConfig, ViteBundlerOptions } from "vuepress-vite";

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
    text: "Modules",
    link: "/modules/"
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
  {
    text: "Accelerator",
    link: "/accelerator/"
  }
];

export const sidebar: SidebarConfig = {
  "/modules/": [
    {
      text: "Modules",
      children: [
          "/modules/",
          ...getAndBuildKitModuleTree(path.join(__dirname, "..", "..", "kit"))
      ]
    }
  ],
  "/reference/": [
    {
      text: "Reference",
      children: [
        '/reference/repository.md',
        '/reference/foundation-commands.md',
        '/reference/kit-commands.md',
        '/reference/compliance-commands.md',
        '/reference/tenant-commands.md',
      ]
    },
  ],
  "/guide/": [
    {
      text: "Guides",
      children: [
        '/guide/README.md',
        '/guide/best-practices.md',
        '/guide/compliance.md',
        '/guide/faq.md',
      ]
    },
  ],
  "/tutorial/": [
    {
      text: "Getting Started",
      children: [
        '/tutorial/README.md',
        '/tutorial/deploy-first-module.md',
        '/tutorial/create-kit-module.md',
        '/tutorial/compliance-control.md'
      ]
    },
  ],
  "/concept/": [
    {
      text: "Key Concepts",
      children: [
        '/concept/goals.md',
        '/concept/bootstrapping.md',
        '/concept/modular-landing-zones.md',
      ]
    },
  ],
  "/accelerator/": [
    {
      text: "Accelerator",
      children: [
          "/accelerator/README.md"
      ]
    }
  ]
};

export default defineUserConfig<DefaultThemeOptions, ViteBundlerOptions>({
  lang: "en-US",
  title: "Collie Hub",
  description: "Build and Deploy modular landing zones with Collie",

  plugins: [
    [
      pluginPlausible,
      {
        enableAutoPageviews: true,
        enableAutoOutboundTracking: false, // may have issue, see https://github.com/plausible/plausible-tracker/issues/12 We use custom tracking via CtaButton component instead, so this is less relevant for us.
        trackerOptions: {
          apiHost: "",
          domain:
              process.env.AMPLIFY_ENV === "prod" // This way Plausible will only track data for the production version.
                  ? "collie.cloudfoundation.org"
                  : "preview.collie.cloudfoundation.org",
        },
      },
    ],
  ],

  // configure default theme
  themeConfig: {
    logo: "/images/hero.png",
    repo: "meshcloud/collie-hub",
    docsDir: "docs",
    darkMode: false,
    navbar: navbarEn,
    sidebar: sidebar,
    editLinkText: "Edit this page on GitHub",
  },
});

function getAndBuildKitModuleTree(dir: string, child: string = "") {
  const files = fs.readdirSync(path.join(dir, child), { withFileTypes: true })

  const isKitModule = !!files.find(f => f.name === "README.md")
      && child !== ""; // When no child is there, we are in the root kit folder, which contains a README too.

  if (isKitModule) {
    // If we found a kit module, we will copy its README over to the modules folder.
    const source = path.join(dir, child, "README.md");
    const destination = path.join(__dirname, "..", "modules", child);
    const content = replaceReadMe(fs.readFileSync(source, "utf-8"), child);
    fs.mkdirSync(destination, { recursive: true })
    fs.writeFileSync(path.join(destination, "README.md"), content);

    return [path.join("/", "modules", child)];
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

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
const treeSkip = ['.vuepress', 'node_modules'];

export const navbarEn: NavbarConfig = [
  {
    text: "Hub",
    link: "/hub/"
  },
  {
    text: "Getting Started",
    link: "/tutorial/",
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
      title: "Collie Hub",
      description: "build and deploy modular landing zones",
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
    const content = replaceReadMe(fs.readFileSync(source, "utf-8"));
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

function replaceReadMe(content: string) {
  return content;
}

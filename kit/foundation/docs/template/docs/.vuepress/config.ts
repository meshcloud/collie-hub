import * as fs from "fs";
import * as path from "path";
import {
  DefaultThemeOptions,
  defineUserConfig,
  ViteBundlerOptions,
} from "vuepress-vite";
import type { SidebarConfig, NavbarConfig } from "@vuepress/theme-default";

const navbar: NavbarConfig = [
  { text: "Foundation", link: "/" },
  {
    text: "Platforms",
    link: "/platforms/",
  },
  {
    text: "Kit",
    link: "/kit/",
  },
  {
    text: "Compliance",
    link: "/compliance/",
  },
];

function getMarkdownFiles(dir: string) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });

  const mdFiles = entries
    .filter(
      (x) => x.isFile() && !x.name.startsWith(".") && x.name.endsWith(".md")
    )
    .map((x) => "/" + path.relative("docs/", path.join(dir, x.name)))
    .map((x) => x.replaceAll(path.sep, "/")); //on windows, this needs to be done to cleanly define URL paths

  return mdFiles;
}

function getTree(dir: string) {
  return fs
    .readdirSync(dir, { withFileTypes: true })
    .filter((x) => x.isDirectory())
    .map((x) => {
      const child = path.join(dir, x.name);
      return {
        text: x.name,
        collapsible: true,
        children: [...getMarkdownFiles(child), ...getTree(child)],
      };
    });
}

export const sidebar: SidebarConfig = {
  "/": [
    {
      text: "Foundation",
      children: getMarkdownFiles("docs"),
    },
  ],
  "/platforms/": [
    {
      text: "Platforms",
      children: [...getMarkdownFiles("docs/platforms")],
    },
    ...getTree("docs/platforms"),
  ],
  "/kit/": [
    {
      text: "Kit",
      children: [...getMarkdownFiles("docs/kit")],
    },
    ...getTree("docs/kit"),
  ],
  "/compliance/": [
    {
      text: "Compliance",
      children: [...getMarkdownFiles("docs/compliance")],
    },
    ...getTree("docs/compliance"),
  ],
};

export default defineUserConfig<DefaultThemeOptions, ViteBundlerOptions>({
  // site-level locales config
  locales: {
    "/": {
      lang: "en-US",
      title: "My Cloud Foundation",
      description: "Documentation for My cloud foundations",
    },
  },

  themeConfig: {
    locales: {
      "/": {
        navbar: navbar,
        sidebar: sidebar,
      },
    },
  },
  plugins: [
    [
      "@vuepress/plugin-git",
      {
        createdTime: false,
        updateTime: true,
        contributors: false,
      },
    ],
  ],
});

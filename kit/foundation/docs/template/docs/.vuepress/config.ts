import * as fs from "fs";
import * as path from "path";
import { defineUserConfig } from "vuepress";
import type { SidebarConfig, NavbarConfig } from "@vuepress/theme-default";
import { viteBundler } from '@vuepress/bundler-vite';
import { defaultTheme } from "@vuepress/theme-default";

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
    .map((x) => x.replaceAll(path.sep, "/")) //on windows, this needs to be done to cleanly define URL paths
    .sort();

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
        collapsible: false,
        children: [...getMarkdownFiles(child), ...getTree(child)],
      };
    })
    .sort(x => x.text);
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

export default defineUserConfig({
  // site-level locales config
  bundler: viteBundler(),
  locales: {
    "/": {
      lang: "en-US",
      title: "My Cloud Foundation",
      description: "Documentation for My cloud foundations",
    },
  },

  theme: defaultTheme({
    navbar: navbar,
    sidebar: sidebar,
    themePlugins: {
      git: true,
    },
  }),
});

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
    children: [
      {
        text: "Azure",
        link: "/platforms/azure/"
      },
      // TODO other platforms
    ],
  },
  {
    text: "Concepts",
    link: "/concepts"
  },
  {
    text: "Compliance",
    link: "/compliance/",
  },
];

export const sidebar: SidebarConfig = {
  "/": [
    {
      text: "Foundation",
      children: [
        '/README.md'
      ]
    },
  ],
  "/platforms/azure/": [
    {
      text: 'Azure',
      link: '/platforms/azure/',
      children: [
        '/platforms/azure/organization-hierarchy',
        {
          text: 'Landing Zones',
          children: [
          ]
        },
        {
          text: 'Building Blocks',
          children: [
          ]
        },
        {
          text: 'Platform Administration',
          children: [
          ]
        }
      ]
    }
  ],

  // TODO: AWS, but need to sort out state management first

  "/concepts": [
    '/concepts'
  ],

  "/compliance/": [
    {
      text: "Compliance",
      children: [
        {
          text: 'Cloud Foundation Maturity Model',
          children: [
            {
              text: "Tenant Management",
              children: getMarkdownFiles("docs/compliance/cfmm/tenant-management")
            },
            {
              text: "Identity and Access Management",
              children: getMarkdownFiles("docs/compliance/cfmm/iam")
            },
            {
              text: "Security and Compliance",
              children: getMarkdownFiles("docs/compliance/cfmm/security-and-compliance")
            },
            {
              text: "Cost Management",
              children: getMarkdownFiles("docs/compliance/cfmm/cost-management")
            },
            {
              text: "Service Ecosystem",
              children: getMarkdownFiles("docs/compliance/cfmm/service-ecosystem")
            }
          ],
        }
      ],
    },
  ],
};

function getMarkdownFiles(dir: string): string[] {
  return fs.readdirSync(dir).map(file => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);

    if (stat && !stat.isDirectory() && path.extname(file) === '.md') {
      return filePath.slice("docs".length, -(".md".length));
    }

    return null;
  })
    .filter(x => x !== null) as string[];

}

export default defineUserConfig({
  // site-level locales config
  bundler: viteBundler(),
  base: "/",
  locales: {
    "/": {
      lang: "en-US",
      title: "My Cloud Foundation",
      description: "My internal Cloud Developer Platform",
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

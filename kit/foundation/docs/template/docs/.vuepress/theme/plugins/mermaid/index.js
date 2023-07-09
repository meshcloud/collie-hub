const path = require('path')
const { mermaidjsPlugin, graphs } = require("./markdownItPlugin")

const vuePressPluginMermaid = (options, app) => {
  return {
    name: "MermaidJSPlugin",
    define: {
      __MERMAID_OPTIONS__: options,
    },
    extendsMarkdown(md) {
      md.use(mermaidjsPlugin);
    },
    async extendsPage(page) {
      page.data["$graphs"] = graphs[page.filePathRelative];
    },
    clientAppEnhanceFiles: path.resolve(__dirname, "./client/clientAppEnhanceFile.js"),
    clientAppSetupFiles: path.resolve(__dirname, "./client/clientAppSetup.ts"),
  };
};

module.exports = vuePressPluginMermaid;
import { path } from "@vuepress/utils";
import type { Plugin, PluginObject } from "@vuepress/core";

import { PlausiblePluginOptions } from "./shared";

export const plausiblePlugin: Plugin<PlausiblePluginOptions> = (options) => {
  const defaultOptions: Partial<PlausiblePluginOptions> = {
    stubEventTracking: false,
    enableAutoPageviews: true,
    enableAutoOutboundTracking: false,
    trackerOptions: {
      hashMode: false, // hashMode does not make sense for vuepress' routing
    },
  };

  const pluginObj: PluginObject = {
    name: "vuepress-plugin-plausible",
    multiple: false,
    clientAppSetupFiles: path.resolve(__dirname, "./client/clientAppSetup.ts"),
    define: {
      __PLAUSIBLE_OPTIONS__: Object.assign({}, defaultOptions, options),
    },
  };

  return pluginObj;
};

export default plausiblePlugin;

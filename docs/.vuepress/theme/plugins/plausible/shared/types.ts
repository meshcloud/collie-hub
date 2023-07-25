import type { PlausibleOptions } from "plausible-tracker";

export interface PlausiblePluginOptions {
  enableAutoPageviews?: boolean;
  enableAutoOutboundTracking?: boolean;
  trackerOptions: PlausibleOptions;
}

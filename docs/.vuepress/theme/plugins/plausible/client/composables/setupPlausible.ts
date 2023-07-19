import Plausible, { EventOptions, PlausibleOptions } from 'plausible-tracker';
import { computed, provide } from 'vue';

import { PlausiblePluginOptions } from '../../shared';

import type { ComputedRef, InjectionKey } from "vue";
declare const __PLAUSIBLE_OPTIONS__: PlausiblePluginOptions;
const options = __PLAUSIBLE_OPTIONS__;

export type PlausibleTracker = ReturnType<typeof Plausible>; // Plausible does not export a proper type
export type PlausibleRef = ComputedRef<PlausibleTracker>;

export const plausibleSymbol: InjectionKey<PlausibleRef> = Symbol("plausible");

export const setupPlausible = (): void => {
  const plausible = computed(() => resolvePlausible());
  plausible.value; // make sure to resolve plausible once so that it's always setup as soon as the plugin loads
  provide(plausibleSymbol, plausible);
};

function resolvePlausible(): PlausibleTracker {
  const p = Plausible(options.trackerOptions);

  if (!__VUEPRESS_SSR__) {
    // plausible uses quite a few DOM API, so we can't use it in a node env
    options.enableAutoPageviews && p.enableAutoPageviews();
    options.enableAutoOutboundTracking && p.enableAutoOutboundTracking();
  }


  return p;
}

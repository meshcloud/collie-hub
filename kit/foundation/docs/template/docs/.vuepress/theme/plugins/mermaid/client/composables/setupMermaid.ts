import { computed, provide } from "vue";

import type { ComputedRef, InjectionKey } from "vue";
import { MermaidApi } from "../MermaidApi";

export type MermaidRef = MermaidApi;
export const mermaidSymbol: InjectionKey<MermaidRef> = Symbol("Mermaid");

declare const __MERMAID_OPTIONS__: any;
const options = __MERMAID_OPTIONS__;

export const setupMermaid = (): void => {
  const Mermaid = new LazyLoadingMermaidApi();
  provide(mermaidSymbol, Mermaid);
};

class LazyLoadingMermaidApi {
  initialized = false;

  public async render(
    id: string,
    txt: string,
    cb?: (svgCode: string, bindFunctions: (element: Element) => void) => void,
    container?: Element
  ): Promise<string> {
    if (__VUEPRESS_SSR__) {
      console.warn(
        "Attempted to render mermaid during SSR build - wrap Mermaid component in <ClientOnly>"
      );
      return "";
    }

    const mermaidjs = await import("mermaid");

    if (!this.initialized) {
      mermaidjs.default.initialize({ startOnLoad: false, ...options });
      this.initialized;
    }

    return mermaidjs.default.render(id, txt, cb, container);
  }
}

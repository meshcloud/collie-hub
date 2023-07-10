import { inject } from "vue";
import { MermaidRef, mermaidSymbol } from "./setupMermaid";

export const useMermaid = (): MermaidRef => {
  const mermaid = inject(mermaidSymbol);
  if (!mermaid) {
    throw new Error("useMermaid() is called without provider.");
  }

  return mermaid;
};

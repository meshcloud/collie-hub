import { inject } from "vue";
import { PlausibleRef, plausibleSymbol } from "./setupPlausible";

export const usePlausible = (): PlausibleRef => {
  const plausible = inject(plausibleSymbol);
  if (!plausible) {
    throw new Error("usePlausible() is called without provider.");
  }

  return plausible;
};

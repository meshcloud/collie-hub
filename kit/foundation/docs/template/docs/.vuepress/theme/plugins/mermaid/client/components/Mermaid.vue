<template>
  <Loading v-if="!svg"></Loading>
  <div v-else v-html="svg" style="width: 100%"></div>
</template>

<script setup lang="ts">
import { ref, watch } from "vue";
import { usePageData } from "@vuepress/client";
import { useMermaid } from "../composables/useMermaid";

import Loading from "./Loading.vue"; // used inside template

interface Props {
  id: string;
}

const mermaid = useMermaid();
const page = usePageData<any>();
const props = defineProps<Props>();
const svg = ref<string>();
/**
 * Note: we can only render mermaid in the browser, not int he SSR (node.js) environment because mermaid depends on DOM APIs
 * This means that the Mermaid component is a strictly client-side only component
 *
 * I've tried to make this work by using __VUEPRESS_SSR__ to detect if running in SSR. However there are issues
 * - not setting up the watch() breaks hydration, i.e. the component will have the wrong state when rendered from a
 *   first page load (-> SSR hydration vs. dynamic client side rendering on second page navigation)
 *   See https://www.sumcumo.com/en/understand-and-solve-hydration-errors-in-vue-js
 * - the argument provided to the watch callback is undefined in SSR builds
 *
 * In the end I've decided to wrap usages of <Mermaid> component in <ClientOnly> component.
 * It would be niced to handle this in here, but don't know how.
 *
 */

watch(
  props,
  (value) => {
    const graph = page.value.$graphs[value.id];
    mermaid.render("mm-" + value.id, graph, (x) => {
      svg.value = x;
    });
  },

  { immediate: true }
);
</script>

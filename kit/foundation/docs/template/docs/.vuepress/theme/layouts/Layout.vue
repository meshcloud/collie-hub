<!--
Replicate the default theme layout, but add custom page-content-before/page-content-after slots
 -->
<template>
  <ParentLayout>
    <!-- override the page template slot in the default layout -->
    <template #page>
      <Home v-if="frontmatter.home" />
    </template>
  </ParentLayout>
</template>

<script setup lang="ts">
import ParentLayout from "@vuepress/theme-default/lib/client/layouts/Layout.vue";
import Home from "../components/Home.vue";
import { usePageData, usePageFrontmatter } from "@vuepress/client";

const frontmatter = usePageFrontmatter<DefaultThemePageFrontmatter>();
</script>

<style lang="scss">
</style>

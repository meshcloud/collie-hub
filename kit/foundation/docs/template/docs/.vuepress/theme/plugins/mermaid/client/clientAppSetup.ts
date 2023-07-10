import { defineClientAppSetup } from '@vuepress/client';

import { setupMermaid } from './composables/setupMermaid';

export default defineClientAppSetup(() => {
  setupMermaid();
});

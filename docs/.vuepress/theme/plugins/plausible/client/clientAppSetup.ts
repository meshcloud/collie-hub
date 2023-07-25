import { defineClientAppSetup } from '@vuepress/client';

import { setupPlausible } from './composables/setupPlausible';

export default defineClientAppSetup(() => {
  setupPlausible();
});

import Mermaid from "./components/Mermaid.vue";

/**
 * @type {import("@vuepress/client").ClientAppEnhance}
 */
export default ({ app }) => {
    // note: we don't load mermaid at this time yet - we will only invoke it the first time that a component actually
    // uses it
    app.component('Mermaid', Mermaid);
}
# Foundation Commands

> Note: this section of the documentation is under constrution.

## foundation docs

`collie foundation docs <foundation>`will prepare markdown documentation for your foundation from your collie repository.

This command first collects documentation files from the following locations

1. `README.md` files from platforms in your collie repository
2. `documentation_md` output from every platform module via `terragrunt output -raw`
3. documentation template from `kit/foundation/docs/template`

Collie then emits the output to `foundations/*/.docs`.

### Preview Documentation

The official [foundation docs module](modules/../../../kit/foundation/docs/README.md) from collie hub sets up
the static site generator [vuepress](https://v2.vuepress.vuejs.org) to generate a documentation page from this markdown page.

You can pass the optional `--preview` flag to compile and launch this website locally.

> `collie foundation docs --preview` dependes on node.js and npm

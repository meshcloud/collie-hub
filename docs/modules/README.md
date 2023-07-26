# Introduction

In the Collie Hub you will find open-source kit modules that you can use for building your cloud foundation
and landing zones on AWS, Azure & GCP.
The [cloudfoundation.org community](https://cloudfoundation.org)
maintains these modules in an [open source repository](https://github.com/meshcloud/collie-hub).

::: tip
The challenges that most organizations encounter building up a landing zone are very similar. Kit modules available on Collie Hub implement common solutions and serve as a great starting point for building your own landing zones.
:::

All available modules are grouped in the sidebar on the left by cloud platform. The `foundation` category is meant for
modules that work across multiple platforms. You will most likely not find any Terraform code here, but rather tools
that works across the entire cloud foundation across multiple platforms, for example, the template for generating your
documentation.

The source code of each kit module is linked within the kit module page and can be easily opened. The installation
command is provided on each page as well.

## How to use a module from the Hub

Assuming you have already read and used the [Getting Started](/tutorial) guide and set up your foundation for at least 
one cloud platform, you can import kit modules from the Collie Hub as following:

```shell
collie kit import "<kit-name>" # Tip: if you skip kit-name, you can interactively explore all available modules from your CLI.

# Apply the kit to your foundation of choice (as usual)
collie kit apply "<kit-name>" --foundation <foundation-name>
```

That's it! The kit module is now part of your cloud foundation. You can make edits to it and deploy it when ready:

```shell
collie foundation deploy <foundation-name> 
```

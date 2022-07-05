# Best Practices

This article is a collection of best practices and inspirations we have collected from
practioners working with landing zone construction kit.

> We're happy to hear from you about your experience - just open an issue on GitHub.

## Kit Modules

In addition to the conventions described above, the following practices have proven useful
for managing complex landing zones construction projects.

### Follow Terraform Conventions

HashiCorp publishes [module developement guidelines](https://www.terraform.io/language/modules/develop) in the official
terraform documentation. These conventions enjoy widespread recognition in the terraform community and simplify
collaboration.

Landing zone engineers should pay special attention to the guidelines
on [standard module structure](https://www.terraform.io/language/modules/develop/structure).
and [module composition](https://www.terraform.io/language/modules/develop/composition) to build kit modules.

Additionally, platform teams should consider following a [consistent naming convention](https://www.terraform-best-practices.com/naming).

### Implementing Documentation

Standard module structure recommends splitting input and output into `variables.tf` and `outputs.tf` respectively. This
enables developers to quickly find the "API contract" implemented by a module.
Since [module documentation](../reference/kit-module.md#documentation-output) is a part of landing zone construction kit's "API
contract" we recommend splitting the required input and `resource local_file` output it into a `documentation.tf` file.

["Heredoc" strings](https://www.terraform.io/language/expressions/strings) are very versatile for generating complex
module documentation. An alternative are [templatefile](https://www.terraform.io/language/functions/templatefile)s,
however these incur the cost of needing an additional `var` argument to access the modules resources and outputs.

### Reusable Modules

Terraform makes a distinction between "root" modules that come with all required  `provider` and `backend`
configurations and reusable modules that are intended to be called from other modules.

Even though kit modules will be invoked 1:1 from platform modules via terragrunt, platform teams should nonetheless
design kit modules as reusable modules. Designing kit modules as reusable modules offers many advantages

- **staging**: most platform teams want to deploy landing zones to a staging environment to test integration before
  rolling out core infrastructure changes to production
- **separation of concerns**: `terragrunt` is specifically built to overcome terraform limitations and
  [keep configurations DRY](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#keep-your-provider-configuration-dry).
  Separating the concerns of defining resources in [kit modules](../reference/kit-module.md) and orchestrating terraform
  executions in [platform modules](../reference/platform-module.md) leverages the tools where they are strongest
- **community**: reusable modules can be shared more easily with the community - and also more easily adopted to
  jumpstart your own landing zone construction kit

## Structuring kit modules

Enabling core infrastructure like virtual networks and audit log collection requires orchestrating resources across
different cloud tenants. While it's useful to structure kit modules closely resembling the virtual "anatomy" of the
cloud resource hierarchy, most platform teams will find it useful to model higher-level capabilities as well, leveraging
patterns like [dependency inversion](https://www.terraform.io/language/modules/develop/composition#dependency-inversion)
and `provider`
[configuration_aliases](https://www.terraform.io/language/providers/configuration#alias-multiple-provider-configurations)
.

The following patterns have proven useful in our experience

- structure kit modules according to **capabilities** they add to your landing zones
- kit modules should follow **encapsulation**, **privileges** and **volatility** boundaries, [see Module Creation - Recommended Pattern](https://learn.hashicorp.com/tutorials/terraform/pattern-module-creation?in=terraform/modules)
- consider **blast radius** of kit modules - smaller modules are easier to develop and iterate on due to smaller dependency graph
- leverage terragrunt `dependency` to **model dependencies** between kit modules in favor of `terraform_remote_state`

## Platform Modules

Terragrunt offers many advanced features to keep configuration DRY. However, sometimes a little more repetition is the
lesser evil. Terragrunt configurations can get "too clever" quickly, especially when they compose from too many
different dynamic configuration sources. We therefore recommend keeping terragrunt trickery to a minimum and stick to
basic features like `include` and `dependency` for as long as possible.

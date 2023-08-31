# Best Practices

This article is a collection of best practices and inspirations we have collected from
practioners working with collie.

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

Providing useful documentation for application teams is an essential part of making any platform engineering effort
succesful. This is why your kit modules should generate [documentation output](../reference/repository.md#kit-modules#documentation-output)
intended to be read by application teams and other stakeholders like security auditors.

We recommend generating the required `documentation_md` output variable in your module with a
["heredoc" string](https://www.terraform.io/language/expressions/strings).
Similarly to the standard terraform module structure splitting configuration into `variables.tf` and `outputs.tf` files,
we recommend putting your documentation in a separate `documentation.tf` file. This enables you to quickly find and
edit how your kit module generates documentation.

### Reusable Modules

Terraform makes a distinction between "root" modules that come with all required  `provider` and `backend`
configurations and reusable modules that are intended to be called from other modules.

Even though kit modules will be invoked 1:1 from platform modules via terragrunt, platform teams should nonetheless
design kit modules as reusable modules. Designing kit modules as reusable modules offers many advantages

- **staging**: most platform teams want to deploy landing zones to a staging environment to test integration before
  rolling out core infrastructure changes to production
- **separation of concerns**: `terragrunt` is specifically built to overcome terraform limitations and
  [keep configurations DRY](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#keep-your-provider-configuration-dry).
  Separating the concerns of defining resources in [kit modules](../reference/repository.md#kit-modules) and orchestrating terraform
  executions in [platform modules](../reference/repository.md#platform-modules) leverages the tools where they are strongest
- **community**: reusable modules can be shared more easily with the community - and also more easily adopted to
  jumpstart your own landing zones

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

### Managing .terraform.lock.hcl files

Terraform uses `.terraform.lock.hcl` files to [lock dependency versions](https://developer.hashicorp.com/terraform/language/files/dependency-lock) of providers and modules. If members of your cloud foundation team run a variety of operating systems and CPU architectures
managing these locks in a way that members of your team won't see depency locking issues can be [very cumbersome](https://github.com/hashicorp/terraform/issues/29958).

One important trick is to make sure that lock files contain entries for all OS and cpu architectures used in your team.
This can be accomplished by running `terraform providers lock` across all your platform modules.

```sh
 collie foundation deploy my-foundation -- providers lock -platform=darwin_amd64 -platform=linux_amd64 -platform=darwin_arm64
```

Edit the `-platform` commands as appropriate. Don't forget committing the resulting lock file updates back to your repository
to share with your team.

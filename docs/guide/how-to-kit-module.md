# Customizing Kit Modules

This how to guide will show you how to customize a [kit module](../reference/repository.md#kit-modules) or create a new one from scratch.

## Customizing a kit module

A kit module is just a standard terraform module following some minimal conventions. If you're not starting from
scratch, you most likely already have a kit module  imported from collie hub via `collie kit import`.

In our example here, we assume you already have the `azure/organization-hierarchy` module in your local collie repositorie's `kit/`folder.
Let's take a look into it.

```shellsession
$ tree kit/azure/organization-hierarchy/
kit/azure/organization-hierarchy/
├── README.md
├── documentation.tf
├── main.tf
├── outputs.tf
└── variables.tf
```

You can see that this already looks exactly like the standard [terraform module structure](https://www.terraform.io/language/modules/develop/structure) with a `main.tf` containing resources, `variables.tf` declaring input variables and `outputs.tf`
declaring output variables.

:::: code-group
::: code-group-item kit/azure/organization-hierarchy/main.tf

```hcl
resource "azurerm_management_group" "parent" {
  display_name = var.parentManagementGroup
  name = var.parentManagementGroup
}

# ...
```

:::
::: code-group-item kit/azure/organization-hierarchy/variables.tf

```hcl
variable "parentManagementGroup" {
  default = "lv-foundation"
}

# ...
```

:::
::: code-group-item kit/azure/organization-hierarchy/outputs.tf

```hcl
output "parent_id" {
  value = azurerm_management_group.parent.id
}

# ...

```

:::
::::

::: tip
This guide does not cover `documentation.tf`, which is instead explained in
[How to document Kit Modules](./how-to-document.md).
:::

### Adding or editing Resources

From here on you can make changes to your terraform code as you would do with any other terraform code.
Let's suppose you want to add a further management group to this module to host some of your legacy workloads
(that were created before you were around to create a proper landing zone 😁). Simply add that new management group
to the `main.tf` file like so

:::: code-group
::: code-group-item kit/azure/organization-hierarchy/main.tf

```hcl{6-9}
resource "azurerm_management_group" "parent" {
  display_name = var.parentManagementGroup
  name = var.parentManagementGroup
}

resource "azurerm_management_group" "legacy" {
  display_name               = "legacy
  parent_management_group_id = azurerm_management_group.parent.id
}

# ...
```

:::
::::

Now we need to deploy all [platform modules](./../reference/repository.md#platform-modules) that apply this kit module to a
cloud platform. The quick and easy way is to just run `collie foundation deploy` to run `terraform apply` accross your
entire foundation.

```shelsession
$ collie foundation deploy likvid-prod
deploying (apply) foundations/likvid-prod/platforms/azure ...
deploying (apply) foundations/likvid-prod/platforms/azure ...
INFO[0000] The stack at /Users/collie/foundations/likvid-prod/platforms/azure will be processed in the following order for command apply:
Group 1
- Module /Users/collie/foundations/likvid-prod/platforms/azure/organization-hierarchy

Are you sure you want to run 'terragrunt apply' in each folder of the stack described above? (y/n) y

...

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```

### Adding variables

Let's suppose you want to make the display name of that management group also configurable. In this case we need to
also add a new variable to `variables.tf`.

:::: code-group
::: code-group-item kit/azure/organization-hierarchy/main.tf

```hcl{6-9}
resource "azurerm_management_group" "parent" {
  display_name = var.parentManagementGroup
  name         = var.parentManagementGroup
}

resource "azurerm_management_group" "legacy" {
  display_name               = var.legacyManagementGroup
  parent_management_group_id = azurerm_management_group.parent.id
}

# ...
```

:::

::: code-group-item kit/azure/organization-hierarchy/variables.tf

```hcl{5-7}
variable "parentManagementGroup" {
  default = "lv-foundation"
}

variable "legacyManagementGroup" {
  # no default here!
}

# ...
```

:::
::::

Note how we did not specify a default value for the `legacyManagementGroup` variable above. This means we now
need to update all of the platform modules' `terragrunt.hcl` files that apply this kit module to a cloud platform
to provide a value for this new variable.

You can use `collie foundation tree` to find this out

```shellsession{6}
$ collie foundation tree
└─ foundations
   ├─ likvid-prod
   │  └─ platforms
   │     ├─ azure
   │     │  ├─ organization-hierarchy: foundations/likvid-prod/platforms/azure/organization-hierarchy/terragrunt.hcl
   │     │  │  ├─ kitModule: azure/organization-hierarchy
   │     │  │  └─ controls
   │     │  │     └─ 0: cfmm/tenant-management/resource-hierarchy
```

::: tip
In most terminals you can Cmd-click or Ctrl-click the file path to `terragrunt.hcl` to quickly open the file in
your editor
:::

Now let's add a value for this variable.

:::: code-group
::: code-group-item foundations/likvid-prod/platforms/azure/organization-hierarchy/terragrunt.hcl

```hcl{15}
include "platform" {
  path = find_in_parent_folders("platform.hcl")
}

include "module" {
  path = find_in_parent_folders("module_root.hcl")
}

terraform {
  source = "${get_repo_root()}//kit/azure/organization-hierarchy"
}

inputs = {
  parentManagementGroup = "likvid-foundation"
  legacyManagementGroup = "super-old-legacy-stuff"
}
```

:::
::::

And then run `collie foundation deploy` to apply the changes.

## Create a new kit module

Next let's look at how to create a new kit module from scratch. Of course collie has a command `collie kit new` to help
you with that and will prompt you for all necessary inputs

```shellsession
$ collie kit new "gcp/organization-hierarchy"
 ? Choose a human-friendly name for this module (gcp/organization-hierarchy) › GCP Organization Setup

generated new kit module at kit/gcp/gcp/organization-hierarchy/README.md
Tip: add terraform code to your kit module at kit/gcp/organization-hierarchy/main.tf

$ tree kit/gcp/organization-hierarchy/
kit/gcp/organization-hierarchy/
├── README.md
├── documentation.tf
├── main.tf
├── outputs.tf
└── variables.tf
```

You might now wonder where collie stores that display name it asked you for. Collie stores all metadata
about [configuration objects](../reference/repository.md#configuration-objects) in `README.md` files. You can find
more details in the [Kit Module reference documentation](../reference/repository.md#kit-modules).

:::: code-group
::: code-group-item kit/gcp/organization-hierarchy/README.md

```md
---
name: GCP Organization Setup
summary: |
  deploys new cloud foundation infrastructure.
  Add a concise description of the module's purpose here.
# optional: add additional metadata about implemented security controls
---

# GCP Organization Setup

This documentation is intended as a reference documentation for cloud foundation
or platform engineers using this module.

```

:::
::::

As the template describes, you can add custom documentation here. This documentation is mostly useful for your own
reference, unlessyou plan on contributing the module to [collie hub](../modules/README.md) as well (we are always
 happy about receiving pull requests!).

The next steps should all be already familiar to you:

- fill your module with resources, see [customizing a kit module](#customizing-a-kit-module) above
- verify your module is
- apply your kit module to a cloud using `collie kit apply`
- deploy your module using `collie foundation deploy`

After completing all of these steps, [How to document Kit Modules](./how-to-document.md) will show you how to create
and maintain documentation for application teams.

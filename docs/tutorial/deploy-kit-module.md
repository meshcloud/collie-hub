# Deploy your first Kit Module

In this tutorial you will learn

- import a reusable kit module from [collie hub](../hub/)
- apply kit modules to your cloud platforms and deploy them
- how collie leverages terraform and terragrunt for an efficient workflow

As a simple example, we will deploy an Organization Hierarchy to our cloud platform.

First things first, for our journey, we need an organizational hierarchy for the Azure Cloud Platform. In this case, we will use the Collie Kit functionality to deploy it. To import the kit, use the following command:

## Import Kit Module from Collie Hub

A [kit module](../reference/kit-module.md) is a reusable terraform module that we can apply to our foundation's cloud platform and deploy it. Collie hub is an open source repository where the cloudfoundation.org community publishes reusable kit modules. You can think of it like "Docker Hub".


Let's start by exploring the list of available hub modules either online at [collie hub](../hub/) or in the interactive prompt 
in

```sh
 collie kit import
 ```

```text
Select a kit module from official hub modules ⌕
**❯ Azure Organization Hierarchy azure/organization-hierarchy**
ℹ 7/11 Next: ↓, Previous: ↑, Next Page: ⇟, →, Previous Page: ⇞, ←, Submit: ↵
```

1. Additionally, we need a `terragrunt.hcl` file for Terraform. Create it using `collie kit apply` and choose the `Azure Organization Hierarchy azure/organization-hierarchy` kit. 
```shell

cat foundations/likvid-prod/platforms/az/organization-hierarchy/terragrunt.hcl

include "platform" {
  path = find_in_parent_folders("platform.hcl")
}

include "module" {
  path = find_in_parent_folders("module.hcl")
}

terraform {
  source = "${get_repo_root()}//kit/azure/organization-hierarchy"
}

inputs = {
  # todo: set input variables
  connectivity          = "lv-connectivity"
  corp                  = "lv-corp"
  identity              = "lv-identity"
  landingzones          = "lv-landingzones"
  management            = "lv-management"
  online                = "lv-online"
  parentManagementGroup = "lv-foundation"
  platform              = "lv-platform"

}
```

We need some changes before we can work with the kit.  
for the terraform backend handling over multiple environments it is recommended to have a DRY configuration. In this tutorial we have only one foundation and we will changing our terragrunt configuration. In the next tutorial `bootstrap` we look deeper into it.

:::tip
You want to know more about DRY and Terragrunt?
[Terragrunt DRY](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#keep-your-backend-configuration-dry)
:::

```hcl
locals {
    platform = yamldecode(regex("^---([\\s\\S]*)\\n---\\n[\\s\\S]*$", file(".././/README.md"))[0])
}

# recommended: state configuration
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "local" {
  }
}
EOF
}
  # recommended: generate a default provider configuration
  generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite"
    contents  = <<EOF

provider "azurerm" {
  features {}
  skip_provider_registration = false
  tenant_id                  = "${local.platform.azure.aadTenantId}"
  subscription_id            = "${local.platform.azure.subscriptionId}"
}
  EOF
}
 
terraform {
  source = "${get_repo_root()}//kit/azure/organization-hierarchy"
}

inputs = {
  # todo: set input variables
  output_md_file = "${get_path_to_repo_root()}/../output.md"
  connectivity          = "lv-connectivity"
  corp                  = "lv-corp"
  identity              = "lv-identity"
  landingzones          = "lv-landingzones"
  management            = "lv-management"
  online                = "lv-online"
  parentManagementGroup = "lv-foundation"
  platform              = "lv-platform"
  
}
```
We removed the include configuartion because we just running our kit in a 

4. Now, we can deploy our first module by running `collie foundation deploy likvid-foundation-dev --platform az --module organization-hierarchy`.
5. Type in `yes`.
6. You should now have the hierarchy to build up your Azure platform.


### Next Steps

To go from this simple introduction to a productive use of the landing zone construction kit we recommend reviewing
our example implementation of a cloud foundation.


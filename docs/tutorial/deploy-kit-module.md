# Deploy your first Kit Module

In this tutorial you will learn

- import a reusable kit module from [collie hub](../modules/)
- apply kit modules to your cloud platforms and deploy them
- how collie leverages terraform and terragrunt for an efficient workflow

As a simple example, we will deploy an Organization Hierarchy to our cloud platform.

First things first, for our journey, we need an organizational hierarchy for the Azure Cloud Platform. In this case, we will use the Collie Kit functionality to deploy it. To import the kit, use the following command:

## Import Kit Module from Collie Hub

A [kit module](../reference/kit-module.md) is a reusable terraform module that we can apply to our foundation's cloud platform and deploy it. Collie hub is an open source repository where the cloudfoundation.org community publishes reusable kit modules. You can think of it like "Docker Hub".


Let's start by exploring the list of available hub modules either online at [collie hub](../modules/) or in the interactive prompt 
in

```sh
 collie kit import
 ```

```text
Select a kit module from official hub modules ⌕
**❯ Azure Organization Hierarchy azure/oganization-hierarchy**
ℹ 7/11 Next: ↓, Previous: ↑, Next Page: ⇟, →, Previous Page: ⇞, ←, Submit: ↵
```

1. Additionally, we need a `terragrunt.hcl` file for Terraform for our configuration of the module itslef. 

```sh
collie kit apply 
```
```text
 ? Select a kit module from your repository ⌕
 ❯ Azure Organization Hierarchy azure/organization-hierarchy
 ℹ 3/5 Next: ↓, Previous: ↑, Next Page: ⇟, →, Previous Page: ⇞, ←, Submit: ↵
```

and choose the `Azure Organization Hierarchy azure/organization-hierarchy` kit. 

let us do a short look to the `terragrunt.hcl` the file with 
```sh
cat foundations/likvid-prod/platforms/az/organization-hierarchy/terragrunt.hcl
```

```hcl
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
In the `terragrunt.hcl` we have a certain place for each module for our configuration to get a `DRY` config over multiple environments like `prod` and `dev`. In this tutorial we have only one foundation.

:::tip
You want to know more about DRY and Terragrunt?
[Terragrunt DRY](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#keep-your-backend-configuration-dry)
:::

Now, we can deploy our first module by running 
```sh
collie foundation deploy likvid-foundation-dev --platform az --module organization-hierarchy.
```

5. Type in `yes`.
6. You should now have the hierarchy to build up your Azure platform.

### Next Steps

To go from this simple introduction to a productive use of the landing zone construction kit we recommend reviewing
our example implementation of a cloud foundation.


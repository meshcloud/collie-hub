# Deploy your first Kit Module

In this tutorial you will learn how to use collie's terraform workflow to build and deploy landing zone infrastructure. This tutorial assumes you have completed the [Start your Cloud Foundation](./README.md) tutorial and will show you how to

- apply [reusable kit module](../modules/) to your cloud platforms and deploy them
- "bootstrap" a cloud platform so that you can manage terraform state
- deploy an organization hierarchy as a starting point for your landing zone architecture
- safely make changes to deployed infrastructure with collie's terraform workflow

## Bootstrap a cloud platform

The first module that you are going to deploy on a new cloud platform is always the "boostrap" module. The goal of [bootstrapping](../concept/bootstrapping.md) is to prepare the cloud platform so that you and other platform engineers on your team can deploy further kit modules to the platform in an easy way and repeatable way.

### Import Bootstrap Kit Module from Collie Hub

Let's leverage the [azure/bootstrap](../modules/azure/bootstrap/README.md) as a starting point for our own implementation.

```sh
collie kit import azure/bootstrap
```

When you run this command, collie will download and copy the kit module into to the `kit` folder
of your repository. Let's inspect what we got.

<!-- TODO: @fnowarre UPDATE -->
```shellsession
$ tree kit/azure/bootstrap
kit/azure/bootstrap
├── README.md
├── documentation.tf
├── main.tf
├── outputs.tf
├── template
│   ├── platform
│   │   ├── module.hcl
│   │   └── platform.hcl
│   └── platform-module
│       └── terragrunt.hcl
└── variables.tf

3 directories, 8 files
```

As you can see a kit module is a standard terraform module with the typical files like `main.tf` and `variables.tf`
with some additional files like `documentation.tf` and a `template` folder. We will explain what these are for in a later tutorial. For now it's enough to understand that a kit module is just a standard terraform module.

::: tip
By importing kit modules into your own repository we effectively enable a "fork-and-own" approach to managing modules.
This lets you make any changes and customizations to the module directly in source code.
:::

### Apply the bootstrap kit module

We now have the kit module in our repository, but we haven't deployed it yet. In order to do so, we need to "apply"
the module to a cloud platform.

::: tip
Seperating the definition of kit modules from how we apply them to a platform allows us to apply the same kit module multiple times in different configurations, for example to separate a development from a production foundation.
:::

To apply the kit module run `collie kit apply azure/bootstrap` and interactively pick the foundation and cloud platform you want to apply the module to.

<!-- TODO: force collie tips on newlines -->
```shellsession
$ collie kit apply azure/bootstrap
parsing kit modules ...
parsing kit modules DONE 24ms
 ? Select a foundation › likvid-prod
 ? Select a platform › az
applied module kit/azure/bootstrap to foundations/likvid-prod/platforms/az/bootstrap

Tip: edit the terragrunt configuration invoking the kit module at foundations/likvid-prod/platforms/az/bootstrap/terragrunt.hcl
```

As collie tells you in the last line of the output, it generated a `terragrunt.hcl` file for you. Let's explore what this is good for.

### Inspect the terragrunt.hcl file

Collie uses [terragrunt](https://terragrunt.gruntwork.io) to deploy the terraform-based kit modules. For the purposes of this tutorial it's
sufficient to think of terragrunt as a very simple wrapper tool for calling terraform. You can define all aspects of how
to call terraform in a `terragrunt.hcl`, using the same HCL language you're already familiar with from using terraform.

Let's take a moment to inspect that file. In a slightly simplified form, the file should look like this:

:::: code-group
::: code-group-item foundations/likvid-prod/platforms/az/azure/bootstrap/terragrunt.hcl
```hcl
include "platform" {
  path   = find_in_parent_folders("platform.hcl")
  # ...
}

terraform {
  source = "${get_repo_root()}//kit/azure/bootstrap"
  # ...
}

generate "provider" {
  path      = "provider.tf"
  contents  = <<EOF
provider "azurerm" {
  # ...
}

provider "azuread" {
  # ...
}
EOF
}


inputs = {
  # ...
}
```
:::
::::

At the top we have an `include` blocks for including configuration from another file. We will skip this detail for now and review it later in a moment when we [deploy the organization hierarchy module](#deploy-organization-hierarchy).

This is followed by a `terraform` block that tells terragrunt
where to find the terraform module to call.

Up next we have a `generate` block which dynamically generates a file into the terraform configuration. This terragrunt trick is useful to make [provider configuration](https://developer.hashicorp.com/terraform/language/providers/configuration) dynamic, which is otherwise not possible in vanilla terraform.

Finally we have an `inputs` block that allows us to set input variables for this module. This is also where you will now have to make some decisions like how you want to name the resources the module will deploy for you.

### Perform the first bootstrap pass

After saving the `terragrunt.hcl` we can now deploy the bootstrap module with the command `collie foundation deploy`. Because the bootstrap module is special in collie's workflow, we need to explicitly pass the `--bootstrap` flag.

```sh
collie foundation deploy likvid-prod --bootstrap
```

Collie will now invoke terragrunt which invokes terraform under the hood. You should see the familiar terraform plan and prompt for confirmation

```shellsession
$ collie foundation deploy likvid-prod  --bootstrap

running 'apply' in foundations/likvid-prod ...
running 'apply' in foundations/likvid-prod/platforms/az/bootstrap ...
Initializing modules...
- terraform_state in terraform-state

Initializing the backend...

Successfully configured the backend "local"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching ">= 3.5.0, < 4.0.0"...
...


Terraform has been successfully initialized!


Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azuread_app_role_assignment.cloudfoundation_deploy-approle will be created
  + resource "azuread_app_role_assignment" "cloudfoundation_deploy-approle" {
...

Plan: 15 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ...

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
```

After confirming the apply, you should see the bootstrap module has successfully deployed.

```shellsession
Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

Outputs:

...
```

This is great news, you now have deployed your first cloud resources with collie!

### Perform the second bootstrap pass

We are however not fully done bootstrapping yet. One key benefit of using terraform is that we can just re-execute the module to see if there is any configuration drift between the desired state specified in our collie repositiory and the actual state of resources deployed in the cloud.

Let's just run the previous command again and see what happens.

```shellsession
$ collie foundation deploy likvid-prod  --bootstrap 
...
│ Error: Backend initialization required: please run "terraform init"
│
│ Reason: Backend type changed from "local" to "azurerm"
│
│ The "backend" is the interface that Terraform uses to store state,
│ perform operations, etc. If this message is showing up, it means that the
│ Terraform configuration you're using is using a custom configuration for
│ the Terraform backend.
│
│ Changes to backend configurations require reinitialization. This allows
│ Terraform to set up the new configuration, copy existing state, etc. Please
│ run
│ "terraform init" with either the "-reconfigure" or "-migrate-state" flags
│ to
│ use the current configuration.

...
```

We get an error! Thankfully, this is an expected part of the bootstrapping process. What happened here is that the first deploy of the bootstrap module creates an Azure Blob storage for storing all our terraform state for this platform. After the first deploy, the bootstrap module reconfigures itself to use that new state backend and needs to migrate state from your local disk (where state was stored before) to the that new Blob storage.

::: details How does the bootstrap module reconfigure itself?
Remember that mysterious `platform.hcl` file included by `terragrunt.hcl`? That file contains a terragrunt `generate` block to generate a `backend.tf` file configuring the state backend terraform uses.

The trick here is that `platform.hcl` detects whether there's a `tfstates-config.yml` in your repository containing information about the Azure Blob storage. This file is created by the bootstrap module on its first deploy.

```shellsession
$ tree foundations/likvid-prod/platforms/az
├── terragrunt.hcl
└── tfstates-config.yml

```

:::

So the error message we got from terraform tells us that we need to do next: run `terraform init -migrate-state`. 

Collie's command `collie foundation deploy` has an easy way to run an arbitrary terraform commands by appending a ` -- <command>`. 

```shellsession
$ collie foundation deploy likvid-prod  --bootstrap -- init -migrate-state

...

Initializing the backend...
Terraform detected that the backend type changed from "local" to "azurerm".

Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "azurerm" backend. No existing state was found in the newly
  configured "azurerm" backend. Do you want to copy this state to the new "azurerm"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes
```

As usual, terraform tells you what its about to do and prompts you for confirmation. After confirming you should see this output

```text
Successfully configured the backend "azurerm"! Terraform will automatically
use this backend unless the backend configuration changes.
...
```

::: tip
Terraform is usually good at telling you about what the issue is and what terraform commands you can use to potentially fix it. Running custom terraform commands with `collie foundation deploy -- command` is a common workflow to troubleshoot any terraform issues you encounter.
:::

We are now fully bootstrapped! Finally and as promised before, re-running the bootstrapped module should now result in no more changes

```shellsession
$ collie foundation deploy likvid-prod  --bootstrap

...

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

... 

```

## Deploy Organization Hierarchy

Now that we have bootstrapped. Let's move on to deploy our organization hierarchy. Since we are using Azure in this example, we will set up a Management Group structure that follows common [best practices](https://cloudfoundation.org/maturity-model/tenant-management/resource-hierarchy.html). Again, collie-hub has a kit module ready to do this.

### Import the Kit Module

By now you have propably memorized the workflow to import a kit module using the command `collie kit import <module-id>`. There's one more trick
to run this command, and that is to leave out the module id and instead use an interactive prompt to search for the right module.

```sh
 collie kit import
 ```

You can type to search the organization hierarchy module or simply browse with the arrow keys.

```shellsession{4}
$ collie kit import
 ? Select a kit module from official hub modules ⌕ azure
   Azure Bootstrap azure/bootstrap
 ❯ Azure Organization Hierarchy azure/organization-hierarchy
   Allowed Locations azure/policy/allowed-locations
 ℹ 5/7 Next: ↓, Previous: ↑, Next Page: ⇟, →, Previous Page: ⇞, ←, Submit: ↵
```

### Apply Kit Module and Deploy

As before with the bootstrap kit module, we now apply the organization hierarchy kit module using `collie kit apply`. Since we don't pass any additional parameters, collie will prompt for them interactively.

```shellsession
$ collie kit apply
parsing kit modules ...
parsing kit modules DONE 24ms
 ? Select a kit module from your repository › Azure Organization Hierarchy azure/organization-hierarchy
 ? Select a foundation › likvid-prod
 ? Select a platform › az
applied module kit/azure/bootstrap to foundations/likvid-prod/platforms/az/azure/organization-hierarchy

Tip: edit the terragrunt configuration invoking the kit module at foundations/likvid-prod/platforms/az/azure/organization-hierarchy/terragrunt.hcl
```

The `terragrunt.hcl` generated by collie for applying this kit module is a lot simpler this time and is fine do deploy without any changes.

:::: code-group
::: code-group-item foundations/likvid-prod/platforms/az/azure/organization-hierarchy/terragrunt.hcl
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
:::
::::

::: tip
You can always find more information on how to work with a particular kit module in that module's description on Collie Hub. Here's the description of the [Organization Hierarchy Kit Module](../modules/azure/organization-hierarchy/README.md).
:::

After deploying, review your hierarchy in Azure portal or - more quickly - with the [tenant tree command](../reference/tenant.md#listing-cloud-resource-hierarhcy).

<!-- TODO @fnowarre: add collie tenant tree shellsession code block with sample output -->

### Exercise: Modify configuration and Destroy resources

At this point of the tutorial, we can run through a little exercise to reaffirm your mastery of collie.

- make changes to `inputs` in `terragrunt.hcl` like renaming one of the management groups
- deploy your changes using `collie foundation deploy likvid-prod`
- destroy all cloud resources using `terraform destroy` via `collie foundation deploy likvid-prod -- destroy`

## Next Steps

We covered a lot of ground in this tutorial and you should now feel comfortable deploying simple kit modules from Collie Hub. In the next tutorial we will learn how to create and edit kit modules terraform source code directly and generate great documentation for your application teams.

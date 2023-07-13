# Getting Started

This tutorial will lead you through the steps to get started with collie 

- Add a cloud platform to your foundation
- Create and deploy a Organization Hierarchy to this cloud platform (using an existing kit module)


### 1. Start your Cloud Foundation

In this and upcoming tutorials we are using the fictional Company name Likvid. 

To start your cloud journey with Likvid, follow these steps:

1. Create a folder for your foundation by running the command: **`mkdir -p likvid-foundation-repo && cd likvid-foundation-repo`**.
2. Transform the folder into a Git repository using the command: **`collie init`**.
3. Next, create the foundation itself by executing: **`collie foundation new likvid-foundation-dev`**.
4. Add a cloud platform, in this case, Azure, by selecting `Azure` when prompted. Define an ID for the platform, such as `az` and provide a human-readable name for it, also `az`
5. Select the account to configure the Azure Active Directory (AAD) Tenant ID and default Subscription ID. For example: `foundation-likvid-dev / AAD 00000000-1111-2222-3333-444444444444`. Save the configuration and exit the assistant.

After completing these steps, your repository structure will resemble the following:

```shell
`tree
.
├── [README.md](http://readme.md/)
├── compliance
├── foundations
│   └── likvid-foundation-dev
│       ├── [README.md](http://readme.md/)
│       └── platforms
│           └── az
│               └── [README.md](http://readme.md/)
└── kit
└── [README.md](http://readme.md/)`

`7 directories, 4 files`
```


### 2. Deploying Your First Kit

First things first, for our journey, we need an organizational hierarchy for the Azure Cloud Platform. In this case, we will use the Collie Kit functionality to deploy it. To import the kit, use the following command:

1. Run `collie kit import`.

```
Select a kit module from official hub modules ⌕
**❯ Azure Organization Hierarchy azure/organization-hierarchy**
ℹ 7/11 Next: ↓, Previous: ↑, Next Page: ⇟, →, Previous Page: ⇞, ←, Submit: ↵
```

2. Additionally, we need a `terragrunt.hcl` file for Terraform. Create it using `collie kit apply` and choose the `Azure Organization Hierarchy azure/organization-hierarchy` kit.

3. When you run `cat foundations/likvid-foundation-dev/platforms/az/organization-hierarchy/terragrunt.hcl` on the file, you'll see that there are two additional files required to run our environment:

```shell
include "platform" {
  path = find_in_parent_folders("platform.hcl")
}

include "module" {
  path = find_in_parent_folders("module.hcl")
}
```

Copy this code block to `likvid-foundation-repo/foundations/likvid-foundation-dev/platforms/az/module.hcl`.

```shell
# Define shared configuration here that most non-bootstrap modules in this platform want to include

# Optional: make Collie's platform config available in Terragrunt by parsing frontmatter
locals {
  platform = yamldecode(regex("^---([\\s\\S]*)\\n---\\n[\\s\\S]*$", file(".//README.md"))[0])
}

# Recommended: generate a default provider configuration
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
provider "azurerm" {
  features {}
  alias                      = "connectivity"
  subscription_id            = "${local.platform.azure.subscriptionId}"
  tenant_id                  = "${local.platform.azure.aadTenantId}"
}
provider "azurerm" {
  features {}
  alias                      = "management"
  subscription_id            = "${local.platform.azure.subscriptionId}"
  tenant_id                  = "${local.platform.azure.aadTenantId}"
}

EOF
}
```

Copy this code block to `likvid-foundation-repo/foundations/likvid-foundation-dev/platforms/az/platform.hcl`.

```shell
locals {
  platform = yamldecode(regex("^---([\\s\\S]*)\\n---\\n[\\s\\S]*$", file(".//README.md"))[0])
}

# Recommended: enable documentation generation for kit modules
inputs = {
  output_md_file = "${get_path_to_repo_root()}/../output.md"
}

# Recommended: remote state configuration
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
```

4. Now, we can deploy our first module by running `collie foundation deploy likvid-foundation-dev --platform az --module organization-hierarchy`.
5. Type in `yes`.
6. You should now have the hierarchy to build up your Azure platform.


### Next Steps

To go from this simple introduction to a productive use of the landing zone construction kit we recommend reviewing
our example implementation of a cloud foundation.

- add a second (productive) cloud foundation `collie foundation new my-foundation-prod`
- review kit module usage `collie kit tree` to ensure/dev-prod parity
- build an interactive documentation for your cloud foundation using `collie foundation docs my-foundation`
- document compliance controls and their implementation using `collie compliance`

# Documenting Kit Modules

If you followed the [Getting started](./../tutorial/README.md) tutorial, you have already seen the
markdown-based documentation output generated by `collie foundation docs`. Human-readable documentation
for application teams helps them decide ahead of time whether your landing zones are suitable for their application.

The documentation also lets you document important policies for other stakeholders like IT Security auditors in your
organization.

## How kit modules generate documentation

Collie includes a markdown-based documentation workflow that leverages the
`output "documentation_md"` generated by every kit module.

Kit modules from [collie hub](../../modules/README.md) or generated by `collie init` include a `documentation.tf` file
that produce a `documentation_md` output with a hcl ["heredoc" string](https://www.terraform.io/language/expressions/strings).

As an example, let's look at the a practical example for defining and documenting policies for GCP. We call our kit 
module  `gcp/organization-hierarchy`

:::: code-group
::: code-group-item documentation.tf

```hcl
output "documentation_md" {
  value = <<EOF
All resources of this platform are nested under the top-level GCP folder `${var.root_folder_name}`.
All policies described below are also set at this folder level.

### Resource Locations

[Resource Locations](https://cloud.google.com/resource-manager/docs/organization-policy/defining-locations) restrics deployment of resources to whitelisted regions.
This prevents deployment of resources outside of approved locations.

The allowed resource locations are

${join("\n", formatlist("- `%s`", var.resource_locations_to_allow))}

EOF
}
```

:::
::: code-group-item main.tf

```hcl
resource "google_folder" "root" {
  display_name = var.root_folder_name
  parent       = "organizations/${var.organization_id}"
}

module "allowed-policy-resource-locations" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.1.0"
  policy_for        = "folder"
  folder_id         = google_folder.root.id
  constraint        = "constraints/gcp.resourceLocations"
  policy_type       = "list"
  allow             = var.resource_locations_to_allow
  allow_list_length = length(var.resource_locations_to_allow)
}
```

:::
::: code-group-item variables.tf

```hcl
variable "root_folder_name" {
  type        = string
  nullable    = false
  description = <<EOF
    Create a folder of the specified name and treat it as the root of all resources managed as part of this kit.
  EOF
}

variable "resource_locations_to_allow" {
  type        = list(string)
  description = "The list of GCP resource locations to allow"
}
```

:::
::::

As you can see to build the `documentation_md` output we make use of standard markdown formatting like to provide headings and links.
We also leverage [string templates](https://developer.hashicorp.com/terraform/language/expressions/strings#string-templates).
to include `resource_locations_to_allow` variable in our documentation. This variable is also passed to `module "allowed-policy-resource-locations"`, so both our actual policy and our documentation will always be in sync.

::: tip
Using terraform resources, variables and data objects in your documentation helps ensure that documentation is
automatically updated when you make any changes to your landing zones in the future. This helps maintain accurate
and relevant documentation with low effort.
:::

## How collie generates documentation

When you run [collie foundation docs](./../reference/foundation-commands.md#foundation-docs), collie will run terragrunt to collect the `documentation_md` output from every
[platform module](./../reference/repository.md#platform-modules) in your foundation.

Collie stores the collected outputs in individual markdown files in a structure suitable for static site generators.
You can find this output in your collie repository at `foundations/*/.docs`.

> At the moment collie supports generating static sites with vuepress out of th ebox. It's of course also possible
> to just copy the markdown files into a different platform like Confluence.

In our example we can find the generated documentation at `foundations/likvid-prod/.docs/docs/platforms/gcp/ gcp-organization-hierarchy.md`.

```shellsession
16:03 $ tree foundations/likvid-prod/.docs/
foundations/likvid-prod/.docs/
├── .vuepress
│   └── ...
├── docs
│   ├── README.md
│   ├── compliance
│   │   ├── README.md
│   │   ├── cfmm
│   │   │   ├── README.md
│   │   │   ├── iam
│   │   │   │   ├── authorization-concept.md
│   │   │   │   ├── ...
│   │   │   │   └── service-account-management.md
│   │   │   ├── ...
│   ├── foundation
│   │   ├── README.md
│   │   └── shared-responsibility-model.md
│   └── platforms
│       ├── README.md
│       ├── azure
│       │   ├── azure-admin-activity-log.md
│       │   └── azure-bootstrap.md
│       ├── azure.md
│       ├── gcp
│       │   ├── gcp-organization-hierarchy.md
│       │   └── gcp-bootstrap.md
│       └── gcp.md
├── node_modules
├── package-lock.json
└── package.json
```

::: tip
As the `.docs` folder is built from your collie repository, you would typically not check it into git.
:::

## Editing Documentation

In order to edit documentation, it's always important to apply edits directly to the **source** of documentation in
your collie repository. The reference documentation for [collie foundation docs](./../reference/foundation-commands.md#foundation-docs) lists these locations.

For documentation generated by kit modules as described in this guide, it's important to also run `collie foundation deploy`
to update the `documentation_md` terraform ouput of the platform modules.

::: tip
To work with a live reloading preview, you can keep `collie foundation docs --preview` running in one shell, while running `collie foundation docs` in a second shell to update the documentation after making changes.
:::
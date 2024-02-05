# Collie Repository

Collie always stores the definition of your cloud foundation and all landing zones as code in a git repository.
This repository contains infrastructure as code and configuration files enabling a well-structured, opinionated workflow.
The [collie](https://github.com/meshcloud/collie-cli) cli tool understands this structure and helps you work with it.

The top-level of this hierarchy contains these folders:

- `foundations/` stores [foundations](#foundations) defining a set of cloud [platforms](#platforms) and their configuration
- `kit/` stores [kit modules](#kit-modules) to assemble landing zones on your foundations' cloud platforms
- `compliance/` stores [compliance controls](#compliance-controls) that your kit modules implement

## Configuration Objects

Configuration objects are stored in this repository directory hierarchy in the form of "literate" config files -
markdown config files with YAML frontmatter. A markdown file with frontmatter generally looks like this:

```markdown
---
key: value
---

# Description

Human readable description of this object to be included in generated
documentation.

```

- the **frontmatter** contains a YAML configuration object, meant for consumption by automation tools
- the markdown should describe the configuration in a human readable format that is friendly to other stakeholders
  (e.g. developers, security auditors) working with your landing zones

The collie cli tool validates configuration objects in the repository and reports any errors found.

## Foundations

A foundation inside the `foundations/` folder generally has the following folder structure

```sh
foundations/my-foundation/
├── README.md                         # the foundation configuration file
└── platforms
    ├── my-cloud-platform
    │   ├── README.md                 # the platform configuration file
    │   ├── admin                     # platform modules to configure the landing zone (administrative workload)
    │   │   └── tenant                # the admin/tenant platform module,
    │   │       └── terragrunt.hcl      # terragrunt configuration invoking kit module, e.g. //kit/admin/tenant
    │   ├── bootstrap                 # a bootstrap platform module, 1:1
    │   │   └── terragrunt.hcl          # terragrunt configuration invoking kit module, e.g. //kit/bootstrap
    │   ├── tenants                   # infrastructure as code for customer workloads
    │   │   ├── customer-1
    │   │   └── ...
    │   └── platform.hcl              # shared terragrunt config for the platform, e.g. backend and provider settings
    └── my-other-platform
        ├── ...
```

### Foundation Metadata

The foundation `README.md` does not need to contain any frontmatter metadata. It's included in documentation.

## Platforms

A cloud platform configuration object in a collie repository is stored at `foundations/*/platforms/*/README.md`.
Platform configurations are stored as yaml frontmatter in these files.

### Platform Metadata

This section documents the mandatory and optional configuration properties for each type of cloud platform.
Note that you can include additional keys in your configuration to capture data that's useful for automation.

#### Common Settings

Settings under the `cli` key will be used by `collie` to set environment variables when invoking the underlying
cloud cli tools. These environment variables will be set verbatim, so please consult the documentation of the respective
cli tool for the configuration possibilities.

Note that many terraform providers (e.g. `azurerm` or `google`) support using the credentials managed by their respective
cloud cli tools. This is especially useful for bootstrapping landing zone deployment.

```yaml
cli:
  aws:     # environment used ot invoke the aws cli tool
  az:      # environment used ot invoke the az cli tool
  gcloud:  # environment used ot invoke the az cli tool
```

#### AWS

```markdown
---
aws:
  accountId: "123456789012"                          # required
  accountAccessRole: "OrganizationAccountAccessRole" # required
cli:
  aws:
    AWS_PROFILE: default                      # required
    AWS_CONFIG_FILE: ./credentials/bootstrap  # optional
---
```

#### Azure

```markdown
---
azure:
  aadTenantId: 00000000-0000-0000-0000-000000000000    # required
  subscriptionId: 00000000-0000-0000-0000-000000000000 # required
cli:
  az:
    AZURE_CONFIG_DIR: ./az # optional
---
```

#### GCP

```markdown
---
gcp:
  organization: "1234567890" # required
  project: foundation-12345  # required
  billingExport:             # optional, required for collie tenant cost functionalits
    project: billing-data-1234
    dataset: billing_export
    view: collie_billing_view
cli:
  gcloud:
    CLOUDSDK_ACTIVE_CONFIG_NAME: default # required
---
```

## Kit Modules

> A kit module is a standard terraform module implementing lightweight conventions that
> enable collie's tooling.

Kit modules must be stored in the `/kit` path of the [collie repository](repository.md), e.g.
`/kit/aws/my-module/`. The `id` of the module is its path relative to the `kit/` folder, e.g. `aws/my-module` in the
given example.

A kit module must have a `README.md` file that contains module documentation and structured metadata in YAML frontmatter.

### Kit Module Metadata

The frontmatter must contain two **mandatory** property keys `name` and `summary` describing the module.

```markdown
---
name: My Module name
summary: |
  describe what the module does
compliance: # optional
  - control: framework/control # control id (relative path to the control's .md file without extension)
    statement: |
      describe how this module implements the control
---
# My Module

Your extensive module description here...
```

::: tip
`collie foundation docs` leverages the `name` and `summary` properties to render references to the module in the documentation
of platforms that apply this module.
:::

#### Compliance Statements

Kit modules can also have **optional** additional [compliance statements](../concept/compliance.md#compliance-statements). Compliance statements document how a module
implements controls imposed by a [compliance framework](../concept/compliance.md#compliance-frameworks).

A compliance statement must have these properties

- `control` references the `id` of the compliance control. The id is the path to the control configuration file relative to the `compliance/ directory` without the `.md` extension
- `statement` is a human-readable text that describes how the kit module implements the compliance control

### Terraform Module

A kit module is a standard terraform module that adheres to the following conventions.

#### Documentation Output

The terraform module has an `output "documentation_md"` which is read out by collie foundation docs and shown on the module's documentation page generated by `collie foundation docs`. This documentation is inteded for consumption by application teams and security auditors.

#### Module Documentation

You may find it useful to document your kit module's variables and outputs for yourself and fellow platform engineers who are
applying the kit module to their platforms. Modules published here on [collie hub](../modules/README.md) always come
with this documentation.

To do document your kit module, simply set a standard terraform `description` on your variables and outputs like so.

```hcl
variable "aws_root_account_id" {
  type        = string
  description = "The id of your AWS Organization's root account"
}
```

::: tip
`collie kit compile` will attempt to generate this documentation using `terraform-docs` and appends this to the kit module's
`README.md`.
:::

## Platform Modules

A platform module is a terraform configuration that applies a [kit module](#kit-modules) to a cloud platform with a particular set of inputs. Collie uses terragrunt to build and invoke that terraform configuration.

Platform modules consist of just a `terragrunt.hcl` file referencing a kit module like so

```hcl
terraform {
  source = "${get_repo_root()}//kit/aws/bootstrap"
}
```

To create a platform module, use the `collie kit apply` command.

### Platform Module Metadata

As an exception to other collie repository configuration objects, platform modules do not need a `README.md` with custom
to be recognized by collie.

## Compliance Controls

[Compliance controls](../concept/compliance.md#controls) are stored in the `compliance/` directory of your collie repository as individual markdown files.

Collie expects that your controls are grouped into a `framework` folder, e.g. `iso27001`.

A framework should have a  top-level `README.md` and can have an arbitrary number of `.md` files, each describing one control.
 You can optionally further structure your controls using directories beneath the `framework` level.

```shellsession
$ tree compliance
compliance
├── README.md
└── iso27001
    ├── README.md
    ├── a9.1
    │   ├── a9.1.1-access-control-policy.md
...
```


### Compliance Control Metadata

Compliance controls must have a `name` and `summary` property and can optionally contain a `link` for linking to an extended description of the control. The rest of the markdown file can contain additional text, which will be included in documentation generated from `collie foundation docs`. Here's an example:

```md
---
name: A.9.1.1 Access Control Policy
summary: >-
  An access control policy must be established, documented and reviewed regularly taking into account the requirements of the business
for the assets in scope.
---

# A.9.1.1 Access Control Policy

The access control policy defines who has permission to use various data with those allowed to access information still limited to how much they can obtain depending on their user profile with only specific roles having exposure to confidential files.

...
```
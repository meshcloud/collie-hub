# Construction Kit Repository

A landing zone construction kit is always stored in a git (or other VCS) repository.
This repository contains infrastructure as code and configuration files enabling a well-structured, opinionated workflow.
The [collie](https://github.com/meshcloud/collie-cli) cli tool understands this structure and helps you work with it.

The top-level of this hierarchy contains these folders:

- `foundations/` stores [foundations](foundation.md) defining a set of cloud platforms and their configuration
- `kit/` stores [kit modules](kit-module.md) to assemble landing zones on your foundations' cloud platforms
- `compliance/` stores [compliance controls](compliance.md) that your kit modules implement

## Configuration Objects

Configuration objects are stored in this repository directory hierarchy in the form of "literate" config files -
markdown config files with YAML frontmatter.
Most configuration files in a collie repository are `README.md` sitting at the root of their respective folder
hierarchy. A markdown file with frontmatter generally looks like this:

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

A foundation generally has the following folder structure

```sh
foundations/my-foundation/
├── README.md                         # the foundation configuration file
└── platforms
    ├── my-cloud-platform
    │   ├── README.md                 # the platform configuration file
    │   ├── admin                     # platform modules to configure the landing zone (administrative workload)
    │   │   └── tenant                # the admin/tenant platform module, 
    │   │       ├── output.md           # documentation output rendered by the kit module
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

### Platforms
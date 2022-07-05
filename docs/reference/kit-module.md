# Kit Module

> A kit module is a standard terraform module implementing lightweight conventions that
> enable construction kit tooling.

Kit modules must be stored in the `/kit` path of the construction kit [repository](repository.md), e.g.
`/kit/aws/my-module/`. The `id` of the module is its path relative to the `kit/` folder, e.g. `aws/my-module` in the
given example.

At a minimum, a kit module must consist of a terraform module `main.tf` and `README.md` file
meeting the following conventions.

## Module README.md

The readme contains module documentation and structured kit module metadata in YAML frontmatter. The frontmatter must contain two **mandatory** property keys `name` and `summary` describing each module:

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

### Compliance Statements

Kit modules can also have **optional** additional `compliance` statements. Compliance statements document how a module
implence controls imposed by the foundation's compliance frameworks. See [compliance](/compliance) for more details.

A compliance statement must have these properties

- `control` references the `id` of the compliance control. The id is the path to the control configuration file relative to the `compliance/ directory` without the `.md` extension
- `statement` is a human-readable text that describes how the kit module implements the compliance control

## Terraform Module

A kit module is a standard terraform module that adheres to the following conventions.

### Documentation Output

The terraform module has

- an input variable `output_md_file` describing the path where the module will render a markdown file documenting
  its configuration in a human-readable form for landing zone stakeholders
- a `resource local_file "output_md"` that writes to the path specified by `output_md_file`

### Module Documentation

The terraform module should document all it's variables and outputs. This means that every variable should have a
`description` field:

```hcl
variable "aws_root_account_id" {
  type        = string
  description = "The id of your AWS Organization's root account"
}
```

::: tip
`collie foundation docs` will attempt to generate this documentation using `terraform-docs` and appends this to the kit module's
`README.md`.
:::

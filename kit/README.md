# Kit Overview

The kit contains infrastructure as code modules to flexibly build cloud foundation implementations for various cloud platforms.

## Kit Modules

A kit module comprises the following components

- a terraform module `main.tf`
- a `README.md` file containing module documentation and structured kit module metadata in YAML frontmatter

The frontmatter must contain two mandatory property keys describing each module:

```markdown
---
name: My Module name
summary: |
  describe what the module does
compliance: 
  - control: compliance/framework/control # control id (relative path to the control's .md file without extension)
    statement: |
      describe how this module implements the control
---
# My Module

Your extensive module description here...
```

The documentation generator leverages the **mandatory** `name` and `summary` properties to render references to the module in the documentation
of platforms that apply this module.

Kit modules can also have **optional** additional compliance statements. Compliance statements document how a module
implence controls imposed by the foundation's compliance frameworks. See [compliance](/compliance) for more details.
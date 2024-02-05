# Managing Compliance

This guide will show you how to track [compliance controls](../concept/compliance.md) and their implementation in your landing zones.

Compliance controls managed via the `collie compliance` commands provide a structured way to track compliance on the
architecture-level and include the relevant information in the [documentation](./how-to-document.md) of your
kit modules and platforms.

## Creating a compliance control

In order to track compliance controls with collie, we first have to store them in our [collie repository](../reference/repository.md#compliance-controls).

The easiest way to do so is to use `collie compliance new`. Let's create a control from the ISO27001 framework.

```shellsession
$ collie compliance new iso27001/a9.1.1-access-control-policy
 ? Choose a human-friendly name for this control › Access Control Policy

generated new control at compliance/iso27001/a9.1.1-access-control-policy.md
```

You can of course open the generated file to fill in further details like a summary and description of the control. This information will be included in documentation generated from `collie foundation docs`.

::: tip
You can also import community-maintained compliance control frameworks from collie hub using the `collie compliance import` command.
:::

## Creating a compliance statement

The next step is to declare how your [kit modules](../reference/repository.md#kit-modules) implement compliance controls by writing a [compliance statement](../reference/repository.md#compliance-statements) into the kit module's `README.md` file.

Each `statement` should provide a succinct description of how the kit module implements the compliance control.

```markdown
---
name: Privileged Access Management
summary: |
  Configures access for the cloud foundation team's platform engineers.
compliance:
  - control: iso27001/a9.1.1-access-control-policy
    statement: |
      Restrict access to shared services subscriptions to selected administrators on a need-to-know principle.
---

...
```

It's very useful to describe further implementation details for compliance controls in the `documentation_md` output generated from your kit modules. Please refer to the [Documenting Kit Modules](./how-to-document.md) guide for more details.

Most landing zone implementations will need to leverage a mix of technical and administrative measures to effectively implement compliance controls. We recommend you therefore include both of these descriptions in your kit modules.

:::tip
Leveraging collie's capability to include data from terraform resources in your documentation is very powerful for documenting technical controls while automatically ensuring documentation stays up to date.
:::

## Visualizing the compliance tree

Platforms that apply a kit module (using a [platform module](../reference/repository.md#platform-modules)) will inherit the compliance statements included from those kit modules. You can visualize this dependency tree using `collie compliance tree`.

This command is useful to determine coverage of compliance controls in your landing zones.


```shellsession
$ collie compliance tree
└─ iso27001
   └─ a9.1.1-access-control-policy: compliance/iso27001/a9.1.1-access-control-policy.md
      ├─ name: Access Control Policy
      ├─ modules
      │  └─ 0: kit/azure/pam
      └─ platforms
         └─ 0: foundations/f/platforms/az
```

You can of course also run `collie foundation tree` to figure out which controls your platforms implement

```shelsession
collie foundation tree
└─ foundations
   └─ f
      └─ platforms
         └─ az
            ├─ bootstrap: foundations/f/platforms/az/bootstrap/terragrunt.hcl
            │  ├─ kitModule: azure/bootstrap
            │  └─ controls
            └─ pam: foundations/f/platforms/az/pam/terragrunt.hcl
               ├─ kitModule: azure/pam
               └─ controls
                  └─ 0: iso27001/a9.1.1-access-control-policy
```
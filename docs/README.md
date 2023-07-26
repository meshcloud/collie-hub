---
home: true
title: Collie Hub
heroImage: /images/hero.png
actions:
  - text: Get Started
    link: /tutorial/
    type: primary
  - text: Explore Modules
    link: /modules/
    type: secondary
features:
  - title: Modular Approach
    details: Assemble landing zones from capability-focused building blocks.
  - title: GitOps-Enabled
    details: Manage landing zones and cloud tenants as code in git and automate workflows with GitOps.
  - title: Multi-Cloud Workflow
    details: Develop and deploy landing zones with a consistent workflow across multiple cloud platforms.
  - title: Terraform Modules
    details: Leverage a familiar workflow as well as existing infrastructure as code modules.
  - title: Compliance Built-In
    details: Capture compliance requirements for your landing zones and document their implementation as policies.
  - title: Documentation
    details: Document landing zone capabilities for application teams and collaborate with security auditors.

footer: Copyright © 2023-present meshcloud GmbH
---

## Build Landing Zones easily

Use [collie cli](https://github.com/meshcloud/collie-cli) to easily work with cloud landing zones

```shell
# initialize a new collie repository
collie init

# add a cloud foundation connecting your platforms
collie foundation new "my-foundation"

# import a read-to-use infrastructure as code module implemeneting
# landing zone best practices
collie kit import "azure/organization-hierarchy"   

# apply the kit module to one of your cloud foundation's platforms
collie kit apply "azure/organization-hierarchy"  

# deploy all modules applied to the foundation to build your landing zone
collie foundation deploy "my-foundation" 
```

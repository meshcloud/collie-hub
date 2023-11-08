---
name: Buildingblocks-azure-standard-vnet-config
summary: |
  Prepares the infrastructure to create a new building block definition for "Azure Standard Virtual Network".
---

# Buildingblocks azure virtual network configuration

Using this module, you can either create a new or use an existing **Service Principal** and **Storage Account** for creating a buildingblock definition inside the meshStack.

## How to use
- a "backend.tf" and a "provider.tf" will be generated as an output of this module which then you can drop them as an encrypted input inside your buildingblock definition.
<!-- BEGIN_TF_DOCS -->
backend_tf_config_path      = ""
deployment_scope            = ""
provider_tf_config_path     = ""
storage_account_resource_id = ""
<!-- END_TF_DOCS -->
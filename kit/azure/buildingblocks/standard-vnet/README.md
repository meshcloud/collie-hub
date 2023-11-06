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
create_new_spn              = ""
create_new_storageaccount   = ""
existing_storage_account_id = ""
new_resource_group_name     = ""
spn_suffix                  = ""
<!-- END_TF_DOCS -->
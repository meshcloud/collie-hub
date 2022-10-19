# Place your module's terraform resources here as usual.
# Note that you should typically not put a terraform{} block into cloud foundation kit modules,
# these will be provided by the platform implementations using this kit module.

data "azurerm_management_group" "root" {
  name = var.root_parent_id
}

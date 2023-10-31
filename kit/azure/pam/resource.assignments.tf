# # Set permissions for billing admins
# resource "azurerm_role_assignment" "billing_admins" {
#   role_definition_name = "Cost Management Contributor"
#   principal_id         = azuread_group.billing_admins.object_id
#   scope                = data.azurerm_management_group.root.id
# }
#
# # Set permissions for billing reader
# resource "azurerm_role_assignment" "billing_readers" {
#   role_definition_name = "Cost Management Reader"
#   principal_id         = azuread_group.billing_readers.object_id
#   scope                = data.azurerm_management_group.root.id
# }

# Set permissions for security auditors
# resource "azurerm_role_assignment" "security_auditors" {
#   role_definition_name = "Log Analytics Contributor"
#   principal_id         = azuread_group.security_auditors.object_id
#   scope                = data.azurerm_management_group.root.id
# }

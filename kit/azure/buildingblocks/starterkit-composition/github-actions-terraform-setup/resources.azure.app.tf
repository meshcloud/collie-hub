resource "azurerm_resource_group" "app" {
  depends_on = [time_sleep.wait]

  name     = "app"
  location = var.location
}

# WARNING: this shows _one_ way of setting up permissions for the github pipeline by confining it to a single resource
# group. We deliberately allow every action in that resource group because we want to encourage application teams to
# experiment with deploying different resources via the pipeline.
#
# Application teams using this starter kit as a "fork and own" template for setting up their own pipelines for
# proper application development (including production use) should use more specific permissions.
# See https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/secure/best-practices/secure-devops for a good
# overview to customize to your individual needs.
resource "azurerm_role_definition" "ghactions" {
  name              = "${data.azurerm_subscription.current.id}-github-action-deployment"
  description       = "Permissions for the ${azurerm_user_assigned_identity.ghactions.name} UAMI to create/modify/delete resources in this resource group"
  scope             = azurerm_resource_group.app.id
  assignable_scopes = [azurerm_resource_group.app.id]

  permissions {
    actions = [
      "*"
    ]
    not_actions = []
  }
}

resource "azurerm_role_assignment" "ghactions_app" {
  role_definition_id = azurerm_role_definition.ghactions.role_definition_resource_id
  scope              = azurerm_resource_group.app.id
  principal_id       = azurerm_user_assigned_identity.ghactions.principal_id
}

resource "azurerm_role_definition" "ghactions_register" {
  name              = "${data.azurerm_subscription.current.id}-github-action-register"
  description       = "Permissions for the ${azurerm_user_assigned_identity.ghactions.name} UAMI to register providers"
  scope             = data.azurerm_subscription.current.id
  assignable_scopes = [data.azurerm_subscription.current.id]

  permissions {
    actions = [
      "*/register/action"
    ]
    not_actions = []
  }
}

resource "azurerm_role_assignment" "ghactions_register" {
  role_definition_id = azurerm_role_definition.ghactions_register.role_definition_resource_id
  scope              = data.azurerm_subscription.current.id
  principal_id       = azurerm_user_assigned_identity.ghactions.principal_id
}

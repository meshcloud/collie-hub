data "azurerm_subscription" "current" {
}

# workaround for https://github.com/hashicorp/terraform-provider-azurerm/issues/23014
resource "terraform_data" "subscription_name" {
  provisioner "local-exec" {
    when    = create
    command = "az account subscription rename --id ${data.azurerm_subscription.current.subscription_id} --name ${var.subscription_name}"
  }
}


// control placement in the LZ hierarchy
resource "azurerm_management_group_subscription_association" "lz" {
  management_group_id = var.parent_management_group
  subscription_id     = data.azurerm_subscription.current.id
}

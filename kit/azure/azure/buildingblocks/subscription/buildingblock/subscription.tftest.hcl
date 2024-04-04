run "verify" {
  # we only test terraform plan here - it's unfortunately very slow to execute the test otherwise and the azurerm
  # provider likes to complain if alias and management group association already exist
  command = plan

  assert {
    condition = (
      azurerm_management_group_subscription_association.lz.management_group_id == var.parent_management_group
    )
    error_message = "did not create correct management group association"
  }
}
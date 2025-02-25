run "verify" {
  # we only test terraform plan here - it's unfortunately very slow to execute the test otherwise and the azurerm
  # provider likes to complain if alias and management group association already exist
  command = apply

  assert {
    condition     = length(azurerm_role_assignment.uam) == 1
    error_message = "did not create correct number of role assignments"
  }
}
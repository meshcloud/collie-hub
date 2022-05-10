// Helper module to define a policy as json code, which is much more ergonomic than managing it via inline terraform json

variable "policy_json_file" {
  type        = string
  description = "location of a policy.json file describing this policy (Azure Portal compatible JSON)"
}

variable "policy_name" {
  type        = string
  description = "policy name"
}

variable "policy_management_group_id" {
  // note: we're opinionated and always store policies at the MG level, so we make this var required
  type        = string
  description = "management group id where this policy shall be stored"
}

locals {
  policy_json = jsondecode(file(var.policy_json_file)).properties
}

resource "azurerm_policy_definition" "policy" {
  name         = var.policy_name
  policy_type  = local.policy_json.policyType
  mode         = local.policy_json.mode
  display_name = "acceptance test policy definition"

  management_group_id = var.policy_management_group_id

  metadata    = jsonencode(local.policy_json.metadata)
  policy_rule = jsonencode(local.policy_json.policyRule)
  parameters  = jsonencode(local.policy_json.parameters)

}

output "policy" {
  value = azurerm_policy_definition.policy
}

locals {
  policy_definition_files = fileset(var.policy_path, "policy_definitions/*.json")

  policy_definition_objects = { for f in local.policy_definition_files :
    f => jsondecode(file("${var.policy_path}/${f}"))
  }

  policy_definitions = { for f, p in local.policy_definition_objects :
    f => {
      #related to policies only
      policy_name = p.name
      policy_rule = try(p.properties.policyRule, null)
      mode        = try(p.properties.mode, "All")

      # used local library attributes
      display_name = try(p.properties.displayName, null)
      description  = try(p.properties.description, null)

      metadata = try(p.properties.metadata, {})

      parameters = try(p.properties.parameters, null)
      version    = try(p.properties.metadata.version, "1.0.0")
      category   = try(p.properties.metadata.category, "General")
    }
  }
}

resource "azurerm_policy_definition" "enterprise_scale" {
  for_each = local.policy_definitions

  name         = each.value.policy_name
  display_name = each.value.display_name
  description  = each.value.description
  policy_type  = "Custom"
  mode         = each.value.mode

  management_group_id = var.management_group_id

  metadata    = jsonencode(each.value.metadata)
  parameters  = length(each.value.parameters) > 0 ? jsonencode(each.value.parameters) : null
  policy_rule = jsonencode(each.value.policy_rule)

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    read = "10m"
  }
}

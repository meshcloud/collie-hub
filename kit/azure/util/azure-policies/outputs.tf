# we use the actual resource to generate outputs as this is what's actually deployed on Azure after all templating
# and interpolating is fully applied

# We expose a subset of interesting data as this is mostly used to generate documentation.

# Why jsondecode(paremeters)?
# For whatever reason azurerm really likes encoded json strings for parameters, which are a PITA to work with
# so we just decode them back to HCL

output "policy_definitions" {
  value = { for k, v in azurerm_policy_definition.enterprise_scale :
    v.name => {
      name         = v.name,
      display_name = v.display_name,
      description  = v.description,
      parameters   = jsondecode(coalesce(v.parameters, "{}"))
    }
  }
}

output "policy_sets" {
  value = { for k, v in azurerm_policy_set_definition.enterprise_scale :
    v.name => {
      name         = v.name,
      display_name = v.display_name,
      description  = v.description,
      parameters   = jsondecode(coalesce(v.parameters, "{}"))
    }
  }
}

output "policy_assignments" {
  value = { for k, v in azurerm_management_group_policy_assignment.enterprise_scale :
    v.name => {
      id           = v.id,
      name         = v.name,
      display_name = v.display_name,
      description  = v.description,
      identity     = v.identity,
      not_scopes   = v.not_scopes
      enforce      = v.enforce,
      parameters   = jsondecode(coalesce(v.parameters, "{}"))
    }
  }
}

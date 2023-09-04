
locals {
  # policy sets need some lightweight templating to make sure they can reference the right definition ids, scopes etc.
  # this is why we store them as tmpl.jsons and run them trough templatefile
  policy_set_files = fileset(var.policy_path, "policy_sets/*.tmpl.json")
  policy_set_objects = { for f in local.policy_set_files :
    f => jsondecode(templatefile("${var.policy_path}/${f}", var.template_file_variables))
  }

  policy_sets = { for f, p in local.policy_set_objects :
    f => {
      name         = p.name,
      display_name = try(p.properties.displayName, null)
      description  = try(p.properties.description, null)

      metadata   = try(p.properties.metadata, {})
      parameters = try(p.properties.parameters, null)

      # these may be null in the source, so we coalesce to empty lists which allows easy iterating over them
      # we can't use coalesce though 
      policyDefinitions = coalesce(
        try(
          [for item in p.properties.policyDefinitions : {
            policyDefinitionId          = item.policyDefinitionId
            parameters                  = try(jsonencode(item.parameters), null)
            policyDefinitionReferenceId = try(item.policyDefinitionReferenceId, null)
            groupNames                  = try(item.groupNames, null)
          }],
          []
        ),
        []
      )
      policyDefinitionGroups = coalesce(
        try(
          [for item in p.properties.policyDefinitionGroups : {
            name                 = item.name
            displayName          = try(item.displayName, null)
            description          = try(item.description, null)
            category             = try(item.category, null)
            additionalMetadataId = try(item.additionalMetadataId, null)
          } if item.name != null && item.name != ""],
          []
        ),
        []
      )
    }
  }
}

resource "azurerm_policy_set_definition" "enterprise_scale" {
  for_each = local.policy_sets

  # Mandatory resource attributes
  name         = each.value.name
  display_name = each.value.display_name
  description  = each.value.description
  policy_type  = "Custom"

  management_group_id = var.management_group_id

  metadata   = jsonencode(each.value.metadata)
  parameters = length(each.value.parameters) > 0 ? jsonencode(each.value.parameters) : null

  # Dynamic configuration blocks
  dynamic "policy_definition_reference" {
    for_each = each.value.policyDefinitions
    content {
      policy_definition_id = policy_definition_reference.value["policyDefinitionId"]
      parameter_values     = policy_definition_reference.value["parameters"]
      reference_id         = policy_definition_reference.value["policyDefinitionReferenceId"]
      policy_group_names   = policy_definition_reference.value["groupNames"]
    }
  }
  dynamic "policy_definition_group" {
    for_each = each.value.policyDefinitionGroups
    content {
      name                            = policy_definition_group.value["name"]
      display_name                    = policy_definition_group.value["displayName"]
      category                        = policy_definition_group.value["category"]
      description                     = policy_definition_group.value["description"]
      additional_metadata_resource_id = policy_definition_group.value["additionalMetadataId"]
    }
  }

  # deploy policy_sets after policy_definitions
  depends_on = [
    azurerm_policy_definition.enterprise_scale
  ]
}

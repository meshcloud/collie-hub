output "documentation_md" {
  value = <<EOF
  This documentation is intended as a summary of resources deployed and managed by this module for landing zone consumers
  and security auditors.

  ### TODO

  TODO: describe the deployed resources and its configuration in a human-friendly way.

  ::: tip
  Here are some useful tips

  - This file is proper `markdown`.
  - Use h3 and h4 level headings to add sections to the kit module description
  - You can use terraform variables, resources and outputs defined anywhere in this terraform module, to templatise it,
    e.g. this is the AAD that the module is being used in: `${var.aadTenantId}`
  - Leverage terraform's `templatefile()` function for more complex templates
  :::
  EOF
  }
  
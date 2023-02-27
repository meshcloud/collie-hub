variable "output_md_file" {
    type        = string
    description = "location of the file where this cloud foundation kit module generates its documentation output"
  }

  resource "local_file" "output_md" {
    filename = var.output_md_file
    content = <<EOF
  This documentation is intended as a summary of resources deployed and managed by this module for landing zone consumers
  and security auditors.

  ### TODO

  TODO: describe the deployed resources and its configuration in a human-friendly way.

  ::: tip
  Here are some useful tips

  - This file is proper `markdown`.
  - Use h3 and h4 level headings to add sections to the kit module description
  - You can use terraform variables, resources and outputs defined anywhere in this terraform module, to templatise it,
    e.g. this is the location where this documentation comes from: `${var.output_md_file}`
  - Leverage terraform's `templatefile()` function for more complex templates
  :::
  EOF
  }
  
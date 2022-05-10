variable "output_md_file" {
  type        = string
  description = "location of the file where this cloud foundation kit module generates its documentation output"
}

resource "local_file" "output_md" {
  filename = var.output_md_file
  # tip: 
  # pro-tip: you can 
  content = <<EOF
### Domain Restricted Sharing

::: tip Domain Restricted Sharing
[Domain Restricted Sharing](https://cloud.google.com/resource-manager/docs/organization-policy/restricting-domains) restricts the set of identities that are allowed to be used in Identity and Access Management policies.
This prevents access to resources in this organization by any foreign identities.
::: 

Note that this setting will prevent using public access (e.g. on GCS buckets) by default as well.

The allowed domains are

${join("\n", formatlist("- %s (Customer Id `%s`)", local.resolved_customer_ids_to_allow[*].domain, local.resolved_customer_ids_to_allow[*].customer_id))}

### Resource Locations

::: tip Resource Locations
[Resource Locations](https://cloud.google.com/resource-manager/docs/organization-policy/defining-locations) restrics deployment of resources to whitelisted regions.
This prevents deployment of resources outside of approved locations.
::: 

The allowed resource locations are

${join("\n", formatlist("- `%s`", var.resource_locations_to_allow))}

EOF
}


# note: to resolve the domains properly, we need the roles/resourcemanager.organizationViewer
# on the domain, see https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization
# because this is not always possible, we support 

variable "domains_to_allow" {
  description = "The list of domains to allow users from. This list is concatenated to customer_ids_to_allow"
  type        = list(string)
}

variable "customer_ids_to_allow" {
  description = "The list of Google Customer Ids to allow users from."
  type = list(object(
    {
      domain      = string
      customer_id = string
    }
  ))
  default = []
}

variable "resource_locations_to_allow" {
  type        = list(string)
  description = "The list of resource locations to allow"
}

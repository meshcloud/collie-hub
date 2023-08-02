variable "management_group_id" {
  description = "Scope for location restriction."
}

variable "allowed_locations" {
  description = "Whitelist of locations. List of all available locations: `az account list-locations -o table`"
  type = list(string)
}

variable "create_new_spn" {
  type        = number
  description = "If you already have an SPN for deployment of Building block in you environment insert '1', otherwise insert '0' so a new one will be created"
  validation {
    condition     = var.create_new_spn == 1 || var.create_new_spn == 0
    error_message = "create_new_spn variable must be either 0 or 1."
  }
}
variable "spn_suffix" {
  type        = string
  description = "suffix for the SPN's name. The format is 'building_blocks.<SUFFIX>'"
  default     = null
}
module "new_spn" {
  count            = var.create_new_spn == 0 ? 1 : 0
  source           = "./module-new-service-principal"
  spn_suffix       = "module-new-spn"
  deployment_scope = "/providers/Microsoft.Management/managementGroups/likvid"
}

module "existing_spn" {
  count                   = var.create_new_spn == 1 ? 1 : 0
  source                  = "./module-exisiting-service-principal"
  existing_application_id = "be398b24-374f-415c-905f-b49814435dd1"
}

output "provider_existing_spn" {
  description = "Please run 'terraform output provider_existing_spn' to export the provider configuration using the existing service principal"
  value       = module.existing_spn
  sensitive   = true
}

output "provider_new_spn" {
  description = "Please run 'terraform output provider_new_spn' to export the provider configuration using this new service principal"
  value       = module.new_spn
  sensitive   = true
}

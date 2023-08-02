variable "management_group_id" {
  description = "Scope for location restriction."
}

variable "resource_types_not_allowed" {
  description = "Blacklist of resource types.  Resource types are namespaces with their resource provider like Microsoft.compute/VirtualMachine. See Azure docs for more information on providers and types https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types"
  type = list(string)
}

# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-default"
}
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}


# Web Subnet Name
variable "vm_subnet_name" {
  description = "Virtual Network VM Subnet Name"
  type = string
  default = "websubnet"
}
# Web Subnet Address Space
variable "vm_subnet_address" {
  description = "Virtual Network VM Subnet Address Spaces"
  type = list(string)
  default = ["10.0.1.0/24"]
}


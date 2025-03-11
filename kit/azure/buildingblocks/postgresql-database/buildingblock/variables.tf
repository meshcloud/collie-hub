variable "subscription_id" {
  description = "the Azure subscription id"
  type        = string
}

variable "database_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the database will be created"
  type        = string
}

variable "server_name" {
  description = "The name of the PostgreSQL server"
  type        = string
}

variable "charset" {
  description = "Character set for the database"
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = "Collation for the database"
  type        = string
  default     = "English_United States.1252"
}

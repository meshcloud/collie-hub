variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "West Europe"
}

variable "postgresql_server_name" {
  description = "Name of the PostgreSQL server"
  type        = string
}

variable "administrator_login" {
  description = "Administrator username for PostgreSQL"
  type        = string
  default     = "psqladmin"
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL server"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "postgresql_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "11"
}

variable "storage_mb" {
  description = "Storage size in MB"
  type        = number
  default     = 5120
}

variable "backup_retention_days" {
  description = "Backup retention in days"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups"
  type        = bool
  default     = false
}

variable "auto_grow_enabled" {
  description = "Enable auto-grow for storage"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = false
}

variable "ssl_enforcement_enabled" {
  description = "Enforce SSL connection"
  type        = bool
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "Minimum TLS version"
  type        = string
  default     = "TLS1_2"
}

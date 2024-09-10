variable "platforms" {
  description = "platform configuration required to produce docs"
  type = object({
    azure = object({
      aad_tenant_id   = string
      subscription_id = string
      tfstateconfig = object({
        resource_group_name  = string
        storage_account_name = string
        container_name       = string
      })
    })
  })
}

variable "output_dir" {
  description = "path to the directory where to store the generated documentation output"
  type        = string
}

variable "template_dir" {
  description = "path to the directory containing the docs site template"
  type        = string
}

variable "foundation_dir" {
  description = "path to the collie foundation directory for this foundation"
  type        = string
}

variable "repo_dir" {
  description = "path to the collie repository directory"
  type        = string
}
variable "foundation_project_id" {
  type        = string
  description = "Project ID of the GCP Project hosting foundation-level resources for this foundation"
}

variable "service_account_name" {
  type        = string
  description = "name of the Service Account used to deploy cloud foundation resources"
  default     = "foundation-tf-deploy-user"
}
variable "workspace_identifier" {
  type        = string
  description = "The meshStack workspace identifier."
}

variable "project_identifier" {
  type        = string
  description = "The meshStack project identifier."
}

variable "name" {
  type        = string
  description = "User selected part of the name."

  validation {
    condition     = length(var.name) < 16
    error_message = "Name must be fewer than 16 characters long."
  }

  validation {
    condition     = length(regexall("^[0-9a-z]+$", var.name)) > 0
    error_message = "Name must only contain lowercase letters and numbers."
  }
}

variable "namespace" {
  description = "Associated namespace in AKS."
  type        = string
}

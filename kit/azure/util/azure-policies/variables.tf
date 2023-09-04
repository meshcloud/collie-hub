variable "management_group_id" {
  type        = string
  description = "The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created."
}

variable "policy_path" {
  type        = string
  description = "path of the json policies, sets or assignments"
}

variable "location" {
  type        = string
  description = "location for the policy assignment"
}

variable "template_file_variables" {
  type        = map(string)
  description = "variables for *.tmpl.json files, expanded with terraform templatefile() function"

}
variable "pam_group_object_ids" {
  description = "the object_ids of PAM groups used by the cloud foundation"
  type        = list(string)
}

variable "pam_group_members" {
  description = "Optional: manage members for cloud foundation PAM groups via terraform"
  type = list(object({
    group_object_id = string

    # other attributes would be possible (e.g. UPN or mail_nickname) with small changes to the terraform module
    members_by_mail = list(string)
  }))
}

variable "workspace_id" {
  type        = string
  description = "Projects first block in name"
}

variable "project_id" {
  type        = string
  description = "Projects last block in name"
}

variable "aws_account_id" {
  description = "this is for the tfstates Backend. in our case AWS."
  type        = string
}

variable "users" {
  type = list(object(
    {
      meshIdentifier = string
      username       = string
      firstName      = string
      lastName       = string
      email          = string
      euid           = string
      roles          = list(string)
    }
  ))
  description = "Users and their roles provided by meshStack (Note that users must exist in stackit)"
}

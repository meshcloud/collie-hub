variable "platform_admins" {
  type = list(object({
    email = string
  }))
}

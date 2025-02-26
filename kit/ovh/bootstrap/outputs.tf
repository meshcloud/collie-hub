output "user_passwords" {
  value     = { for k, v in random_password.user_passwords : k => v.result }
  sensitive = true
}

output "platform_users" {
  value = { for k, v in ovh_me_identity_user.platform_users : k => v.login }
}

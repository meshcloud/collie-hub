variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
  sensitive   = true
}

variable "key_vault_rg" {
  type        = string
  description = "Name of the Resource Group where the Key Vault is located"
  sensitive   = true

}

variable "github_token_secret_name" {
  type        = string
  description = "Name of the secret in Key Vault that holds the GitHub token"
  sensitive   = true

}

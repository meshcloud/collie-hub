# note: this building block is expected to be executed with a config.tf file as output by the "backplane" module in the
# parent dir, this needs to provided in the BB execution enviornment

data "github_repository" "repository" {
  name = var.repo_name
}

# In theory these settings could also be copied from the template repository, however it's unclear whether this is
# supported for every setting we care about. Having them in the BB instead of the backplane has the following benefits
# - we can decide to upgrade these rules on existing repos with a BB definition version upgrade
# - we have important concepts like the sandbox environment available for cross-referencing in other resources and don't
#   need "magic constants" here

resource "github_repository_environment" "sandbox" {
  environment = "sandbox"
  repository  = data.github_repository.repository.name

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

# we currently don't set up a separate prod/non-prod enviornment on GitHub as that would require giving the UAMI
# two sets of permissions as well - this would be great for production use cases but complicates this starter kit
# Azure/static-web-apps-deploy@v1 implements proper staging for PR previews
resource "github_repository_environment_deployment_policy" "sandbox_all" {
  repository     = data.github_repository.repository.name
  environment    = github_repository_environment.sandbox.environment
  branch_pattern = "*"
}


#
# Files
#


#
# add pipeline file to repo
#

locals {
  commit_author = "DevOps Toolchain Team"
  commit_email  = "devopstoolchain@likvid-bank.com"
}

resource "github_repository_file" "provider_tf" {
  depends_on = [
    github_repository_file.backend_tf
  ] # Only commit the provider.tf file after the backend.tf file has been committed to avoid unmanaged resources

  repository     = data.github_repository.repository.name
  commit_message = "Configuring azurerm provider to deploy to your subscription"
  commit_author  = local.commit_author
  commit_email   = local.commit_email

  file    = "infra/provider.tf"
  content = <<-EOT
    provider "azurerm" {
      features {}
      resource_provider_registrations = "core"
      tenant_id                       = "${data.azurerm_subscription.current.tenant_id}"
      subscription_id                 = "${data.azurerm_subscription.current.subscription_id}"
      storage_use_azuread             = true
    }

    provider "azuread" {
     tenant_id                  = "${data.azurerm_subscription.current.tenant_id}"
    }
EOT
}

resource "github_repository_file" "backend_tf" {
  depends_on = [
    azurerm_role_assignment.ghaction_tfstate,
    azurerm_role_assignment.ghactions_register,
    azurerm_role_assignment.ghactions_app
  ] # Wait with creating the Repo until the UAMI all the permissions needed to execute the pipeline

  repository     = data.github_repository.repository.name
  commit_message = "Configuring terraform backend to store state in your subscription"
  commit_author  = local.commit_author
  commit_email   = local.commit_email

  file    = "infra/backend.tf"
  content = <<-EOT
    terraform {
      backend "azurerm" {
        use_azuread_auth      = true
        tenant_id             = "${data.azurerm_subscription.current.tenant_id}"
        subscription_id       = "${data.azurerm_subscription.current.subscription_id}"
        resource_group_name   = "${azurerm_resource_group.cicd.name}"
        storage_account_name  = "${azurerm_storage_account.tfstates.name}"
        container_name        = "${azurerm_storage_container.tfstates.name}"
        key                   = "starterkit.tfstate"
      }
    }
EOT
}

# pass the UAMI client id as a secret, not because it's secret, but because this allows us to have an easy interface with
# template repositories (we can keep workflow files in the template repos and don't need to generate them via terraform)
resource "github_actions_secret" "arm_client_id" {
  repository      = data.github_repository.repository.name
  secret_name     = "ARM_CLIENT_ID"
  plaintext_value = azurerm_user_assigned_identity.ghactions.client_id
}

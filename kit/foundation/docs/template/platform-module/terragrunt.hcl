terraform {
  source = "${get_repo_root()}//kit/foundation/docs"
}

# note: we don't track any state for this module itself

locals {
  foundation_path = "${get_repo_root()}/foundations/name-of-foundation" #TODO: replace with the name of the foundation
  azure_platform  = read_terragrunt_config("${local.foundation_path}/platforms/azure/platform.hcl")
}

inputs = {
  # todo: refactor to eliminate duplication of this value
  # azure_tfstate_config_path = "${local.foundation_path}/platforms/azure/tfstates-config.yaml"

  platforms = {
    azure = {
      aad_tenant_id   = local.azure_platform.locals.platform.azure.aadTenantId,
      subscription_id = local.azure_platform.locals.platform.azure.subscriptionId,
      tfstateconfig   = local.azure_platform.locals.tfstateconfig
    }
  }

  foundation_dir = "${local.foundation_path}"
  template_dir   = "${local.foundation_path}/docs/vuepress"
  output_dir     = "${local.foundation_path}/.docs-v2"
  repo_dir       = "${get_repo_root()}"
}

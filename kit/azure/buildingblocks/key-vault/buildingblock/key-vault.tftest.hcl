# terraform test is cool because it does the apply and destroy lifecycle
# what it doesn't test though is the backend storage. if we want to test that, we need to that via terragrunt

run "verify" {
  variables {
    key_vault_resource_group_name = "kv-rg"
    key_vault_name                = "kv-integrationtest"
    location                      = "westeurope"
    users                         = "likvid-anna@meshcloud.io"
  }
}

# terraform test is cool because it does the apply and destroy lifecycle
# what it doesn't test though is the backend storage. if we want to test that, we need to that via terragrunt

run "verify" {
  variables {
    key_vault_resource_group_name = "kv-rg"
    key_vault_name                = "kv-integrationtest"
    location                      = "westeurope"
    users = [
      {
        meshIdentifier = "identifier0"
        username       = "likvid-daniela@meshcloud.io"
        firstName      = "likvid"
        lastName       = "daniela"
        email          = "likvid-daniela@meshcloud.io"
        euid           = "likvid-daniela@meshcloud.io"
        roles          = ["reader"]
      },
      {
        meshIdentifier = "identifier1"
        username       = "likvid-tom@meshcloud.io"
        firstName      = "likvid"
        lastName       = "tom"
        email          = "likvid-tom@meshcloud.io"
        euid           = "likvid-tom@meshcloud.io"
        roles          = ["editor"]
      },
      {
        meshIdentifier = "identifier2"
        username       = "likvid-anna@meshcloud.io"
        firstName      = "likvid"
        lastName       = "anna"
        email          = "likvid-anna@meshcloud.io"
        euid           = "likvid-anna@meshcloud.io"
        roles          = ["admin"]
      }
    ]
  }
}

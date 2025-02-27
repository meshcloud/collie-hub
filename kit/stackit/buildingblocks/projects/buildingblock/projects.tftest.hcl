run "verify" {
  variables {
    organization_id     = "05d7eb3f-f875-4bcd-ad0d-a07d62787f21"
    aws_account_id      = "490004649140"
    parent_container_id = "0a4006f8-eaf3-417c-b2fa-7e9c08ebffba"
    workspace_id        = "stackit"
    project_id          = "test"
    users = [
      {
        meshIdentifier = "identifier0"
        username       = "likvid-daniela3@meshcloud.io"
        firstName      = "likvid"
        lastName       = "daniela"
        email          = "likvid-daniela3@meshcloud.io"
        euid           = "likvid-daniela3@meshcloud.io"
        roles          = ["reader"]
      },
      {
        meshIdentifier = "identifier1"
        username       = "likvid-tom@meshcloud.io"
        firstName      = "likvid"
        lastName       = "tom"
        email          = "likvid-tom@meshcloud.io"
        euid           = "likvid-tom@meshcloud.io"
        roles          = ["user"]
      },
      {
        meshIdentifier = "identifier1"
        username       = "likvid-ana@meshcloud.io"
        firstName      = "likvid"
        lastName       = "ana"
        email          = "likvid-ana4@meshcloud.io"
        euid           = "likvid-ana4@meshcloud.io"
        roles          = ["admin"]
      }
    ]
  }

  assert {
    condition     = length(var.users) > 0
    error_message = "No users provided"
  }
}

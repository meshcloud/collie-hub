run "verify" {
  variables {

    aws_account_id = "490004649140"
    workspace_id   = "workspace"
    project_id     = "project"
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

  assert {
    condition     = length(var.users) > 0
    error_message = "No users provided"
  }
}

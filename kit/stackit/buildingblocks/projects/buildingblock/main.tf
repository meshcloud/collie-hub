locals {
  admins      = { for user in var.users : user.username => user if contains(user.roles, "admin") }
  editors     = { for user in var.users : user.username => user if contains(user.roles, "user") }
  readers     = { for user in var.users : user.username => user if contains(user.roles, "reader") }
  owner_email = values(local.admins)[0]["email"]
  all_users = [for user in concat(values(local.admins), values(local.editors), values(local.readers)) :
    { subject = user.email }
  ]

  admin_members  = [for admin in values(local.admins) : { subject = admin["email"], role = "owner" }]
  editor_members = [for editor in values(local.editors) : { subject = editor["email"], role = "editor" }]
  reader_members = [for reader in values(local.readers) : { subject = reader["email"], role = "reader" }]
}

resource "null_resource" "create_user" {
  # Trigger creation and destruction of resources based on the lifecycle
  triggers = {
    members         = jsonencode(local.all_users) # This should be a list of emails
    url             = var.api_url
    token           = var.token
    organization_id = var.organization_id
  }

  # Provisioner for the 'create' action
  provisioner "local-exec" {
    when    = create
    command = <<EOT
# Loop through each user email
for user_email in $(echo '${self.triggers.members}' | jq -r '.[].subject'); do
  # Retrieve all members of the organization
  response=$(curl -s -H "Authorization: Bearer ${self.triggers.token}" "${self.triggers.url}/v2/organization/${self.triggers.organization_id}/members")

  # Check if the user already exists in the response
  user_exists=$(echo "$response" | jq -r ".members[] | select(.subject == \"$user_email\")")

  if [ -z "$user_exists" ]; then
    echo "User $user_email not found, adding them..."
    # Send PATCH request to add the user
    curl -X PATCH "${self.triggers.url}/v2/${self.triggers.organization_id}/members" \
      -H "Authorization: Bearer ${self.triggers.token}" \
      -H "Content-Type: application/json" \
      -d '{
        "members": [{ "subject": "'"$user_email"'", "role": "organization.auditor" }],
        "resourceType": "organization"
      }'

    # Check if the request was successful
    if [ $? -eq 0 ]; then
      echo "User $user_email added successfully!"
    else
      echo "Error occurred while adding user $user_email!"
      exit 1
    fi
  else
    echo "User $user_email already exists, skipping..."
  fi
done
EOT
  }
}

resource "stackit_resourcemanager_project" "projects" {
  parent_container_id = var.parent_container_id
  name                = "${var.workspace_id}-${var.project_id}"
  # labels = {
  #   "Label1" = "foo"
  # }
  owner_email = local.owner_email
  depends_on  = [null_resource.create_user]
}

resource "null_resource" "project_admin" {
  # Trigger creation and destruction of resources based on the lifecycle
  triggers = {
    members    = jsonencode(local.admin_members)
    url        = var.api_url
    token      = var.token
    project_id = stackit_resourcemanager_project.projects.project_id
  }

  # Provisioner for the 'create' action
  provisioner "local-exec" {
    when    = create
    command = <<EOT
curl -X PATCH "${self.triggers.url}/v2/${self.triggers.project_id}/members" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
  "members": ${self.triggers.members},
  "resourceType": "project"
}'
EOT
  }

  # Provisioner for the 'destroy' action
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
curl -X POST "${self.triggers.url}/v2/${self.triggers.project_id}/members/remove" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
 "forceRemove": true,
  "members": ${self.triggers.members},
  "resourceType": "project"
}'
EOT
  }
  depends_on = [resource.stackit_resourcemanager_project.projects]
}

resource "null_resource" "project_editor" {
  # Trigger creation and destruction of resources based on the lifecycle
  triggers = {
    members    = jsonencode(local.editor_members)
    url        = var.api_url
    token      = var.token
    project_id = stackit_resourcemanager_project.projects.project_id
  }

  # Provisioner for the 'create' action
  provisioner "local-exec" {
    when    = create
    command = <<EOT
curl -X PATCH "${self.triggers.url}/v2/${self.triggers.project_id}/members" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
  "members": ${self.triggers.members},
  "resourceType": "project"
}'
EOT
  }

  # Provisioner for the 'destroy' action
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
curl -X POST "${self.triggers.url}/v2/${self.triggers.project_id}/members/remove" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
 "forceRemove": true,
  "members": ${self.triggers.members},
  "resourceType": "project"
}'
EOT
  }

  depends_on = [resource.stackit_resourcemanager_project.projects]
}

resource "null_resource" "project_reader" {
  # Trigger creation and destruction of resources based on the lifecycle
  triggers = {
    members    = jsonencode(local.reader_members)
    url        = var.api_url
    token      = var.token
    project_id = stackit_resourcemanager_project.projects.project_id
  }

  # Provisioner for the 'create' action
  provisioner "local-exec" {
    when    = create
    command = <<EOT
curl -X PATCH "${self.triggers.url}/v2/${self.triggers.project_id}/members" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
  "members": ${self.triggers.members},
  "resourceType": "project"
}'
EOT
  }

  # Provisioner for the 'destroy' action
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
curl -X POST "${self.triggers.url}/v2/${self.triggers.project_id}/members/remove" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
 "forceRemove": true,
  "members": ${self.triggers.members},
  "resourceType": "project"
}'
EOT
  }
  depends_on = [resource.stackit_resourcemanager_project.projects]
}

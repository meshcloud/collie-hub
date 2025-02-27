resource "null_resource" "platform_admin" {

  # Trigger creation and destruction of resources based on the lifecycle
  triggers = {
    members         = jsonencode(var.platform_admins)
    url             = var.api_url
    token           = var.token
    organization_id = var.organization_id
  }

  # Provisioner for the 'create' action
  provisioner "local-exec" {
    when    = create
    command = <<EOT
curl -X PATCH "${self.triggers.url}/v2/${self.triggers.organization_id}/members" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
  "members": ${self.triggers.members},
  "resourceType": "organization"
}'
EOT
  }
  # Provisioner for the 'destroy' action
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
curl -X POST "${self.triggers.url}/v2/${self.triggers.organization_id}/members/remove" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
 "forceRemove": true,
  "members": ${self.triggers.members},
  "resourceType": "organization"
}'
EOT
  }
}

resource "null_resource" "platform_users" {
  # Trigger creation and destruction of resources based on the lifecycle
  triggers = {
    members         = jsonencode(var.platform_users)
    url             = var.api_url
    token           = var.token
    organization_id = var.organization_id
  }

  # Provisioner for the 'create' action
  provisioner "local-exec" {
    when    = create
    command = <<EOT
curl -X PATCH "${self.triggers.url}/v2/${self.triggers.organization_id}/members" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
  "members": ${self.triggers.members},
  "resourceType": "organization"
}'
EOT
  }
  # Provisioner for the 'destroy' action
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
curl -X POST "${self.triggers.url}/v2/${self.triggers.organization_id}/members/remove" \
-H "Authorization: Bearer ${self.triggers.token}" \
-H "Content-Type: application/json" \
-d '{
 "forceRemove": true,
  "members": ${self.triggers.members},
  "resourceType": "organization"
}'
EOT
  }
}

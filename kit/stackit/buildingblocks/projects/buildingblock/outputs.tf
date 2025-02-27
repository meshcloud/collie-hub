output "tenant_id" {
  value = stackit_resourcemanager_project.projects.project_id
}

output "stackit_login_link" {
  value = "https://portal.stackit.cloud/projects/${stackit_resourcemanager_project.projects.project_id}/access"
}

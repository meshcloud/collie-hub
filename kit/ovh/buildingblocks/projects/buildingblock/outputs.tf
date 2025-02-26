output "tenant_id" {
  value = ovh_cloud_project.cloud_project.urn
}

output "ovh_login_link" {
  value = "https://www.ovh.com/manager/#/public-cloud/pci/projects/${ovh_cloud_project.cloud_project.id}"
}

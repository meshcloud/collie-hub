resource "github_repository" "repository" {
  name        = var.repo_name
  description = var.description
  visibility  = var.visibility
}

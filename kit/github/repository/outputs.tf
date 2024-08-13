output "repo_name" {
  value = var.create_new ? github_repository.repository[0].name : var.repo_name
}

output "repo_full_name" {
  value = var.create_new ? github_repository.repository[0].full_name : "${var.github_owner}/${var.repo_name}"
}

output "repo_html_url" {
  value = var.create_new ? github_repository.repository[0].html_url : "https://github.com/${var.github_owner}/${var.repo_name}"
}

output "repo_git_clone_url" {
  value = var.create_new ? github_repository.repository[0].git_clone_url : "https://github.com/${var.github_owner}/${var.repo_name}"
}
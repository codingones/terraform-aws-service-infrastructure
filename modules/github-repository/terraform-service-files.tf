data "http" "service_files_templates" {
  for_each = var.service_files

  url = each.value.url_of_template
}

locals {
  contentMap = { for k, v in data.http.service_files_templates : k => v.response_body }
}

resource "github_repository_file" "service_files" {
  for_each = local.contentMap

  repository          = github_repository.repository.name
  branch              = github_branch_default.main.branch
  file                = each.key
  content             = each.value
  commit_message      = "feat: adding terraform aws service file"
  commit_author       = var.commit_author_name
  commit_email        = var.commit_author_email
  overwrite_on_create = true

  lifecycle {
    ignore_changes = all
  }
}



resource "github_repository_file" "main" {
  repository          = github_repository.repository.name
  branch              = github_branch_default.main.branch
  file                = "main.tf"
  content             = module.main_template.rendered
  commit_message      = "feat: adding terraform aws main file"
  commit_author       = var.commit_author_name
  commit_email        = var.commit_author_email
  overwrite_on_create = true
}

resource "github_repository_file" "variables" {
  repository          = github_repository.repository.name
  branch              = github_branch_default.main.branch
  file                = "variables.tf"
  content             = data.http.variables_template.response_body
  commit_message      = "feat: adding terraform aws variables file"
  commit_author       = var.commit_author_name
  commit_email        = var.commit_author_email
  overwrite_on_create = true
}

resource "github_repository_file" "tags" {
  repository          = github_repository.repository.name
  branch              = github_branch_default.main.branch
  file                = "tags.tf"
  content             = data.http.tags_template.response_body
  commit_message      = "feat: adding terraform aws tags file"
  commit_author       = var.commit_author_name
  commit_email        = var.commit_author_email
  overwrite_on_create = true

  lifecycle {
    ignore_changes = all
  }
}

data "http" "main" {
  url = "https://raw.githubusercontent.com/${var.github_organization}/${var.github_repository}/main/main.tf"
}

data "http" "variables" {
  url = "https://raw.githubusercontent.com/${var.github_organization}/${var.github_repository}/main/variables.tf"
}

data "http" "tags" {
  url = "https://raw.githubusercontent.com/${var.github_organization}/${var.github_repository}/main/tags.tf"
}

module "main_template" {
  source       = "github.com/codingones/terraform-remote-template-renderer"
  template_url = "https://raw.githubusercontent.com/codingones/github-files-templates/main/terraform/main.tf"
  template_variables = {
    TERRAFORM_ORGANIZATION = var.project
    TERRAFORM_WORKSPACE    = var.service
    AWS_PROVIDER_REGION    = "us-east-1"
    PROJECT                = var.project
    SERVICE                = var.service
  }
}

data "http" "variables_template" {
  url = "https://raw.githubusercontent.com/codingones/github-files-templates/main/terraform/service/${var.service}/variables.tf"
}

data "http" "tags_template" {
  url = "https://raw.githubusercontent.com/codingones/github-files-templates/main/terraform/tags.tf"
}


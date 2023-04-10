resource "github_repository_file" "main" {
  repository          = github_repository.repository.name
  branch              = github_branch_default.main.branch
  file                = "main.tf"
  content             = module.templated_main.rendered
  commit_message      = "feat: adding terraform aws main file"
  commit_author       = var.commit_author_name
  commit_email        = var.commit_author_email
  overwrite_on_create = true

  lifecycle {
    ignore_changes = all
  }
}

module "templated_main" {
  source       = "github.com/codingones/terraform-remote-template-renderer"
  template_url = "https://raw.githubusercontent.com/codingones/github-files-templates/main/terraform/main_service_infrastructure.aws.tf"
  template_variables = {
    TERRAFORM_ORGANIZATION = var.project
    TERRAFORM_WORKSPACE    = var.service
    AWS_PROVIDER_REGION    = "us-east-1"
    PROJECT                = var.project
    SERVICE                = var.service
  }
}

resource "github_repository_file" "tags" {
  repository          = github_repository.repository.name
  branch              = github_branch_default.main.branch
  file                = "tags.tf"
  content             = data.http.tags.response_body
  commit_message      = "feat: adding terraform aws tags file"
  commit_author       = var.commit_author_name
  commit_email        = var.commit_author_email
  overwrite_on_create = true

  lifecycle {
    ignore_changes = all
  }
}

data "http" "tags" {
  url = "https://raw.githubusercontent.com/codingones/github-files-templates/main/terraform/tags.aws.tf"
}
resource "github_repository_file" "terraform_apply" {
  repository          = github_repository.repository.name
  branch              = github_branch_default.main.branch
  file                = ".github/workflows/apply.terraform.yml"
  content             = module.templated_workflow.rendered
  commit_message      = "feat: adding terraform apply workflow"
  commit_author       = var.commit_author_name
  commit_email        = var.commit_author_email
  overwrite_on_create = true
}

module "templated_workflow" {
  source       = "github.com/codingones/terraform-remote-template-renderer"
  template_url = "https://raw.githubusercontent.com/codingones/github-files-templates/main/workflows/apply_changes_to_simple_service_infrastructure.terraform.yml"
  template_variables = {
    SERVICE = var.service
  }
}
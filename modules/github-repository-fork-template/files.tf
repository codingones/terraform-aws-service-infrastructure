resource "github_repository_file" "autofork_workflow" {
  repository          = github_repository.repository.name
  branch              = github_branch_default.main.branch
  file                = ".github/workflows/auto-fork-template.yml"
  content             = module.workflow_template.rendered
  commit_message      = "feat: adding terraform auto-fork-template"
  commit_author       = var.commit_author
  commit_email        = var.commit_email
  overwrite_on_create = true

  lifecycle {
    ignore_changes = all
  }
}

module "workflow_template" {
  source       = "github.com/codingones-terraform-modules/terraform-remote-template-renderer"
  template_url = "https://raw.githubusercontent.com/codingones/github-files-templates/main/github-actions/auto-fork-template.yml"
  template_variables = {
    TEMPLATE_REPOSITORY = var.template_repository
  }
}
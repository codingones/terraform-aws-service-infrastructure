module "aws_deployer" {
  source = "github.com/codingones-terraform-modules/aws-iam-deployer"

  name                    = "${var.aws_organizational_unit}.${var.service}.infrastructure"
  aws_organizational_unit = var.aws_organizational_unit
  service                 = var.service
  policy                  = var.policy

  providers = {
    aws = aws
  }
}

module "terraform_cloud_workspace" {
  source = "github.com/codingones-terraform-modules/aws-service-infrastructure/modules/terraform-cloud-workspace"

  terraform_organization         = var.terraform_organization
  service                        = var.service
  deployer_aws_access_key_id     = module.aws_deployer.aws_deployer_iam_access_key_id
  deployer_aws_secret_access_key = module.aws_deployer.aws_deployer_iam_access_key_secret

  providers = {
    tfe = tfe
  }

  depends_on = [module.aws_deployer]
}


module "github_repository" {
  source = "github.com/codingones-terraform-modules/github-repository-fork-template"

  github_organization          = var.github_organization
  github_repository            = var.github_repository
  github_repository_visibility = var.github_repository_visibility
  project                      = var.project
  service                      = var.service
  commit_author                = var.commit_author
  commit_email                 = var.commit_email
  github_repository_topics     = ["terraform", "aws", "service", var.service]
  template_repository          = var.template_repository
  templated_files_variables    = var.templated_files_variables
  template_fork                = var.template_fork

  allow_force_pushes_to_default_branch = var.allow_force_pushes_to_default_branch

  providers = {
    github = github
    http   = http
  }

  depends_on = [module.terraform_cloud_workspace]
}

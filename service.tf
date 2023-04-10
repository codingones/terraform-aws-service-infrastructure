module "service_aws_deployer" {
  source = "github.com/codingones/terraform-aws-service-infrastructure/modules/aws-service-deployer"

  aws_organization                  = var.aws_organization
  service                           = var.service
  service_deployer_group_policy_arn = var.service_deployer_group_policy_arn

  providers = {
    aws = aws
  }
}

module "service_terraform_cloud_workspace" {
  source = "github.com/codingones/terraform-aws-service-infrastructure/modules/terraform-cloud-workspace"

  terraform_organization                 = var.terraform_organization
  service                                = var.service
  service_deployer_aws_access_key_id     = module.service_aws_deployer.aws_deployer_iam_access_key_id
  service_deployer_aws_secret_access_key = module.service_aws_deployer.aws_deployer_iam_access_key_secret

  providers = {
    tfe = tfe
  }

  depends_on = [module.service_aws_deployer]
}


module "service_github_repository" {
  source = "github.com/codingones/terraform-aws-service-infrastructure/modules/github-repository"

  github_organization  = var.github_organization
  github_repository    = var.github_repository
  project              = var.project
  service              = var.service
  commit_author_name   = var.commit_author_name
  commit_author_email  = var.commit_author_email

  providers = {
    github = github
    http   = http
  }

  depends_on = [module.service_terraform_cloud_workspace]
}
resource "tfe_workspace" "service" {
  name         = var.service
  organization = var.terraform_organization
  tag_names    = ["service"]
}

resource "tfe_variable" "iam_deployer_access_key_id" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.deployer_aws_access_key_id
  category     = "env"
  workspace_id = tfe_workspace.service.id
  description  = "${var.terraform_organization}.${var.service}.deployer access key id"
  sensitive    = true
}

resource "tfe_variable" "iam_deployer_access_key_secret" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.deployer_aws_secret_access_key
  category     = "env"
  workspace_id = tfe_workspace.service.id
  description  = "${var.terraform_organization}.${var.service}.deployer secret access key"
  sensitive    = true
}

resource "tfe_variable" "service" {
  key          = "service"
  value        = var.service
  category     = "terraform"
  workspace_id = tfe_workspace.service.id
  description  = "The service name in the Projet-Service-Layer architecture"
  sensitive    = false
}
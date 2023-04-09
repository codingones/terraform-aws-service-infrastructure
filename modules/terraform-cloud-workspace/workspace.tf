resource "tfe_workspace" "service" {
  name         = var.service
  organization = var.terraform_organization
  tag_names    = ["service"]
}

resource "tfe_variable" "iam_deployer_access_key_id" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.service_deployer_aws_access_key_id
  category     = "env"
  workspace_id = tfe_workspace.service.id
  description  = "${var.terraform_organization}.${var.service}.deployer access key id"
  sensitive    = true
}

resource "tfe_variable" "iam_deployer_access_key_secret" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.service_deployer_aws_secret_access_key
  category     = "env"
  workspace_id = tfe_workspace.service.id
  description  = "${var.terraform_organization}.${var.service}.deployer secret access key"
  sensitive    = true
}
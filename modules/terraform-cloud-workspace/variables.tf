variable "service" {
  description = "The service name in the Project-Service-Layer architecture"
  nullable    = false
  default     = false
}

variable "terraform_organization" {
  description = "The organization name on terraform cloud"
  nullable    = false
  default     = false
}

variable "deployer_aws_access_key_id" {
  description = "The terraform organization workspace iam deployer access key id"
  nullable    = false
  default     = false
  sensitive   = true
}

variable "deployer_aws_secret_access_key" {
  description = "The terraform organization workspace iam deployer secret access key"
  nullable    = false
  default     = false
  sensitive   = true
}
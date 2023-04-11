terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "aws_organization" {
  description = "The organization name in aws organizations"
  nullable    = false
  default     = false
}

variable "service" {
  description = "The service name in the Project-Service-Layer architecture"
  nullable    = false
  default     = false
}

variable "service_policy" {
  description = "The service deployer group policy"
  type        = string
  nullable    = false
  default     = false
}

output "aws_deployer_iam_access_key_id" {
  value     = aws_iam_access_key.service_deployer_access_key.id
  sensitive = true
}

output "aws_deployer_iam_access_key_secret" {
  value     = aws_iam_access_key.service_deployer_access_key.secret
  sensitive = true
}
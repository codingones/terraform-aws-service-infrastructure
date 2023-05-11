variable "aws_organizational_unit" {
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
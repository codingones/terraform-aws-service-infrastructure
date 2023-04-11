terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
    http = {
      source = "hashicorp/http"
    }
  }
}

variable "project" {
  description = "The project name in the Project-Service-Layer architecture"
  nullable    = false
  default     = false
}

variable "service" {
  description = "The service name in the Project-Service-Layer architecture"
  nullable    = false
  default     = false
}

variable "github_organization" {
  description = "The github organization name"
  nullable    = false
  default     = false
}

variable "github_repository" {
  description = "The repository which host the code within the organization"
  nullable    = false
  default     = false
}

variable "commit_author_name" {
  description = "The commit author name for generated files"
  nullable    = false
  default     = false
}

variable "commit_author_email" {
  description = "The commit author email for generated files"
  nullable    = false
  default     = false
}

# For now the values is strictly the template one
variable "service_files" {
  type = map(object({
    path = string
    #urlInRepository = string
    url_of_template = string
  }))
  nullable = false
}

variable "force_recreate_all_github_templated_files" {
  description = "Setting this to true will recreate all templated files from the template last version"
  nullable    = false
  default     = false
}
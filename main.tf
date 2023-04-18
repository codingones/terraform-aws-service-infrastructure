terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
    tfe = {
      source = "hashicorp/tfe"
    }
    aws = {
      source = "hashicorp/aws"
    }
    http = {
      source = "hashicorp/http"
    }
  }
}
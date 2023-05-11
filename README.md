# Terraform AWS Service Infrastructure

## About

A module that aims to provide a ready to develop configuration of an AWS Service in the PSL architecture.

It initializes: 
- GitHub repository
- Terraform workspace
- AWS deployer iam user

## TOC

- 🪧 [About](#about)
- 🛠️ [Usage](#usage)
- 🤝 [Contribution](#contribution)
- 🏗️ [Built With](#built-with)
- 📝 [License](#license)


## Usage

Example usage.

This module rely on the previous deployment of admin-organisation.

```terraform
module "identity_service" {
  source = "github.com/codingones-terraform-modules/aws-service-infrastructure"

  aws_organizational_unit = local.service.aws_organizational_unit
  github_organization = local.service.github_organization
  terraform_organization = local.service.terraform_cloud_organization

  github_repository   = "identity-infrastructure"
  template_repository = "codingones-github-templates/aws-service-identity"

  project             = local.service.name
  service             = "identity"
  
  policy = local.policies.identity-infrastructure
          
  providers = {
    github = github
    tfe    = tfe
    aws    = aws.organizational_unit
  }
}
```

## Contribution

This repository is not open to external contribution yet.
I you'd like to please send me an email.

## Built With

### Languages & Frameworks

- [Terraform](https://www.terraform.io/) is an open-source infrastructure-as-code tool that enables provisioning, management, and versioning of cloud, on-premises, and third-party resources using declarative configuration files.

## License

See the [LICENSE.md](./LICENSE.md) of the repository.

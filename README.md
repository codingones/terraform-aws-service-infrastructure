# Terraform AWS Service Infrastructure

## About

A module that aims to provide a ready to develop configuration of an AWS Service in the PSL architecture

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
module "i_love_automation_identity_service" {
  source = "modules/infrastructure-service"

  aws_organization = local.service.name
  github_organization = local.service.name
  terraform_organization = local.service.name

  github_repository   = network-infrastructure
  commit_author_name  = "Terraform"
  commit_author_email = "romain.cambonie@gmail.com"

  project             = local.service.name
  service             = "identity"
  
  service_deployer_group_policy_arn = "arn:aws:iam::aws:policy/CognitoFullAccess"
  providers = {
    github = github.i-love-automation
    tfe    = tfe.i-love-automation
    aws    = aws.as_i_love_automation
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

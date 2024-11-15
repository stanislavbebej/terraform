[![dependabot](https://img.shields.io/badge/Dependabot-enabled-brightgreen?logo=dependabot)](.github/dependabot.yml)
[![editorconfig](https://img.shields.io/badge/EditorConfig-enabled-brightgreen?logo=editorconfig)](.editorconfig)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](.pre-commit-config.yaml)
[![release-please](https://img.shields.io/badge/release--please-enabled-brightgreen?logo=google)](.github/workflows/release-please.yml)

# Terraform modules

## pihole

- add **Project IAM Admin** role in [Google Cloud Console (GCP)](https://console.cloud.google.com/iam-admin/iam) to the Terraform service account
- create new key for the service account in [GCP](https://console.cloud.google.com/iam-admin/serviceaccounts)
- [add credentials](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#adding-credentials) for Terraform

## Development

Required software:

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [pre-commit](https://pre-commit.com/#install)
- [tflint](https://github.com/terraform-linters/tflint?tab=readme-ov-file#installation)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs?tab=readme-ov-file#installation)
- [Checkov](https://www.checkov.io/2.Basics/Installing%20Checkov.html)

### pre-commit

This repository uses [pre-commit](https://pre-commit.com/) hooks. Please install it during development and install hooks after every `git clone`:

```bash
pre-commit install --install-hooks
pre-commit run --all-files
```

It is also used in two GitHub workflows:

1. [Pre-commit run](.github/workflows/pre-commit-run.yml): used as a **Required status check** to validate the whole repository contents. It creates a pull request if any changes were made during the workflow run.
2. [Pre-commit update](.github/workflows/pre-commit-update.yml): a periodic maintenance workflow to keep the pre-commit hooks versions up-to-date.

### Run

Enter module directory, initialize, plan and apply the module:

```bash
cd modules/$MODULE_NAME

terraform init
terraform plan
terraform apply
```

### Test

Execute unit tests in module's **tests** directory:

```bash
cd modules/$MODULE_NAME

terraform test
```

### Dependencies

Dependencies are maintained by [Dependabot](https://docs.github.com/en/code-security/dependabot). Its configuration can be found in [dependabot.yml](.github/workflows/build.yml).

> NOTE: Make sure it is enabled in the repository [Settings](https://github.com/stanislavbebej/terraform/settings/security_analysis).

### Releases

Module is versioned and released as a "GitHub Release" by [release-please](https://github.com/googleapis/release-please). Its configuration can be found in:

- [release-please.yml](.github/release-please.yml)
- [release-please-config.json](release-please-config.json)

> NOTE: New versions should not be created manually.

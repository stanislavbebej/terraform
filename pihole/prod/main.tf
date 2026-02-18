provider "google" {
  project = "support-infra"
  region  = "us-east1"
  zone    = "us-east1-b"
}

module "pihole" {
  # checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  # source = "github.com/stanislavbebej/terraform//modules/pihole?ref=v0.0.0" # x-release-please-version

  # checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  # checkov:skip=CKV_TF_2:Ensure Terraform module sources use a tag with a version number
  source = "github.com/stanislavbebej/terraform//modules/pihole?ref=devel"

  environment = "prod"
  gcp_project = "support-infra"
}

output "ip" {
  value = module.pihole.ip-external
}

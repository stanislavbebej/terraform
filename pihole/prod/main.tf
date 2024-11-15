provider "google" {
  project = "support-infra"
  region  = "us-east1"
  zone    = "us-east1-b"
}

module "pihole" {
  # checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  source = "github.com/stanislavbebej/terraform//modules/pihole?ref=v0.0.0" # x-release-please-version

  environment = "prod"
  gcp_project = "support-infra"
}

output "ip" {
  value = module.pihole.ip-external
}

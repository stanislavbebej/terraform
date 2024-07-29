provider "google" {
  project = "support-infra"
  region  = "us-east1"
  zone    = "us-east1-b"
}

module "pihole" {
  source = "github.com/stanislavbebej/terraform//modules/pihole?ref=devel"

  environment = "prod"
  gcp_project = "support-infra"
}

output "ip" {
  value = module.pihole.ip-external
}

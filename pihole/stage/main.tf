provider "google" {
  project = "sb-devel"
  region  = "us-east1"
  zone    = "us-east1-b"
}

module "pihole" {
  source = "github.com/stanislavbebej/terraform//modules/pihole?ref=devel"

  environment = "staging"
  gcp_project = "sb-devel"
}

output "ip" {
  value = module.pihole.ip-external
}

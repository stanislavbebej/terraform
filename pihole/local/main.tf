provider "google" {
  project = "sb-devel"
  region  = "us-east1"
  zone    = "us-east1-b"
}

module "pihole" {
  source = "../../modules/pihole"

  environment = "local"
  gcp_project = "sb-devel"
  # machine_type = "e2-standard-2"
}

output "ip" {
  value = module.pihole.ip-external
}

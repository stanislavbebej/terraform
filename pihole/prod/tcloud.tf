terraform {
  cloud {
    organization = "gcp-support-infra"

    workspaces {
      name = "pihole"
    }
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.37.0"
    }
  }
}

provider "google" {
  project = var.gcp.project
  region  = var.gcp.region
  zone    = var.gcp.zone
}

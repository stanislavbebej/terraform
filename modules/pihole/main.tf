locals {
  net_interface = "ens4"
  vm_user       = "stanislav_bebej"
  wg_port       = 51820
}

resource "google_service_account" "default" {
  account_id   = "sa-pi-hole-${var.environment}"
  display_name = "PiHole Service Account"
}

resource "google_compute_instance" "vm_instance" {
  # checkov:skip=CKV_GCP_38:Ensure VM disks for critical VMs are encrypted with Customer Supplied Encryption Keys (CSEK)
  # checkov:skip=CKV_GCP_39:Ensure Compute instances are launched with Shielded VM enabled
  # checkov:skip=CKV_GCP_40:Ensure that Compute instances do not have public IP addresses
  name         = "pi-hole-${var.environment}"
  machine_type = var.machine_type
  labels = {
    env  = var.environment
    role = "pihole"
  }

  boot_disk {
    initialize_params {
      # https://cloud.google.com/compute/docs/images/os-details#debian
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    block-project-ssh-keys = true
    enable-osconfig        = true
    ssh-keys               = <<EOT
      ${local.vm_user}:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDS+y+IyafKhgFWqa3oNlgXoihH6/XjBJeeqO9uCOD7v stanislav.bebej@aconic.eu
      ${local.vm_user}:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIESV4CSjcjtXe7VM6VPrsFt33X1kFcUkEEZ3Uzlk+kEV stanislav@spectre-win
      ${local.vm_user}:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPMmc5/e9XJeE9VYdw0L3JNEKtKQorXoPSMI0DxPcHzi stanislav@thinkcentre
      ${local.vm_user}:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINL0SbjzTRSBW+8M2zRxgtNJQNSPWvJGNSaqV1LX8y8R JuiceSSH
    EOT
  }

  metadata_startup_script = templatefile("${path.module}/bootstrap.sh", {
    NET_INTERFACE = local.net_interface
    VM_USER       = local.vm_user
    WG_PORT       = local.wg_port
  })

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_firewall" "default" {
  name    = "allow-wireguard-${var.environment}"
  network = "default"

  allow {
    protocol = "udp"
    ports    = [local.wg_port]
  }

  source_ranges = ["0.0.0.0/0"]
}

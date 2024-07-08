variable "gcp" {
  description = "Google Cloud Provider configuration"
  type        = map(string)
  default = {
    project = "sb-devel"
    region  = "us-east1"
    zone    = "us-east1-b"
  }
}

variable "machine_type" {
  # https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types
  description = "Google Compute Engine machine type"
  type        = string
  default     = "e2-micro"
}

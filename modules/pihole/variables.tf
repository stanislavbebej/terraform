variable "environment" {
  description = "Environment name used as suffix in resource names"
  type        = string
}

variable "gcp_project" {
  description = "Google Cloud Platform Project value"
  type        = string
}

variable "machine_type" {
  # https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types
  description = "Google Compute Engine machine type"
  type        = string
  default     = "e2-micro"
}

variable "project_id" {
  description = "The project id to deploy all services on GKE"
}

variable "tfstate_gcs_backend" {
  description = "Name of the GCS bucket to use as a backend for Terraform State"
  default     = "TFSTATE_GCS_BACKEND"
}

variable "region" {
  description = "The region to deploy all services on GKE"
  default     = "us-central1"
}

variable "zones" {
  description = "The zones to deploy all services on GKE"
  default     = ["us-central1-c"]
}

variable "ip_range_pods_name" {
  description = "The name of the IP range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "The name of the IP range to use for services"
  default     = "ip-range-scv"
}

variable "network_name" {
  description = "The name of the network to use for Dew"
  default     = "dew-network"
}

variable "subnet_ip" {
  description = "The IP address of the subnet to use for Dew"
  default     = "10.10.10.0/24"
}

variable "subnet_name" {
  description = "The name of the subnet to use for Dew"
  default     = "dew-subnet"
}

variable "github_username" {
  description = "Github user/organization name where the terraform repo resides."
}

variable "github_token" {
  description = "Github token for the user/organization."
}

variable "github_repo" {
  description = "Github repo name."
}

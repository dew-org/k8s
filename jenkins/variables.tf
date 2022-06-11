variable "project_id" {
  description = "The project id to deploy Jenkins on GKE"
}

variable "tfstate_gcs_backend" {
  description = "Name of the GCS bucket to use as a backend for Terraform State"
  default     = "TFSTATE_GCS_BACKEND"
}

variable "region" {
  description = "The region to deploy Jenkins on GKE"
  default     = "us-east4"
}

variable "zones" {
  description = "The zones to deploy Jenkins on GKE"
  default     = ["us-east4-a"]
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
  description = "The name of the network to use for Jenkins"
  default     = "jenkins-network"
}

variable "subnet_ip" {
  description = "The IP address of the subnet to use for Jenkins"
  default     = "10.10.10.0/24"
}

variable "subnet_name" {
  description = "The name of the subnet to use for Jenkins"
  default     = "jenkins-subnet"
}

variable "jenkins_k8s_config" {
  description = "The name of the k8s config to use for Jenkins"
  default     = "jenkins-k8s-config"
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

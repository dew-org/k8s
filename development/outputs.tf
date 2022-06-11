output "kubernetes_endpoint" {
  description = "The cluster endpoint"
  sensitive   = true
  value       = module.dew-gke.endpoint
}

output "ca_certificate" {
  description = "The cluster ca certificate (base64 encoded)"
  sensitive   = true
  value       = module.dew-gke.ca_certificate
}

output "service_account" {
  description = "The default service account used for running nodes."
  value       = module.dew-gke.service_account
}

output "cluster_name" {
  description = "Cluster name"
  value       = module.dew-gke.name
}

output "dew_project_id" {
  description = "Project id of dew GKE project"
  value       = module.enables-google-apis.project_id
}

output "zone" {
  description = "Zone of Dew GKE cluster"
  value       = join(",", var.zones)
}

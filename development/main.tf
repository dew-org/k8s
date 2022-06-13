/*****************************************
  Activate Services in Dew Project
 *****************************************/
module "enables-google-apis" {
  source = "terraform-google-modules/project-factory/google//modules/project_services"

  project_id = var.project_id

  activate_apis = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "containerregistry.googleapis.com",
    "container.googleapis.com",
    "storage-component.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
  ]
}

/*****************************************
  Dew VPC
 *****************************************/
module "dew-vpc" {
  source = "terraform-google-modules/network/google"

  project_id   = module.enables-google-apis.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = var.subnet_name
      subnet_ip     = "10.0.0.0/17"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${var.subnet_name}" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "192.168.64.0/18"
      },
    ]
  }
}

/*****************************************
  Dew GKE
 *****************************************/
module "dew-gke" {
  source                   = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster"
  project_id               = module.enables-google-apis.project_id
  name                     = "deworg"
  regional                 = false
  region                   = var.region
  zones                    = var.zones
  network                  = module.dew-vpc.network_name
  subnetwork               = module.dew-vpc.subnets_names[0]
  ip_range_pods            = var.ip_range_pods_name
  ip_range_services        = var.ip_range_services_name
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  remove_default_node_pool = true
  service_account          = "create"
  identity_namespace       = "${module.enables-google-apis.project_id}.svc.id.goog"
  node_metadata            = "GKE_METADATA_SERVER"
  node_pools               = [
    {
      name         = "default-pool"
      machine_type = "e2-micro"
      min_count    = 1
      max_count    = 3
      image_type   = "COS_CONTAINERD"
      disk_size_gb = 10
      auto_upgrade = true
    }
  ]
}

/*****************************************
  K8S secrets for GH
 *****************************************/
resource "kubernetes_secret" "gh-secrets" {
  metadata {
    name = "github-secrets"
  }
  data = {
    github_username = var.github_username
    github_repo     = var.github_repo
    github_token    = var.github_token
  }
}


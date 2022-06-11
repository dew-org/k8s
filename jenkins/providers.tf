/*****************************************
  Kubernetes provider configuration
 *****************************************/
data "google_client_config" "default" {
}

provider "kubernetes" {
  host                   = "https://${module.jenkins-gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.jenkins-gke.ca_certificate)
}

/*****************************************
  Helm provider configuration
 *****************************************/
provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(module.jenkins-gke.ca_certificate)
    host                   = "https://${module.jenkins-gke.endpoint}"
    token                  = data.google_client_config.default.access_token
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.39.0, <4.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

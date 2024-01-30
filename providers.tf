provider "kubernetes" {
  host                   = module.infrastructure.cluster_endpoint
  cluster_ca_certificate = module.infrastructure.cluster_certificate_authority_data

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.infrastructure.cluster_name, "--output", "json"]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.infrastructure.cluster_endpoint
    cluster_ca_certificate = module.infrastructure.cluster_certificate_authority_data

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.infrastructure.cluster_name, "--output", "json"]
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

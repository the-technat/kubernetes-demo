terraform {
  backend "remote" {
    organization = "technat"

    workspaces {
      name = "kubernetes-demo"
    }
  }
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
  }
}
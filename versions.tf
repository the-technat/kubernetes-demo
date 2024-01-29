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
      source = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    argocd = {
      source = "oboukili/argocd"
    }
    bcrypt = {
      source = "viktorradnai/bcrypt"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
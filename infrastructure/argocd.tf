##########
# Argo CD
##########
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.53.9"
  namespace        = "argocd"
  wait             = true
  create_namespace = true
  values = [
    templatefile("${path.module}/helm_values/argocd.yaml", {
      dns_zone = var.dns_zone
      class    = local.ingress_class
    })
  ]

  set_sensitive {
    name  = "configs.secret.argocdServerAdminPassword"
    value = bcrypt_hash.argocd_password.id
  }

  depends_on = [
    module.eks,
    helm_release.cilium,
    kubernetes_priority_class_v1.infra,
  ]
}


##########
# General
##########
# A priority class for stuff deployed via Argo CD
resource "kubernetes_priority_class_v1" "infra" {
  metadata {
    name = "infra"
  }

  value = 1000000000

  depends_on = [
    module.eks
  ]
}

resource "argocd_project" "apps" {
  metadata {
    name      = "apps"
    namespace = "argocd"
  }
  spec {
    source_repos = ["*"]
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "*"
    }
    cluster_resource_whitelist {
      group = "*"
      kind  = "*"
    }
    namespace_resource_whitelist {
      group = "*"
      kind  = "*"
    }
  }

  depends_on = [
    module.eks,
    helm_release.cilium,
    helm_release.argocd
  ]
}

resource "argocd_application" "app_of_apps" {
  metadata {
    name      = "app-of-apps"
    namespace = "argocd"
  }

  wait = true

  spec {
    project = "apps"

    source {
      repo_url        = "https://github.com/the-technat/kubernetes-demo.git"
      path            = "infrastructure/apps"
      target_revision = "HEAD"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "argocd"
    }

    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      sync_options = ["CreateNamespace=true", "ServerSideApply=true"]
      retry {
        limit = "5"
        backoff {
          duration     = "5s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }
  }

  depends_on = [
    module.eks,
    helm_release.cilium,
    helm_release.argocd,
    argocd_project.apps
  ]
}

resource "random_password" "argocd_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "bcrypt_hash" "argocd_password" {
  cleartext = random_password.argocd_password.result
}
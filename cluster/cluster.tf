module "eks_full" {
  source = "git::https://github.com/the-technat/terraform-aws-eks-full.git"

  cluster_name      = "demo"
  region            = "eu-west-1" # also change in provider definition below
  dns_zone          = "aws.technat.dev" # also change in the NS records below
  account_id        = "351425708426" # also change in aws_auth_users list below
  onboarding_repo   = "https://github.com/the-technat/kubernetes-demo.git"
  onboarding_folder = "apps"
  email             = "technat+aws@technat.ch"

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::351425708426:user/technat"
      username = "technat"
      groups   = ["system:masters"]
    },
  ]

  tags = {}
}

provider "aws" {
  region = "eu-west-1"
}

################
# Outputs
################
output "grafana_password" {
  value = nonsensitive(module.eks_full.grafana_password)
}

output "argocd_password" {
  value = nonsensitive(module.eks_full.argocd_password)
}

################
# DNS
################
data "hetznerdns_zone" "dns_zone" {
  name = "technat.dev"
}
resource "hetznerdns_record" "ns_records_zone_1" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "aws"
  value   = "${module.eks_full.ns_records[0]}."
  type    = "NS"
  ttl     = 60
}

resource "hetznerdns_record" "ns_records_zone_2" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "aws"
  value   = "${module.eks_full.ns_records[1]}."
  type    = "NS"
  ttl     = 60
}
resource "hetznerdns_record" "ns_records_zone_3" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "aws"
  value   = "${module.eks_full.ns_records[2]}."
  type    = "NS"
  ttl     = 60
}
resource "hetznerdns_record" "ns_records_zone_4" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "aws"
  value   = "${module.eks_full.ns_records[3]}."
  type    = "NS"
  ttl     = 60
}

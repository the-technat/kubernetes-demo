module "eks_full" {
  source = "git::https://github.com/the-technat/terraform-aws-eks-full.git"

  cluster_name      = "kiwi"
  region            = "eu-west-1"
  dns_zone          = "aws.technat.dev"
  account_id        = data.aws_caller_identity.current.account_id
  onboarding_repo   = "https://github.com/the-technat/kubernetes-demo.git"
  onboarding_folder = "apps"
  email             = "technat+grapes@technat.ch"

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/technat"
      username = "technat"
      groups   = ["system:masters"]
    },
  ]

  tags = {}
}

data "aws_caller_identity" "current" {}

################
# DNS
################
data "hetznerdns_zone" "dns_zone" {
  name = "technat.dev"
}
resource "hetznerdns_record" "ns_records_zone_1" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "aws"
  value   = module.eks_full.ns_records[0]
  type    = "NS"
  ttl     = 60
}

resource "hetznerdns_record" "ns_records_zone_2" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "aws"
  value   = module.eks_full.ns_records[1]
  type    = "NS"
  ttl     = 60
}
resource "hetznerdns_record" "ns_records_zone_3" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "aws"
  value   = module.eks_full.ns_records[2]
  type    = "NS"
  ttl     = 60
}
resource "hetznerdns_record" "ns_records_zone_4" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "aws"
  value   = module.eks_full.ns_records[3]
  type    = "NS"
  ttl     = 60
}
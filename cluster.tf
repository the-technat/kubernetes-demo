module "infrastructure" {
  source = "./infrastructure"

  cluster_name = "kiwi"
  region       = "eu-west-1"
  dns_zone     = "aws.technat.dev"
  account_id   = data.aws_caller_identity.current.account_id
  email        = "technat+grapes@technat.ch"

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
module "infrastructure" {
    source = "./infrastructure"

    cluster_name = "kiwi"
    region = "eu-west-1"

    aws_auth_users = [
        {
      userarn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/technat"
      username = "technat"
      groups = ["system:masters"]
    },
    ]

    tags = {}
}

provider "aws" {
  region = "eu-west-1"
}
provider "aws" {
  region = var.region
}
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

locals {
  region = var.region
  name   = var.name
  vpc_cidr = var.vpc_cidr
  azs      = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags = {
    name = var.env
  }
}


provider "aws" {
  region = var.region
}

locals {
  region = var.region
<<<<<<< HEAD
  name   = "Terraform-Deployed-K8s"
=======
  name   = var.name
>>>>>>> a344fc4 (eks-updated)
  vpc_cidr = var.vpc_cidr
  azs      = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  intra_subnets   = var.intra_subnets
  tags = {
    Example = var.env
  }
}
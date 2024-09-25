module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { most_recent = true }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = var.instance_types
  }

  eks_managed_node_groups = {
    Managed-node-grp = {
      ami_type       = var.ami_type
      instance_types = var.instance_types

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
  iam_role_arn                             = aws_iam_role.eks_role.arn
  enable_cluster_creator_admin_permissions = true


  tags = {
    name        = var.cluster_name
    Environment = var.env
    Terraform   = "true"
  }
}
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

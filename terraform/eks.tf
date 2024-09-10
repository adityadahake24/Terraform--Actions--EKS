module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {most_recent = true}
    kube-proxy             = {most_recent = true}
    vpc-cni                = {most_recent = true}
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

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

  enable_cluster_creator_admin_permissions = true

  access_entries = {
    Role-assigned ={
      principal_arn     = "arn:aws:iam::535002868034:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS"

      policy_associations = {
        assigned-policy ={
          policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonEKSServiceRolePolicy"
        }
      }
    }
  }

  tags = {
    Environment = var.env
    Terraform   = "true"
  }
}
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
#data "aws_eks_cluster_auth" "cluster" {
#  name = aws_eks_cluster.example.name
#}
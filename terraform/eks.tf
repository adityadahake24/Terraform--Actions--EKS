module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

<<<<<<< HEAD
  cluster_name    = local.name
=======
  cluster_name    = var.cluster_name
>>>>>>> a344fc4 (eks-updated)
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
<<<<<<< HEAD
    instance_types = [ "m5.large"]
=======
    instance_types = [ "t3.medium"]
>>>>>>> a344fc4 (eks-updated)
  }

  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
<<<<<<< HEAD
      instance_types = ["m5.xlarge"]
=======
      instance_types = ["t3.medium"]
>>>>>>> a344fc4 (eks-updated)

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
  tags = {
    Environment = var.env
    Terraform   = "true"
  }
}
<<<<<<< HEAD
=======
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}
>>>>>>> a344fc4 (eks-updated)

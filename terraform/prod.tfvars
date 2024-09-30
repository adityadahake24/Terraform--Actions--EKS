env             = "prod"
name            = "Terraform-Deployed-K8s"
cluster_name    = "Autok8s"
vpc_cidr        = "10.0.0.0/16"
region          = "ap-south-1"
public_subnets  = ["10.0.9.0/24", "10.0.10.0/24"]
private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
azs             = ["ap-south-1a", "ap-south-1b"]
instance_types  = ["t3.large"]
ami_type        = "AL2023_x86_64_STANDARD"
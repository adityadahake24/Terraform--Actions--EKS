variable "env" {
  description = "the enviroment for deployment"
  type = string
}
variable "vpc_cidr" {
  description = "the cidr range of the vpc"
  type = string
}
variable "region" {
  description = "the default region"
  type = string
}
variable "public_subnets" {
  description = "the public cidr subnet ranges for k8s deployment"
  type = list(string)
}
variable "private_subnets" {
  description = "the private cidr subnet ranges for k8s deployment"
  type = list(string)
}
variable "intra_subnets" {
  description = "the internal subnet cidr ranges for communication"
  type = list(string)
}
variable "azs" {
  description = "availability zones"
  type = list(string)
}
<<<<<<< HEAD
=======
variable "name" {
  description = "name"
  type = string
}
variable "cluster_name" {
  description = "cluster name"
  type = string
}
<<<<<<< HEAD
>>>>>>> a344fc4 (eks-updated)
=======
>>>>>>> 7655d40 (eks updated)

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
variable "azs" {
  description = "availability zones"
  type = list(string)
}
variable "name" {
  description = "name"
  type = string
}
variable "cluster_name" {
  description = "cluster name"
  type = string
}
variable "instance_types" {
  description = "instance types ofr eks cluster"
  type = list(string)
}
variable "ami_type" {
  description = "the ami type for cluster"
  type = string
}
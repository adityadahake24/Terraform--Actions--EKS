provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
resource "kubernetes_namespace" "Autok8s" {
    metadata {
      name = var.env
    }
}
resource "kubernetes_manifest" "deploymnet" {
  manifest = {

  }
}
resource "kubernetes_manifest" "services" {
  manifest = {
    
  }
}

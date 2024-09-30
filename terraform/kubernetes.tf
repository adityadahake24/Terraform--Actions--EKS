terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
  }
}
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
resource "kubernetes_namespace" "grafana-ns" {
  metadata {
    name = "grafana-ns"
  }
}
resource "kubernetes_deployment" "grafana-deploy" {
  metadata {
    name      = "grafana-deploy"
    namespace = "grafana-ns"
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "grafana"
      }
    }
    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }
      spec {
        container {
          name  = "grafana"
          image = "grafana/grafana:latest"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "grafana-ns"
  }

  spec {
    selector = {
      app = "grafana"
    }

    port {
      port        = 3000
      target_port = 3000
    }

    type = "ClusterIP"
  }
}
resource "kubernetes_ingress" "grafana-ingress" {
  metadata {
    name      = "grafana-ingress"
    namespace = "grafana-ns"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/"
          backend {
            service_name = kubernetes_service.grafana.metadata[0].name
            service_port = 3000
          }
        }
      }
    }
  }
}
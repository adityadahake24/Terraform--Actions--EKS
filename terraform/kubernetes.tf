terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.32.0"
    }
  }
}
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "grafana"
  }
}
resource "kubernetes_deployment" "grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.grafana.metadata[0].name
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
    namespace = kubernetes_namespace.grafana.metadata[0].name
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
resource "kubernetes_ingress" "grafana" {
  metadata {
    name      = "grafana-ingress"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    annotations = {
      "nginx.ingress.kubernetes.io/auth-url"    = "https://https://otpless.com/appid/AEI9J3HZVTZG7DQS39ML/auth"
      "nginx.ingress.kubernetes.io/auth-signin" = "https://https://otpless.com/appid/AEI9J3HZVTZG7DQS39ML/login?redirect=$request_uri"
    }
  }
  spec {
    rule {
      host = "grafana.yourdomain.com"
      http {
        path {
          path     = "/"
          backend {
            service_name = kubernetes_service.grafana.metadata[0].name
            service_port = 3000
            }
          }
        }
      }
    }
  }

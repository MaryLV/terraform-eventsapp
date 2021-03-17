resource "kubernetes_deployment" "frontend-deployment" {
  metadata {
    name = "frontend-deployment"
    labels = {
      App = "terradev-frontend"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 3
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "terradev-frontend"
      }
    }
    template {
      metadata {
        labels = {
          App = "terradev-frontend"
        }
      }
      spec {
        container {
          image = "gcr.io/mar-roidtc313/frontend-dockerimage:latest"
          name  = "terradev-frontend"

          port {
            container_port = 80
          }

          env {
            name = "SERVER"
            value = "http://backend-service"
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "256Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}
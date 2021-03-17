resource "kubernetes_deployment" "backend-deployment" {
  metadata {
    name = "terradev-deployment"
    labels = {
      App = "terradev-backend"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "terradev-backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "terradev-backend"
        }
      }
      spec {
        container {
          image = "gcr.io/mar-roidtc313/backend-dockerimage:latest"
          name  = "terradev-backend"

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
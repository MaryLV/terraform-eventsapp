resource "kubernetes_service" "backend-service" {
  metadata {
    name      = "backend-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.backend-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8082
      protocol = "TCP"
    }

    type = "ClusterIP"
  }
}


output "cip_status" {
  value = kubernetes_service.backend-service.status
}
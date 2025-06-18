provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "fastapi_app" {
  metadata {
    name = "fastapi-deployment"
    labels = {
      app = "fastapi"
    }
  }

  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = "fastapi"
      }
    }

    template {
      metadata {
        labels = {
          app = "fastapi"
        }
      }

      spec {
        container {
          name  = "fastapi-container"
          image = "fastapi-hello"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "fastapi_service" {
  metadata {
    name = "fastapi-service"
  }

  spec {
    selector = {
      app = "fastapi"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}

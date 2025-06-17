provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "hello" {
  metadata {
    name = "hello-world"
    labels = {
      app = "hello"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "hello"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello"
        }
      }

      spec {
        container {
          name  = "hello-container"
          image = "nginxdemos/hello"
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello" {
  metadata {
    name = "hello-world-service"
  }

  spec {
    selector = {
      app = "hello"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }

    type = "NodePort"
  }
}
# Provider to connect Terraform to your local Kubernetes cluster
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Creating a Kubernetes Deployment running a Hello World app
resource "kubernetes_deployment" "hello" {
  metadata {
    name = "hello-world" # This is the name visible in kubectl get deployments
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
          image = "nginxdemos/hello"  # Lightweight Hello World app
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Expose the deployment with a NodePort service so we can access it via localhost:30080
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
      node_port   = 30080  # You can change this if you want a different local port
    }

    type = "NodePort"
  }
}
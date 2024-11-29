##############################################################
# PostgreSQL Resources
##############################################################

resource "kubernetes_deployment" "postgres_app" {
  count = var.deploy_postgres ? 1 : 0

  metadata {
    name      = "postgres-app"
    namespace = var.k8s_namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgres-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres-app"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:${var.postgres_version}"

           env {
            name  = "POSTGRES_USER"
            value = "postgres"
          }
          
          env {
            name  = "POSTGRES_PASSWORD"
            value = "postgres123"  
          }

          env {
            name  = "POSTGRES_DB"
            value = var.postgres_db
          }

          env {
            name  = "POSTGRES_INITDB_ARGS"
            value = "--auth-host=md5"
          }

          resources {
            limits = {
              cpu    = "4"
              memory = "4Gi"
            }
            requests = {
              cpu    = "4"
              memory = "4Gi"
            }
          }

          port {
            container_port = 5432
          }
        }
      }
    }
  }
}

# Postgres Service
resource "kubernetes_service" "postgres_app" {
  count = var.deploy_postgres ? 1 : 0

  metadata {
    name      = "postgres-app-service"
    namespace = var.k8s_namespace
  }

  spec {
    selector = {
      app = "postgres-app"
    }

    port {
      port        = 5432
      target_port = 5432
    }

    type = "LoadBalancer"
  }
}

##############################################################
# pgAdmin Resources
##############################################################

# pgAdmin Deployment
resource "kubernetes_deployment" "pgadmin_app" {
  count = var.deploy_pgAdmin ? 1 : 0

  metadata {
    name      = "pgadmin-app"
    namespace = var.k8s_namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "pgadmin-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "pgadmin-app"
        }
      }

      spec {
        container {
          name  = "pgadmin"
          image = "dpage/pgadmin4:${var.pgAdmin_version}"

          env {
            name  = "PGADMIN_DEFAULT_EMAIL"
            value = var.pgAdmin_email
          }
          
          env {
            name  = "PGADMIN_DEFAULT_PASSWORD"
            value = var.pgAdmin_password
          }

          env {
            name  = "PGADMIN_CONFIG_SERVER_MODE"
            value = "False"
          }

          resources {
            limits = {
              cpu    = "4"
              memory = "4Gi"
            }
            requests = {
              cpu    = "4"
              memory = "4Gi"
            }
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# pgAdmin Service
resource "kubernetes_service" "pgadmin_app" {
  count = var.deploy_pgAdmin ? 1 : 0

  metadata {
    name      = "pgadmin-app-service"
    namespace = var.k8s_namespace
  }

  spec {
    selector = {
      app = "pgadmin-app"
    }

    port {
      port        = var.pgAdmin_port
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "python_app" {
  count = var.deploy_python ? 1 : 0

  metadata {
    name      = "python-app"
    namespace = var.k8s_namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "python-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "python-app"
        }
      }

      spec {
        container {
          name  = "python"
          image = "python:${var.python_version}"

          # Copy files to /tmp and execute
          command = ["/bin/bash"]
          args    = ["-c", "mkdir -p /tmp/scripts /tmp/config && cp /mnt/scripts/* /tmp/scripts/ && cp /mnt/config/* /tmp/config/ && chmod +x /tmp/config/starter-python.sh && /tmp/config/starter-python.sh"]

          resources {
            limits = {
              cpu    = "4"
              memory = "4Gi"
            }
            requests = {
              cpu    = "4"
              memory = "4Gi"
            }
          }

          port {
            container_port = 5050
          }

          volume_mount {
            name       = "python-starter"
            mount_path = "/mnt/config"
          }

          volume_mount {
            name       = "python-starter"
            mount_path = "/mnt/scripts"
          }
        }

        volume {
          name = "python-starter"
          config_map {
            name = kubernetes_config_map.python_starter[0].metadata[0].name
            default_mode = "0755"
          }
        }
      }
    }
  }
}

# Python Configmap
resource "kubernetes_config_map" "python_starter" {
  count = var.deploy_python ? 1 : 0

  metadata {
    name      = "python-starter"
    namespace = var.k8s_namespace
  }

  data = {
    "postgres_script.py" = file("/home/cagri/project/terraform_projects/Terraform-Kubernetes-Deployment/containers/python/postgres_script.py")
    "starter-python.sh" = file("/home/cagri/project/terraform_projects/Terraform-Kubernetes-Deployment/containers/config/starter-python.sh")
    "test.txt"         = file("/home/cagri/project/terraform_projects/Terraform-Kubernetes-Deployment/containers/config/test.txt")
  }
}
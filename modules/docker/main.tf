################# ====================== #####################
# PostgreSQL
################# ====================== #####################
# Postgres Image
resource "docker_image" "postgres" {
  count        = var.deploy_postgres ? 1 : 0
  name         = "postgres:${var.postgres_version}"
  keep_locally = false
}

# Postgres Container
resource "docker_container" "postgres" {
  count = var.deploy_postgres ? 1 : 0

  image = docker_image.postgres[0].image_id
  name  = "postgres"

  cpu_set = "4"
  memory = 4096

  ports {
    internal = 5432
    external = 5432
  }

  networks_advanced {
    name         = var.network
    ipv4_address = var.postgres_ipv4
  }

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_db}"
  ]

  volumes {
    host_path      = "/home/cagri/project/terraform_projects/Terraform-Docker-Deployment/modules/docker/containers/postgres/postgres_data"
    container_path = "/var/lib/postgresql/data"
  }

  must_run = true
}

################# ====================== #####################
# pgAdmin
################# ====================== #####################
# pgAdmin Image
resource "docker_image" "pgAdmin" {
  count        = var.deploy_pgAdmin ? 1 : 0
  name         = "dpage/pgadmin4:${var.pgAdmin_version}"
  keep_locally = false
}

# pgAdmin Container
resource "docker_container" "pgAdmin" {
  count = var.deploy_pgAdmin ? 1 : 0

  image = docker_image.pgAdmin[0].image_id
  name  = "pgAdmin"

  cpu_set = "4"
  memory = 4096

  networks_advanced {
    name         = var.network
    ipv4_address = var.pgAdmin_ipv4
  }

  env = [
    "PGADMIN_DEFAULT_EMAIL=${var.pgAdmin_email}",
    "PGADMIN_DEFAULT_PASSWORD=${var.pgAdmin_password}"
  ]

  ports {
    internal = 80
    external = 80
  }
}

################# ====================== #####################
# Python
################# ====================== #####################
# Python Image
resource "docker_image" "python" {
  count = var.deploy_python ? 1 : 0 
  name  = "python:${var.python_version}"
  keep_locally = false
}

# Python Container
resource "docker_container" "python" {
  count = var.deploy_python ? 1 : 0

  image = docker_image.python[0].image_id
  name  = "python"

  cpu_set = "4"
  memory  = 4096

  networks_advanced {
    name         = var.network
    ipv4_address = var.python_ipv4
  }

  volumes {
    host_path      = "/home/cagri/project/terraform_projects/Terraform-Docker-Deployment/modules/docker/containers/python/scripts"
    container_path = "/mnt/scripts"
  }

  volumes {
    host_path      = "/home/cagri/project/terraform_projects/Terraform-Docker-Deployment/modules/docker/containers/python/config"
    container_path = "/mnt/config"
  }

  entrypoint = ["/bin/bash", "-c", "chmod +x /mnt/config/starter-python.sh && /mnt/config/starter-python.sh"]
  working_dir = "/mnt"
}
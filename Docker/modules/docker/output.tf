################## ========================= ##################
# Localhost Network for Docker Output
################## ========================= ##################
output "network" {
    description = "This is my localhost network for Docker"
    value = "Docker localhost network: ${var.network}"
}

################## ========================= ##################
# Postgres Output
################## ========================= ##################
output "postgres_ipv4" {
  description = "Postgres ipv4 Address"
  value = var.deploy_postgres ? "Postgres IP Address: ${var.postgres_ipv4}" : null
}

output "postgres_access_url" {
  description = "Postgres connection URL"
  value = var.deploy_postgres ? "Postgres URL: jdbc:postgresql://${var.postgres_ipv4}:5432/${var.postgres_db}" : null
}

################## ========================= ##################
# pgAdmin Output
################## ========================= ##################
output "pgAdmin_ipv4" {
  description = "pgAdmin ipv4 Adress"
  value = var.deploy_pgAdmin ? "pgAdmin IP Address: ${var.pgAdmin_ipv4}" : null
}

output "pgAdmin_port" {
  description = "pgAdmin port"
  value = var.deploy_pgAdmin ? var.pgAdmin_port : null
}

output "pgAdmin_email" {
  description = "pgAdmin root email."
  value = var.deploy_pgAdmin ? "pgAdmin root email: ${var.pgAdmin_email}" : null
}

output "pgAdmin_password" {
  description = "pgAdmin root password"
  value = var.deploy_pgAdmin ? "pgAdmin root password: ${var.pgAdmin_password}" : null
}

output "pgAdmin_access_url" {
  description = "pgAdmin access url"
  value = var.deploy_pgAdmin ? "pgAdmin access url: http://localhost:${var.pgAdmin_port}" : null
}

################## ========================= ##################
# Python Output
################## ========================= ##################
output "python_ipv4" {
  description = "Python ipv4 Adress"
  value = var.deploy_python ? "Python IP Address: ${var.python_ipv4}" : null
}

output "python_version" {
  description = "Python version"
  value = var.deploy_python ? var.python_version : null
}

output "python_container_name" {
  description = "Python container name for test script"
  value = var.deploy_python ? var.python_container_name : null
}

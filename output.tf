################## ========================= ##################
# Localhost Network for Docker Output
################## ========================= ##################
output "network" {
    description = "This is my localhost network for Docker"
    value = "Docker localhost network: ${var.network}"
}

output "postgres_ipv4" {
  description = "Postgres ipv4 Address"
  value = var.deploy_postgres ? "Postgres IP Address: ${var.postgres_ipv4}" : null
}

output "pgAdmin_ipv4" {
  description = "pgAdmin ipv4 Adress"
  value = var.deploy_pgAdmin ? "pgAdmin IP Address: ${var.pgAdmin_ipv4}" : null
}

output "python_ipv4" {
  description = "Python ipv4 Adress"
  value = var.deploy_python ? "Python IP Address: ${var.python_ipv4}" : null
}

################## ========================= ##################
# Postgres Output
################## ========================= ##################
output "postgres_access_url" {
  description = "Postgres connection URL"
  value       = var.deploy_postgres ? "Postgres URL: jdbc:postgresql://${var.postgres_host}:${var.postgres_port}/${var.postgres_db}" : null
}

################## ========================= ##################
# pgAdmin Output
################## ========================= ##################
output "pgAdmin_email" {
  description = "pgAdmin root email."
  value       = var.deploy_pgAdmin ? "pgAdmin root email: ${var.pgAdmin_email}" : null
}

output "pgAdmin_password" {
  description = "pgAdmin root password"
  value       = var.deploy_pgAdmin ? "pgAdmin root password: ${var.pgAdmin_password}" : null
}

################## ========================= ##################
# Python - Spark Output
################## ========================= ##################
output "python_version" {
    description = "Python version"
    value = var.deploy_python ? "Python version is: ${var.python_version}" : null
}
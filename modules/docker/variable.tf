################# ====================== #####################
# Start or Not
################# ====================== #####################
variable "deploy_postgres" {
  description = "Postgres container is deployed or not"
  type        = bool
}

variable "deploy_pgAdmin" {
  description = "pgAdmin container is deployed or not"
  type        = bool
}

variable "deploy_python" {
  description = "Python container is deployed or not"
  type        = bool
}

################# ====================== #####################
# Localhost Network
################# ====================== #####################
variable "network" {
  description = "This is my localhost network for Docker"
  type        = string
}

################# ====================== #####################
# Containers ipv4 Address
################# ====================== #####################
variable "postgres_ipv4" {
  description = "Postgres ipv4 Address"
  type        = string
}

variable "pgAdmin_ipv4" {
  description = "pgAdmin ipv4 Adress"
  type        = string
}

variable "python_ipv4" {
  description = "Python ipv4 Adress"
  type        = string
}


################# ====================== #####################
# Postgres 
################# ====================== #####################
variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgres_version" {
    description = "Postgres Version"
    type = string
}

################# ====================== #####################
# pgAdmin
################# ====================== #####################
variable "pgAdmin_version" {
  description = "pgAdmin Version"
  type = string
}

variable "pgAdmin_email" {
  description = "pgAdmin root email address"
  type = string
}

variable "pgAdmin_password" {
  description = "pgAdmin root Password"
  type = string
}

################# ====================== #####################
# Python  
################# ====================== #####################
variable "python_version" {
    description = "Python version"
    type = string
}

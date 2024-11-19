################# ====================== #####################
# Start or Not 
################# ====================== #####################
variable "deploy_postgres" {
  description = "Flag to determine if pgAdmin should be deployed"
  type        = bool
  default     = true
}

variable "deploy_python" {
  description = "Flag to determine if pgAdmin should be deployed"
  type        = bool
  default     = true
}

variable "deploy_pgAdmin" {
  description = "Flag to determine if pgAdmin should be deployed"
  type        = bool
  default     = false
}

################# ====================== #####################
# Localhost Network
################# ====================== #####################
variable "network" {
  description = "This is my localhost network for Docker"
  type        = string
  default = "dahbest"
}

################# ====================== #####################
# Containers ipv4 Address
################# ====================== #####################
variable "postgres_ipv4" {
  description = "Postgres ipv4 Address"
  type        = string
  default = "172.80.0.20"
}

variable "pgAdmin_ipv4" {
  description = "pgAdmin ipv4 Adress"
  type        = string
  default = "172.80.0.21"
}

variable "python_ipv4" {
  description = "Python ipv4 Adress"
  type        = string
  default = "172.80.0.110"
}


################# ====================== #####################
# Postgres 
################# ====================== #####################
variable "postgres_user" {
  description = "PostgreSQL user name"
  type        = string
  default = "cagri"
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  default = "3541"
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
  default = "mydb"
}

variable "postgres_host" {
  description = "PostgreSQL database host IP"
  type        = string
  default = "postgres"
}

variable "postgres_port" {
  description = "PostgreSQL database port"
  type        = string
  default = "5432"
}

variable "postgres_version" {
    description = "Postgres Version"
    type = string
    default = "17"
}

################# ====================== #####################
# pgAdmin
################# ====================== #####################
variable "pgAdmin_version" {
  description = "pgAdmin Version"
  type = string
  default = "8.13"
}

variable "pgAdmin_email" {
  description = "pgAdmin root email address"
  type = string
  default = "mucagriaktas@gmail.com"
}

variable "pgAdmin_password" {
  description = "pgAdmin root Password"
  type = string
  default = "35413541"
}

################# ====================== #####################
# Python - Spark  
################# ====================== #####################
variable "python_version" {
    description = "Python version"
    type = string
    default = "3.13"
}

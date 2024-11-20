terraform {
  source = "${get_parent_terragrunt_dir()}/modules/docker"
}

remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/terra_configs/terraform-${path_relative_to_include()}.tfstate"
  }
}

inputs = {
  # Docker Local Network
  network              = "dahbest"
  
  # Postgres
  deploy_postgres      = true
  postgres_version     = "17"
  postgres_user        = "cagri"
  postgres_password    = "35413541"
  postgres_db          = "mydb"
  postgres_ipv4        = "172.80.0.20"

  # pgAdmin
  deploy_pgAdmin       = true
  pgAdmin_version      = "8.13.0"
  pgAdmin_email        = "mucagriaktas@gmail.com"
  pgAdmin_password     = "35413541"
  pgAdmin_ipv4         = "172.80.0.21"

  # Python
  deploy_python        = true
  python_version       = "3.13"
  python_ipv4          = "172.80.0.110"
}

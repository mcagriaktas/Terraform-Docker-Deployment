terraform {
  source = "${get_parent_terragrunt_dir()}/modules/kubernetes"
}

remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/terra_configs/terraform-${path_relative_to_include()}.tfstate"
  }
}

inputs = {
  # Kubernetes Namespace
  k8s_namespace           = "terraform"
  
  # Postgres
  deploy_postgres         = true
  postgres_version        = "17"
  postgres_user           = "postgres"  
  postgres_password       = "postgres123"
  postgres_db             = "postgres"

  # pgAdmin
  deploy_pgAdmin          = true
  pgAdmin_version         = "8.13.0"
  pgAdmin_email           = "mucagriaktas@gmail.com"
  pgAdmin_password        = "35413541"
  pgAdmin_port            = "8080"

  # Python
  deploy_python           = true
  python_version          = "3.13"
}

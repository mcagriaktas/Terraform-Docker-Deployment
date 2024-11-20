include {
  path = find_in_parent_folders()
}

inputs = {
  deploy_postgres = true
  deploy_pgAdmin  = true
  deploy_python   = true

  postgres_ipv4 = "172.80.0.20"
  pgAdmin_ipv4  = "172.80.0.21"
  python_ipv4   = "172.80.0.110"

  postgres_user     = "prod_user"
  postgres_password = "prod_pass"
  postgres_db       = "prod_db"

  pgAdmin_email    = "prod_admin@example.com"
  pgAdmin_password = "prod_pass"
}

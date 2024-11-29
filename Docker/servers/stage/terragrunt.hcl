include {
  path = find_in_parent_folders()
}

inputs = {
  # Deployment flags
  deploy_postgres = true
  deploy_pgAdmin  = true
  deploy_python   = true

  # Network configuration
  postgres_ipv4 = "172.80.0.20"
  pgAdmin_ipv4  = "172.80.0.21"
  python_ipv4   = "172.80.0.110"

  # Postgres configuration
  postgres_user     = "stage_user"
  postgres_password = "stage_pass"
  postgres_db       = "stage_db"

  # PgAdmin configuration
  pgAdmin_email    = "stage_admin@example.com"
  pgAdmin_password = "stage_pass"
}

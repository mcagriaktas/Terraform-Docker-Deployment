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
  postgres_user     = "test_user"
  postgres_password = "test_pass"
  postgres_db       = "test_db"

  # PgAdmin configuration
  pgAdmin_email    = "test_admin@example.com"
  pgAdmin_password = "test_pass"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  # Deployment flags
  deploy_postgres = true
  deploy_pgAdmin  = true
  deploy_python   = true

  # Postgres configuration
  postgres_db             = "dev_db"

  # PgAdmin configuration
  pgAdmin_email    = "dev_admin@example.com"
  pgAdmin_password = "dev_pass"
}
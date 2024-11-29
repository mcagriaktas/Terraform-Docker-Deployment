include {
  path = find_in_parent_folders()
}

inputs = {
  # Deployment flags
  deploy_postgres = true
  deploy_pgAdmin  = true
  deploy_python   = true

  # Postgres configuration
  postgres_db       = "uat_db"

  # PgAdmin configuration
  pgAdmin_email    = "uat_admin@example.com"
  pgAdmin_password = "uat_pass"
}
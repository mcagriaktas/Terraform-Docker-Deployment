# Container Deployment Guide with Terraform - Terragrunt - Terratest

## Prerequisites
- Terragrunt installed
- Git
- Docker
- Go (for running tests)

## Important Container Configuration Notes

### Volume Management
1. **Python Container**: After cloning the repository, update the Python volume path in your configuration to match your local environment.

2. **PostgreSQL Container**: The volume path must be cleaned before each `terragrunt apply` operation to ensure proper deployment. This prevents conflicts with existing data.

### Volume Configuration
Volumes can be configured in `module/docker/main.tf`. While it's possible to parameterize volumes as variables, this guide demonstrates direct volume configuration in the `main.tf` file for clarity.

Example volume configuration:
```hcl
resource "docker_container" "container" {
  # ... other configuration ...
  volumes {
    host_path      = "/Terraform-Docker-Deployment/modules/docker/containers/python/scripts" 
    container_path = "/mnt/scripts"
  }
}
```

## Deployment Instructions

### Basic Commands
Navigate to your environment directory and run:
```bash
cd servers/dev          # Replace 'dev' with your target environment
terragrunt init         # Initialize Terragrunt configuration
terragrunt plan         # Preview changes
terragrunt apply        # Apply changes
terragrunt destroy      # Tear down infrastructure
```

### Configuration Management
1. **Default Values**: 
   - The root `terragrunt.hcl` file contains default values for all environments
   - If no specific values are set in your environment's `terragrunt.hcl`, the defaults will be used

2. **Container Selection**:
   - Container deployment can be controlled in your environment's directory (`servers/dev` or similar)
   - Look for the `# Deployment flags` section to enable/disable specific containers

## Testing

### Running Tests
The project includes Terratest scripts to verify deployments. Tests perform the following:
- Deploy and destroy infrastructure
- Verify container image existence
- Run containers and validate output against expected results

To run tests:
```bash
cd terra_test
go test -v
```

### Test Configuration
By default, tests run against the `servers/dev` environment. To test different environments, modify the `test_test.go` file:

```go
testServerPath := "../servers/dev"  // Modify this path for other environments
```

### Test Success Criteria
- Tests will output "ok" upon successful completion
- All container validations must pass
- The test.txt file content must match expectations

## Best Practices
1. Always clean PostgreSQL volumes before redeployment
2. Verify volume paths after repository cloning
3. Run tests before production deployments
4. Keep environment-specific configurations in their respective `terragrunt.hcl` files

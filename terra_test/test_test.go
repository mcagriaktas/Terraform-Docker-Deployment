package test

import (
	"testing"


	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformDockerDeployment(t *testing.T) {
	t.Parallel()

	// Terraform options for Terragrunt
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:   "../servers/dev",
		TerraformBinary: "terragrunt",
	})

	// Clean up resources at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Apply the infrastructure using Terragrunt
	terraform.InitAndApply(t, terraformOptions)
}

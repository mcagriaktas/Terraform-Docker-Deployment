package test

import (
	"testing"
	"fmt"

	"github.com/gruntwork-io/terratest/modules/docker"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformDockerDeployment(t *testing.T) {
	t.Parallel()

	test_server := "../servers/dev"
	// Terraform options for Terragrunt
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:   test_server,
		TerraformBinary: "terragrunt",
	})

	// Clean up resources at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Apply the infrastructure using Terragrunt
	terraform.InitAndApply(t, terraformOptions)

	// Checking if the Docker image exists (make sure it's referenced from the correct module)
	pythonVersion := terraform.Output(t, terraformOptions, "python_version")
	pythonImage := fmt.Sprintf("python:%s", pythonVersion)

	imageLabel := pythonImage
	if docker.DoesImageExist(t, imageLabel, nil) {
		t.Logf("Image %s exists", imageLabel)
	} else {
		t.Errorf("Image %s does not exist", imageLabel)
	}
}
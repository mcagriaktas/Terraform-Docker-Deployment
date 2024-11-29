package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/docker"
	"github.com/gruntwork-io/terratest/modules/shell"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformDockerDeployment(t *testing.T) {
	t.Parallel()

	testServerPath := "../servers/dev"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:    testServerPath,
		TerraformBinary: "terragrunt",
	})

	// Clean up resources at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Apply Terraform configurations to start the container
	terraform.InitAndApply(t, terraformOptions)

	// Check if the Docker image exists
	pythonVersion := terraform.Output(t, terraformOptions, "python_version")
	pythonImage := fmt.Sprintf("python:%s", pythonVersion)

	if docker.DoesImageExist(t, pythonImage, nil) {
		t.Logf("Image %s exists", pythonImage)
		validatePythonContainer(t, terraformOptions)
	} else {
		t.Errorf("Image %s does not exist", pythonImage)
	}
}

func validatePythonContainer(t *testing.T, terraformOptions *terraform.Options) {
	// Get the Python container name from Terraform output
	containerName := terraform.Output(t, terraformOptions, "python_container_name")

	// Construct the Docker CLI command to read the file from the running container
	cmd := shell.Command{
		Command: "docker",
		Args:    []string{"exec", containerName, "cat", "/mnt/config/test.txt"},
	}

	// Run the command and capture the output
	output, err := shell.RunCommandAndGetOutputE(t, cmd)
	assert.NoError(t, err, "Failed to execute docker command")

	// Validate the contents of the file
	expectedOutput := "Hello, World!"
	assert.Equal(t, expectedOutput, output)
}

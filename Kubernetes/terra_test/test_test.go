package test

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

func TestTerraformKubernetesDeployment(t *testing.T) {
	t.Parallel()
	testServerPath := "../servers/dev"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:    testServerPath,
		TerraformBinary: "terragrunt",
	})

	// Clean up resources at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Apply Terraform configurations
	terraform.InitAndApply(t, terraformOptions)

	namespace := "terraform"
	kubectlOptions := k8s.NewKubectlOptions("", "", namespace)

	// Wait for pods with retry
	retry.DoWithRetry(t, "Waiting for Python pods", 3, 10*time.Second, func() (string, error) {
		filters := metav1.ListOptions{
			LabelSelector: "app=python-app",
		}
		pods := k8s.ListPods(t, kubectlOptions, filters)
		if len(pods) == 0 {
			return "", fmt.Errorf("No Python pods found")
		}
		t.Logf("Found %d Python pods", len(pods))
		return "", nil
	})

	// Get pods for validation
	filters := metav1.ListOptions{
		LabelSelector: "app=python-app",
	}
	pods := k8s.ListPods(t, kubectlOptions, filters)
	if len(pods) > 0 {
		validatePythonPod(t, kubectlOptions, pods[0].Name)
	} else {
		t.Fatal("No Python pods found for validation")
	}
}

func validatePythonPod(t *testing.T, kubectlOptions *k8s.KubectlOptions, podName string) {
	t.Logf("Validating pod: %s", podName)

	retry.DoWithRetry(t, "Checking file content in pod", 3, 10*time.Second, func() (string, error) {
		output, err := k8s.RunKubectlAndGetOutputE(t, kubectlOptions,
			"exec",
			podName,
			"--",
			"cat",
			"/mnt/config/test.txt")

		if err != nil {
			t.Logf("Error reading file: %v", err)
			return "", err
		}

		t.Logf("File content: %s", output)
		expectedOutput := "Hello, World!"
		assert.Equal(t, expectedOutput, output)
		return "", nil
	})
}

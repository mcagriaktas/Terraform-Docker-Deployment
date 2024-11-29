provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = var.k8s_namespace
  }
}

terraform {
  backend "local" {
    path = "terraform_configs/terraform.tfstate"
  }
}
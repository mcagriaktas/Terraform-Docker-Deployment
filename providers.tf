terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  backend "local" {
    path = "terraform_config/terraform.tfstate"
  }
}

provider "docker" {}

data "docker_network" "dahbest" {
  name = var.network
}
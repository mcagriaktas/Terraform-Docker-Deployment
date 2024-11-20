terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }

  backend "local" {}

}

provider "docker" {}

data "docker_network" "dahbest" {
  name = var.network
}
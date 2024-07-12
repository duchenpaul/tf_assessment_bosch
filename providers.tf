terraform {
  required_providers {
    enos = {
      source = "hashicorp-forge/enos"
      version = "0.5.2"
    }
  }
}

provider "enos" {
  # Configuration options
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    resource_group {
       prevent_deletion_if_contains_resources = false
     }
  }
}

resource "azurerm_resource_group" "exercicio-apache" {
  name     = "exercicio-apache"
  location = "East US"

  tags = {
    faculdade = "Impacta"
    turma     = "fs05"
    matricula = "2202147"
    aluna     = "Rebeca Menezes Costa"
  }
}

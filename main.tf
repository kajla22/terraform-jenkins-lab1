terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "6517-rg-jenkins"
    storage_account_name = "6517tfstatestorage123"
    container_name       = "kajla-terraform-state"
    key                  = "jenkins-kajla.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = "6517-rg-jenkins"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "6517-JenkinsVNet"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "backend_rg" {
  name     = "dewa0117-githubactions-rg"
  location = "canadacentral"
}

resource "azurerm_storage_account" "backend_storage_account" {
  name                     = "dewa0117githubaction"
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    environment = "backend"
  }
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backend_storage_account.name
  container_access_type = "private"
}

output "resource_group_name" {
  value = azurerm_resource_group.backend_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.backend_storage_account.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate_container.name
}

output "primary_access_key" {
  value     = azurerm_storage_account.backend_storage_account.primary_access_key
  sensitive = true
}

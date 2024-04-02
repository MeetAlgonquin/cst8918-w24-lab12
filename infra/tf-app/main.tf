provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "app_rg" {
  name     = "dewa0117-a12-rg"
  location = "canadacentral"
}

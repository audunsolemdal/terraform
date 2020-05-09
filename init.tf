terraform {
  backend "azurerm" {
    resource_group_name  = "sdp-common-infrastructure"
    storage_account_name = "sdpterraform"
    container_name       = "tfstate-prod"
    key                  = "tfstate"
  }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
        name = "sdp-common-infrastructure"
        location = "norwayeast"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "sdpterraform"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "production"
  }
}

resource "azurerm_storage_container" "tfstate-prod" {
  name                  = "tfstate-prod"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}
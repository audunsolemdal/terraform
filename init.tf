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
  subscription_id = var.sub
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"

  features {}
}

resource "azurerm_resource_group" "rg" {
        name = "sdp-common-infrastructure"
        location = "norwayeast"
}

resource "azurerm_management_lock" "resource-group-level" {
  name       = "resource-group-level"
  scope      = azurerm_resource_group.rg.id
  lock_level = "CanNotDelete"
  notes      = "Ensure resources in this RG cannot be deleted"
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
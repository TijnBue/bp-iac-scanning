terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_mysql_flexible_server" "example" {
  name                   = "example-fs"
  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  administrator_login    = "psqladmin"
  administrator_password =  "H@Sh1CoR3!"
  backup_retention_days  = 7
  sku_name               = "GP_Standard_D2ds_v4"
}


resource "azurerm_mysql_flexible_server" "example_2" {
  name                   = "example-fs-2"
  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  administrator_login    = "psqladmin"
  administrator_password =  "4-v3ry-53cr37-p455w0rd"
  backup_retention_days  = 7
  sku_name               = "GP_Standard_D2ds_v4"
}



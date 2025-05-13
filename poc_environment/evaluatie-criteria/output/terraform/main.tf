terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}
provider "azurerm" {
  features {}
}
locals {
  test_description = "set up sql server that doesn't have a public access"
  test_name        = "PublicAccessSqlDatabaseRule-test"
  resource_prefix = "test"
}
resource "azurerm_resource_group" "tests-resource-group" {
  name     = "${local.resource_prefix}resourcegroup"
  location = "West Europe"
}

resource "azurerm_mssql_server" "my-sql-server" {
  name                          = "${local.resource_prefix}sqlserver"
  resource_group_name           = azurerm_resource_group.tests-resource-group.name
  location                      = azurerm_resource_group.tests-resource-group.location
  version                       = "12.0"
  administrator_login           = "4dm1n157r470r"
  administrator_login_password  = "4-v3ry-53cr37-p455w0rd"
  public_network_access_enabled = true

  tags = {
    ResScope = local.test_description
  }
}


resource "azurerm_sql_database" "my-sql-database" {
  name                = "${local.resource_prefix}sqldatabase"
  resource_group_name = azurerm_resource_group.tests-resource-group.name
  location            = azurerm_resource_group.tests-resource-group.location
  server_name         = azurerm_mssql_server.my-sql-server.name

  tags = {
    ResScope = local.test_description
  }
}

resource "azurerm_sql_firewall_rule" "example" {
  name                = "allow inbound internet"
  resource_group_name = azurerm_resource_group.tests-resource-group.name
  server_name         = azurerm_mssql_server.my-sql-server.name
  start_ip_address    = "79.181.213.138"
  end_ip_address      = "79.181.213.138"
}
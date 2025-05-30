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

resource "azurerm_security_center_contact" "example" {
  name = "Contact"
  email = "contact@example.com"

  #phone = "+1-555-555-5555"

  alert_notifications = false
  alerts_to_admins    = false
}
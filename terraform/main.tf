# terraform {
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Uk South"
}

# Storage account with insecure settings for Trivy to find
resource "azurerm_storage_account" "example" {
  name                     = "examplestorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security issues Trivy should detect:
  public_network_access_enabled = true     # Security issue: public blob access
  min_tls_version               = "TLS1_0" # Security issue: outdated TLS
  https_traffic_only_enable     = false    # Security issue: HTTP allowed
}


resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "log-analytics-${var.humber_id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days

  tags = {
    Environment = "Learning"
  }
}

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = "recovery-vault-${var.humber_id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = local.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "storage${var.humber_id}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}


output "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.log_workspace.name
}


output "recovery_vault_name" {
  description = "The name of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.recovery_vault.name
}


output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage_account.name
}


output "storage_account_blob_endpoint" {
  description = "The blob endpoint of the Storage Account"
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}

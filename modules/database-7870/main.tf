resource "azurerm_postgresql_server" "db_server" {
  name                          = "db-server-${var.humber_id}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku_name                      = "GP_Gen5_2"
  version                       = "11"
  administrator_login           = var.admin_username
  administrator_login_password  = var.admin_password
  storage_mb                    = var.storage_mb
  backup_retention_days         = var.backup_retention_days
  auto_grow_enabled             = var.auto_grow_enabled
  public_network_access_enabled = var.public_network_access_enabled
  ssl_enforcement_enabled       = true
}

resource "azurerm_postgresql_database" "db" {
  name                = "database-${var.humber_id}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db_server.name
  charset             = "UTF8"
  collation           = "en_US.UTF8"
}

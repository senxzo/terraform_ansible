output "db_server_name" {
  description = "The name of the PostgreSQL server instance"
  value       = azurerm_postgresql_server.db_server.name
}

output "db" {
  description = "The name of the PostgreSQL Database"
  value       = azurerm_postgresql_database.db.name
}

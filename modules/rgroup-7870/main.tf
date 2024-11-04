resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-${var.humber_id}"
  location = var.location
}

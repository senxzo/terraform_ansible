resource "azurerm_managed_disk" "data_disk" {
  count                = 3
  name                 = "datadisk-${var.humber_id}-${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  for_each           = var.vm_ids
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = each.value
  lun                = each.key
  caching            = "ReadWrite"
}

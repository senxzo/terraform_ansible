output "disk_names" {
  description = "Names of the data disks"
  value       = azurerm_managed_disk.data_disk[*].name
}

output "attached_disks" {
  description = "Attached data disks for the VMs"
  value       = [for i in azurerm_virtual_machine_data_disk_attachment.data_disk_attachment : i.managed_disk_id]
}

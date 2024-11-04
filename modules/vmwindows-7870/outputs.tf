output "hostname" {
  value = azurerm_windows_virtual_machine.windows_vm[*].name
}

output "domain_name" {
  value = azurerm_public_ip.windows_pip[*].domain_name_label
}

output "private_ip" {
  value = azurerm_network_interface.windows_nic[*].private_ip_address
}

output "public_ip" {
  value = azurerm_public_ip.windows_pip[*].ip_address
}

output "wm_fqdn" {
  value = azurerm_public_ip.windows_pip[*].fqdn
}

output "vm4_id" {
  value = azurerm_windows_virtual_machine.windows_vm[*].id
}

output "wm_private_ip" {
  value = azurerm_network_interface.windows_nic[*].ip_configuration[0].private_ip_address
}

output "wm_public_ip" {
  value = azurerm_public_ip.windows_pip[*].ip_address
}

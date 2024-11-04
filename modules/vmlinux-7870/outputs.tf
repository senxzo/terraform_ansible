
output "vm_hostnames" {
  description = "The hostnames of the VMs"
  value       = { for vm in azurerm_linux_virtual_machine.linux_vm : vm.name => vm.computer_name }
}


output "vm_public_ips" {
  description = "The public IP addresses of the VMs"
  value       = { for vm in azurerm_public_ip.linux_pip : vm.name => vm.ip_address }
}


output "vm_private_ips" {
  description = "The private IP addresses of the VMs"
  value       = { for vm in azurerm_network_interface.linux_nic : vm.name => vm.private_ip_address }
}

output "vm_fqdns" {
  description = "The FQDNs of the public IPs for each VM"
  value       = { for vm, pip in azurerm_public_ip.linux_pip : vm => pip.fqdn }
}

output "vm_dns_names" {
  description = "The DNS names of the VMs"
  value       = { for pip in azurerm_public_ip.linux_pip : pip.name => pip.domain_name_label }
}

output "vm1_id" {
  value = azurerm_linux_virtual_machine.linux_vm["vm1"].id
}

output "vm2_id" {
  value = azurerm_linux_virtual_machine.linux_vm["vm2"].id
}

output "vm3_id" {
  value = azurerm_linux_virtual_machine.linux_vm["vm3"].id
}

output "vm1_nic_id" {
  value = azurerm_network_interface.linux_nic["vm1"].id
}

output "vm2_nic_id" {
  value = azurerm_network_interface.linux_nic["vm2"].id
}

output "vm3_nic_id" {
  value = azurerm_network_interface.linux_nic["vm3"].id
}
output "vm_private_ip" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.ip_configuration[0].private_ip_address]
}

output "vm_public_ip" {
  value = { for ip in azurerm_public_ip.linux_pip : ip.name => ip.ip_address }
}

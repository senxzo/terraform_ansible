output "log_analytics_workspace_name" {
  value = module.common_services_7870.log_analytics_workspace_name
}

output "recovery_vault_name" {
  value = module.common_services_7870.recovery_vault_name
}

output "storage_account_name" {
  value = module.common_services_7870.storage_account_name
}

output "database_name" {
  value = module.database_7870.db
}

output "load_balancer_name" {
  value = module.loadbalancer_7870.load_balancer_name
}

output "networking_rg" {
  value = module.resource_group.resource_group_name
}

output "linux_vm_hostnames" {
  value = module.vmlinux_7870.vm_hostnames
}

output "wm_hostname" {
  value = module.vmwindows_7870.hostname
}

output "vm_fqdns" {
  value = module.vmlinux_7870.vm_fqdns
}

output "wm_fqdn" {
  value = module.vmwindows_7870.wm_fqdn
}

output "wm_private_ip" {
  value = module.vmwindows_7870.wm_private_ip
}
output "vm_private_ip" {
  value = module.vmlinux_7870.vm_private_ip
}
output "vm_public_ip" {
  value = module.vmlinux_7870.vm_public_ip
}

output "wm_public_ip" {
  value = module.vmwindows_7870.wm_public_ip
}

output "subnet_name" {
  value = module.network_7870.subnet_name
}

output "subnet_id" {
  value = module.network_7870.subnet_id
}

output "virtual_network_name" {
  value = module.network_7870.virtual_network_name
}
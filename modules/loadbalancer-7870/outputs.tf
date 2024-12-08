output "load_balancer_name" {
  description = "The name of the Load Balancer"
  value       = azurerm_lb.load_balancer.name
}
output "load_balancer_fqdn" {
  value       = azurerm_public_ip.lb_public_ip.fqdn
  description = "The Fully Qualified Domain Name (FQDN) of the Load Balancer"
}
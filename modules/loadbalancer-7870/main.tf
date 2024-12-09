resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.humber_id}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "lb-${var.humber_id}-dns" 
}

resource "azurerm_lb" "load_balancer" {
  name                = "lb-${var.humber_id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name            = "${var.humber_id}-backend-pool"
  loadbalancer_id = azurerm_lb.load_balancer.id
}

resource "azurerm_lb_probe" "lb_probe" {
  name                = "${var.humber_id}-probe"
  loadbalancer_id     = azurerm_lb.load_balancer.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "${var.humber_id}-lb-rule"
  loadbalancer_id                = azurerm_lb.load_balancer.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.lb_probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_association" {
  for_each = var.vm_nics

  network_interface_id    = each.value  # Pass NIC ID dynamically
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
  ip_configuration_name   = "ipconfig1"  # Ensure this matches the configuration name in your NICs
}


resource "azurerm_availability_set" "vm_availability_set" {
  name                = "availability-set-${var.humber_id}"
  location            = var.location
  resource_group_name = var.resource_group_name

  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}


resource "azurerm_public_ip" "linux_pip" {
  for_each            = { for vm in ["vm1", "vm2", "vm3"] : vm => "${vm}-${var.humber_id}-pip" }
  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  domain_name_label   = "${each.key}-${var.humber_id}"

  tags = local.tags
}


resource "azurerm_network_interface" "linux_nic" {
  for_each            = { for vm in ["vm1", "vm2", "vm3"] : vm => "${vm}-${var.humber_id}-nic" }
  name                = each.value
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }

  tags = local.tags
}


resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = {
    vm1 = "${var.humber_id}-vm1"
    vm2 = "${var.humber_id}-vm2"
    vm3 = "${var.humber_id}-vm3"
  }

  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id
  ]
  availability_set_id = azurerm_availability_set.vm_availability_set.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_blob_endpoint
  }


  computer_name = each.value
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  provision_vm_agent = true
}


resource "azurerm_virtual_machine_extension" "network_watcher_extension" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  name                 = "networkwatcher-${each.key}"
  virtual_machine_id   = each.value.id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"

  depends_on = [azurerm_linux_virtual_machine.linux_vm]
}


resource "azurerm_virtual_machine_extension" "monitor_extension" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  name                       = "monitoragent-${each.key}"
  virtual_machine_id         = each.value.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.27"
  auto_upgrade_minor_version  = true
  
  # lifecycle {
  #   prevent_destroy = true
  # }

  settings = jsonencode({
    commandToExecute = "hostname && uptime"
  })

  protected_settings = jsonencode({})

  depends_on = [azurerm_linux_virtual_machine.linux_vm]
}


resource "azurerm_availability_set" "windows_avset" {
  count                        = var.vm_count
  name                         = "windows-avset-${var.humber_id}"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
}

resource "azurerm_public_ip" "windows_pip" {
  count               = var.vm_count
  name                = "windows-pip-${var.humber_id}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "wm-${var.humber_id}-${count.index}-dmnlabel"
}

resource "azurerm_network_interface" "windows_nic" {
  count               = var.vm_count
  name                = "windows-nic-${var.humber_id}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "windows-ipcfg-${var.humber_id}-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip[count.index].id
  }
}


resource "azurerm_windows_virtual_machine" "windows_vm" {
  count                 = var.vm_count
  name                  = "windows-vm-${var.humber_id}-${count.index}" # Check if this exceeds 15 characters
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.windows_nic[count.index].id]
  size                  = var.vm_size
  availability_set_id   = azurerm_availability_set.windows_avset[count.index].id
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  # Ensure computer_name is at most 15 characters
  computer_name         = substr("windowsvm${count.index}", 0, 15)  # Adjust the naming convention as needed

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_blob_endpoint
  }
}


resource "azurerm_virtual_machine_extension" "antimalware" {
  count                = var.vm_count
  name                 = "Antimalware-${var.humber_id}-${count.index}"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows_vm[count.index].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.5"
}

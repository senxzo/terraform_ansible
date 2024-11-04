resource "null_resource" "display_hostname" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  depends_on = [
    azurerm_linux_virtual_machine.linux_vm
  ]

  provisioner "remote-exec" {
    inline = [
      "hostname"
    ]

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file("~/.ssh/id_rsa")
      host        = azurerm_public_ip.linux_pip[each.key].ip_address 
    }
  }
}

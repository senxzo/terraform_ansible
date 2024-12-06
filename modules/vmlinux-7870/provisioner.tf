resource "null_resource" "ansibling" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  depends_on = [
    azurerm_linux_virtual_machine.linux_vm,
  ]
  triggers = {
    ip_address = azurerm_public_ip.linux_pip[each.key].ip_address
    config_version = timestamp() # Or any variable value that forces re-execution
  }
  connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file("~/.ssh/id_rsa")
      host        = azurerm_public_ip.linux_pip[each.key].ip_address
    }
provisioner "local-exec" {
  command = <<-EOT
    sleep 60
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${azurerm_public_ip.linux_pip[each.key].ip_address},' --extra-vars 'ansible_user=${var.admin_username} ansible_ssh_private_key_file=~/.ssh/id_rsa' ./project/n01657870-playbook.yml
  EOT
  }
}

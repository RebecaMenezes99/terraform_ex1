resource "null_resource" "install-apache" {
  triggers = {
    order = azurerm_virtual_machine.vm-apache.id
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = azurerm_public_ip.ip-apache.ip_address
      user     = var.user
      password = var.password
    }
    inline = [
      "sudo apt update",
      "sudo apt install -y apache2"
    ]
  }
}
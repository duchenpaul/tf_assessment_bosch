resource "azurerm_key_vault_secret" "password_secret" {
  count        = var.vm_count
  name         = "password-secret-${count.index}"
  value        = random_password.password[count.index].result
  key_vault_id = azurerm_key_vault.main.id
}

resource "azurerm_network_interface" "main" {
  count               = var.vm_count
  name                = "nic-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vnet_use_existing ? data.azurerm_subnet.existing_subnet.id : azurerm_subnet.main[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  count                         = var.vm_count
  name                          = "vm-${count.index}"
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  network_interface_ids         = [element(azurerm_network_interface.main.*.id, count.index)]
  vm_size                       = var.vm_size
  delete_os_disk_on_termination = true

  storage_os_disk {
    name              = "osdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = var.vm_image
    sku       = var.vm_sku
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname-${count.index}"
    admin_username = var.admin_username
    admin_password = element(random_password.password.*.result, count.index)
  }

  os_profile_linux_config {
    disable_password_authentication = false
    dynamic "ssh_keys" {
      for_each = var.owner_details
      content {
        key_data = ssh_keys.value["pubkey"]
        path     = ssh_keys.value["path"]
      }
    }
  }

  connection {
    type     = "ssh"
    user     = var.admin_username
    password = element(random_password.password.*.result, count.index)
    host     = element(azurerm_network_interface.main.*.private_ip_address, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${element(random_password.password.*.result, count.index)}' | sudo -S apt-get update -y",
      "echo '${element(random_password.password.*.result, count.index)}' | sudo -S apt-get install -y iputils-ping",
      "touch /home/azureuser/.ssh/authorized_keys",
      "chmod 600 /home/azureuser/.ssh/authorized_keys"
    ]
  }

}

resource "enos_remote_exec" "print_results" {
  count = var.vm_count

  depends_on = [
    azurerm_virtual_machine.main,
    azurerm_network_interface.main,
  ]
  inline = ["ping -c 3 ${azurerm_network_interface.main[(count.index + 1) % var.vm_count].private_ip_address}"]

  transport = {
    ssh = {
      user             = var.admin_username
      private_key_path = var.private_key_path
      host             = element(azurerm_network_interface.main.*.private_ip_address, count.index)
    }
  }
}

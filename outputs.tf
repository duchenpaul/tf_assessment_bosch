output "vm_ips" {
  description = "Private IP addresses of the VMs"
  value       = azurerm_network_interface.main.*.private_ip_address
}


output "ping_results" {
  description = "Ping results from VMs"
  value = [
    for i in range(var.vm_count) :
    "${azurerm_virtual_machine.main[i].name}: ${enos_remote_exec.print_results[i].stdout}"
  ]
}

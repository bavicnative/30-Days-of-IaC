output "public_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "resource_group" {
  value = azurerm_resource_group.rg.name
}
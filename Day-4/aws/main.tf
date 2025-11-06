# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "day4-vars-rg"
  location = var.location
  tags     = var.tags
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "day4-vars-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags
}

# Subnet (using list variable)
resource "azurerm_subnet" "subnet" {
  name                 = "day4-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefixes
}

# Conditional Public IP
resource "azurerm_public_ip" "pip" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "day4-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  tags                = var.tags
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "day4-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.pip[0].id : null
  }

  tags = var.tags
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "day4-var-vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = var.admin_password   # 👈 Replace with a strong password
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "Ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.disk_size_gb  # Number variable in action
  }
  
  tags = var.tags
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
provider "azurerm" {
  features {}
  client_id       = ""
  tenant_id       = ""
  subscription_id = ""
  client_secret   = ""
}

resource "azurerm_resource_group" "RG1" {
  name     = var.RgName
  location = var.RGlocation
}

resource "azurerm_virtual_network" "myvnet" {
  name                = var.vnetName
  address_space       = var.vnetAddress
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
}

resource "azurerm_subnet" "mysnet" {
  count                = length(var.subnet_address_prefixes)
  name                 = element(var.subnetnames, count.index)
  resource_group_name  = azurerm_resource_group.RG1.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
  service_endpoints    = ["Microsoft.Storage"]

}

resource "azurerm_network_interface" "nics" {
  count               = length(var.privateaddresses)
  name                = element(var.nicnames, count.index)
  resource_group_name = azurerm_resource_group.RG1.name
  location            = azurerm_resource_group.RG1.location
  ip_configuration {
    name                          = element(var.ipconfignames,count.index)
    subnet_id                     = azurerm_subnet.mysnet[count.index].id
    private_ip_address_allocation = "static"
    private_ip_address            = var.privateaddresses[count.index]
  }
}

resource "azurerm_public_ip" "pip" {
  name                = var.pubip
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bhost" {
  name                = var.basthost
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.mysnet[2].id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vms" {
  count                           = length(var.vmnames)
  name                            = element(var.vmnames, count.index)
  resource_group_name             = azurerm_resource_group.RG1.name
  location                        = azurerm_resource_group.RG1.location
  size                            = "Standard_B2s"
  admin_username                  = element(var.vmunames, count.index)
  admin_password                  = var.vmpasswds
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nics[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }


  source_image_reference {
    publisher = element(var.vm_os, count.index) == "UbuntuServer" ? var.ubuntu_publisher : var.centos_publisher
    offer     = element(var.vm_os, count.index) == "UbuntuServer" ? var.ubuntu_offer : var.centos_offer
    sku       = element(var.vm_os, count.index) == "UbuntuServer" ? var.ubuntu_sku : var.centos_sku
    version   = element(var.vm_os, count.index) == "UbuntuServer" ? "latest" : "latest"
  }
}
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage
  resource_group_name      = azurerm_resource_group.RG1.name
  location                 = azurerm_resource_group.RG1.location
  account_tier             = "Standard"
  account_replication_type = var.replitype
  network_rules {
    default_action = "Deny"
    virtual_network_subnet_ids = azurerm_subnet.mysnet[*].id
    
  }
}



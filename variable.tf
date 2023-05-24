variable "RgName" {
  type        = string
  description = "name of the resource"
  default     = "koushikRG"
}

variable "RGlocation" {
  type        = string
  description = "location of the resource "
  default     = "eastus"
}
variable "vnetName" {
  type        = string
  description = "name of the resource "
  default     = "koushik-network"
}
variable "vnetAddress" {
  type        = list(string)
  description = " vnet address"
  default     = ["192.168.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["192.168.0.0/26", "192.168.0.64/26", "192.168.0.128/26"]
}

variable "subnetnames" {
  type    = list(string)
  default = ["koushiksubnet1", "koushiksubnet2", "AzureBastionSubnet"]
}

variable "nicnames" {
  type    = list(string)
  default = ["koushiknic1", "koushiknic2"]
}

variable "privateaddresses" {
  type    = list(string)
  default = ["192.168.0.42", "192.168.0.100"]
}

variable "pubip" {
  type    = string
  default = "koushikpublicip"
}
variable "basthost" {
  type    = string
  default = "koushikbastion"
}

variable "vm_os" {
  description = "Operating System for the VMs"
  type        =list(string)
  default     = ["UbuntuServer", "CentOs"]
}

variable "vmnames" {
  type    = list(string)
  default = ["koushikvm1", "koushikvm2"]
}

variable "vmunames" {
  type    = list(string)
  default = ["koushik", "koushikdp"]
}

variable "vmpasswds" {
  type      = string
  sensitive = true
  default   = ""

}
variable "ipconfignames" {
  type    = list(string)
  default = ["nic1-ipconfig1", "nic2-ipconfig2"]

}
variable "storage" {
  type    = string
  default = "koushikstorageaccount123"

}

variable "replitype" {
  type    = string
  default = "LRS"
}

variable "ubuntu_publisher" {
  description = "Publisher for Ubuntu Server image"
  type        = string
  default     = "Canonical"
}

variable "ubuntu_offer" {
  description = "Offer for Ubuntu Server image"
  type        = string
  default     = "UbuntuServer"
}

variable "ubuntu_sku" {
  description = "SKU for Ubuntu Server image"
  type        = string
  default     = "18.04-LTS"
}

variable "centos_publisher" {
  description = "Publisher for CentOS image"
  type        = string
  default     = "OpenLogic"
}

variable "centos_offer" {
  description = "Offer for CentOS image"
  type        = string
  default     = "CentOS"
}

variable "centos_sku" {
  description = "SKU for CentOS image"
  type        = string
  default     = "7.7"
}


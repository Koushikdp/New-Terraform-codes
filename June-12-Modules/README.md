Terraform modules are reusable, self-contained packages of Terraform configurations that encapsulate a specific set of resources and their configurations. They provide a way to organize and modularize your infrastructure code, making it easier to manage and reuse across different projects and environments.

A Terraform module typically consists of a collection of Terraform configuration files written in HashiCorp Configuration Language (HCL) or JSON format. These files define the resources and their configurations that should be created when the module is used. Modules can be created for various infrastructure components such as virtual machines, networks, databases, load balancers, and more.





Example:

I have created a folder name Moduleexample under that im creating resource group and storage modules.

![Alt text](image.png)

![Alt text](image-1.png)

Under resource group i have created three files one is for defining resources and one is for its variable definition and the other is for output block.

**Resourcegroup-folder**
**Main.tf**

resource "azurerm_resource_group" "myrg" { 
  name     = var.RGName 
  location = var.RGLocation 


} 

**var.tf**

variable "RGName" { 
  type    = string 
} 
variable "RGLocation" { 
  type    = string 

} 

**Output.tf**

output "rg_name_out" {
    value=azurerm_resource_group.myrg.name
}


**Storageaccount-folder**

**main.tf**

 resource "azurerm_storage_account" "my_storage_account" { 
  name                     = var.sgName
  location                 = var.RGLocation
  resource_group_name      = var.RGName
  account_tier             = "Standard"
  account_replication_type = "GRS" 
}  


**var.tf**

variable "sgName" { 
  type    = string 

} 
variable "RGName" { 
  type    = string 

} 
variable "RGLocation" { 
  type    = string 

} 



Created two modules now. i want to use this modules, so i have created a main.tf file in another location i.e, in C drive where im going to use these modules to create the resources with out defining them again.

![Alt text](image-2.png)


**main.tf- using modules here**

terraform { 
  required_providers { 
    azurerm = { 
      source  = "hashicorp/azurerm" 
      version = "3.50.0" 
    } 
  } 
} 
provider "azurerm" { 

  # Configuration options for Azure 

  features {} 
  client_id       = "a6c6163b-607b-467d-9c3e-09dd4da70294" 
  tenant_id       = "0c45565b-c823-4469-9b6b-30989afb7a2e" 
  subscription_id = "738dfdc6-f0bd-407d-b899-c56640f7ce02" 
  client_secret   = "twx8Q~l4fmCpow4nX8GmhW4rHvL9Lm5MxG5Nvcl6" 
} 
  module "Resourcegroup" {
    source= "D:/testing/moduleexample/Resourcegroup"
    RGName = "mymoduleRg"
    RGLocation = "eastus"
  }
  module "storageaccount" {
    source="D:/testing/moduleexample/storageaccount"
    sgName = "deebugdiag345fg"
    RGName=module.Resourcegroup.rg_name_out
    RGLocation="eastus"
    
  }


  Im giving the location where the modules are stored. As of now all are normal files until the initialization happens.

  Once the initialization happens in testing folder in c drive the modules will get downloaded.

  After terraform init modukles folder got downloaded and strored in .Terraform folder.

  ![Alt text](image-3.png)
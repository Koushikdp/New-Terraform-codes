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
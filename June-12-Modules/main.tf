terraform { 

  required_providers { 

    azurerm = { 

      source  = "hashicorp/azurerm" 

      
      version = "3.50" 
    } 
  } 
} 
provider "azurerm" { 

  # Configuration options for Azure 

  features {} 
  client_id       = "" 
  tenant_id       = "" 
  subscription_id = "" 
  client_secret   = "" 
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

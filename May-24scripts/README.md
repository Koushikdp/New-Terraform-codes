                                                      Terraform

**Infrastructure as Code (IaC)** : IaC is the process of managing and provisioning resources as code(files) rather than physical configuration. 

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/a443d09a-3e76-4e88-ade2-2d55bc30c387)

**The Problem with Manual Configuration:**
* It's easy to mis-configure a service though human error 
* It's hard to manage the expected state of configuration for compliance  
* It's hard to transfer configuration knowledge to other team members. 
* Difficult to deploy multiple resources 

**Benefits of IAC**

* IAC is faster and can deploy multiple resources. 
* IAC can compare resources with its previous states. 
* IAC has a benefit of having the files in version control which improves security and accountability. 
* IAC helps in disaster recovery. 
* IAC helps in deploying resources through automation with less human errors. 

**Terraform** : It is a tool for building and changing and versioning infrastructure. It is more secure and can manage high- and low-level components. 
* Third party application developed by hashi corp 
* Uses hashi corp language 

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/be644a5a-4919-4f4e-853f-e3853ef69b85)

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/52872ed4-c1b6-4f58-8903-e4ab23882062)


**Blocks of Terraform**

##################################################################### 

# Block-1: Terraform Settings Block 
which defines the version of terraform to use and which provider to use in the file.

terraform {
    
required_version = ">= 1.0.0"

required_providers {

azurerm = {

source = "hashicorp/azurerm"

version = ">= 2.0"

} 

} 

# Terraform State Storage to Azure Storage Container 

  backend "azurerm" {

  resource_group_name   = "terraform-storage-rg"

  storage_account_name  = "terraformstate201"

  container_name        = "tfstatefiles"

  key                   = "terraform.tfstate"

  }
     

} 

##################################################################### 

# Block-2: Provider Block 
Providers allows terraform to communicate with the API present in file.

provider "azurerm" {

features {}

} 


##################################################################### 

# Block-3: Resource Block 
To Create resources

resource "azurerm_resource_group" "myrg" {

name = "myrg-1"

location = var.azure_region 

} 


##################################################################### 

# Block-4: Input Variables Block 
 Define a Input Variable for Azure Region 

variable "azure_region" {

default = "eastus"

description = "Azure Region where resources to be created"

type = string

} 

##################################################################### 

# Block-5: Output Values Block 
Output the Azure Resource Group ID 

output "azure_resourcegroup_id" {

description = "My Azure Resource Group ID"

value = azurerm_resource_group.myrg.id

} 

##################################################################### 

# Block-6: Local Values Block 
Define Local Value with Business Unit and Environment Name 
combined

locals {

name = "${var.business_unit}-${var.environment_name}"

} 

##################################################################### 

# Block-7: Data sources Block 
Use this data source to access information about an existing Resource Group. 

data "azurerm_resource_group" "example" {

name = "existing"

}

output "id" {

value = data.azurerm_resource_group.example.id

} 

##################################################################### 

# Block-8: Modules Block 

Azure Virtual Network Block using Terraform Modules (https://registry.terraform.io/modules/Azure/network/azurerm/latest) 
module "network" {

source              = "Azure/network/azurerm"

resource_group_name = azurerm_resource_group.example.name

ddress_spaces      = ["10.0.0.0/16", "10.2.0.0/16"]

subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

subnet_names        = ["subnet1", "subnet2", "subnet3"]

tags = {

environment = "dev"

costcenter  = "it"

}

depends_on = [azurerm_resource_group.example]

} 
##################################################################### 


**Connection to Azure using Terraform**

create an Azure Active Directory application that represents a client. Go to the Azure Active Directory and select App registrations.

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/e54cc5f4-050e-4420-8ec1-19d86d06f22e)

click on the New registration button on the top. It opens a new registration page in which you should give a name for the app.

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/8ee796d8-0503-42b3-893b-d54737e56bfa)

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/a7bc1554-518a-4ac5-b196-bcdf97000c96)

click the Register button, the application is created and you should note the client Id and tenant Id on the overview page

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/4e3a1474-0f3f-44d7-958c-9c0d3811170e)

click on the Certificates and secrets and add a new client secret

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/6029d851-f75c-4305-857f-1da26e3f5548)

Note the value in the newly created secret.

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/16869d8b-4211-4bb5-94d9-47fa24b34a60)

Go to the subscription and click on Access Control. Click on Add button to assign the Contributor role.

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/7c58f348-3b8e-4e50-8b43-904cdfd2809f)

we selected the application Terraform_CI and assigned a contributor role on this subscription. and click on review and assign

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/b546d973-9516-48df-8170-02c352024897)

Now we will have all 4 component details which is used for terraform to integrate with Azure.

client_id       = ""  --> can be found in Registered app page

tenant_id       = ""  --> can be found in Registered app page

subscription_id = "" --> can be found in subscription page

client_secret   = "" --> can be found in Registered app page

**creating first resource in Terraform**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/3e144d32-1b9c-4e7a-a48f-a6cf7f4cb517)

**Main.tf**  -> file name
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

client_id       = "" 

tenant_id       = "" 

subscription_id = "" 

client_secret   = "" 

} 

resource "azurerm_resource_group" "myrg" {

name = "myrg-1" 

location = "eastus"  

} 

**Once file is created save it and run following commands.**

Terraform init  -> will creates an initial .terraform directory in the project's root directory and dowload provider plugins.

Terraform validate ->  used to validate the syntax and configuration of your Terraform files without actually creating or modifying any infrastructure.

Terraform plan -out main.tfplan  -> used to create an execution plan for Terraform. -out flag in Terraform's plan command allows you to specify an output file where the execution plan will be saved.

Terraform fmt -> used to automatically format your Terraform configuration files.

Terraform apply main.tfplan -> used to apply the changes defined in your Terraform configuration and create or modify the resources accordingly


**Creating a variable file for the above and accessing in main file**

image.png

main.tf

terraform {

required_providers {

azurerm = {

source  = "hashicorp/azurerm" 

version = "3.50.0" 

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

resource "azurerm_resource_group" "myrg" {

  name     = var.RgName 

  location = var.RGlocation 

} 

**Variable.tf**

variable "RgName" { 

type        = string 

description = "name of the resource " 

default = "koushik-Rg"

} 

variable "RGlocation" { 

type        = string 

description = "name of the resource " 

default= "eastus"

} 

Now we can follow the same process of creating infra. Terraform will check the resources in main.tf  check for the variable files in that folder once found the variables file it will combine variables value to resources file.

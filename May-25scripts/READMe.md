May25

Completed tasks for today:

1. Deploying infra with out client and subscription id's.
2. Vm Password should be in encrypted mode
3. Vm passwords should store in Azure key vault & azure vm has to get the encrypted password from keyvault
4. Resources with  tags
5. Storing state file in storage account container
6. Deleting the state file and importing the resources into statefile and destroy resources.
7. Errors.

**Imp**

terraform import azurerm_virtual_machine.example /subscriptions/{subscription_id}/resourceGroups/{resource_group_name}/providers/Microsoft.Compute/virtualMachines/virtual_machine_name


Errors:

**Error:1:**

**Error: Unsupported argument on main.tf line 59, in resource "azurerm_subnet" "mysnet": 
59: tags = { 
An argument named "tags" is not expected here.**

subnet cannot have tags because it is under vnet so removed tags for it.

**Error2**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/bc2a3afc-82ec-4148-b985-aff514d5fdbb)

Error occurred because secrets should have permission to view and Get so changed permission.
https://jakewalsh.co.uk/automating-azure-key-vault-and-secrets-using-terraform/

**Error3**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/7a5e4dd9-66e7-426b-abac-2cab44a9eb2e)

Error occurred because to recover the secret from deleted vault need to have Recover permission. updated 
recover permission to secrets.

**Error4**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/06456e05-ab27-48a6-815a-65dc3b54bd1b)

Error occurrred because we are performig an operation on secret which is in disabled state. to perform an opertion on it secret has to be enabled.

**Error5**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/e7084c26-e785-4b92-b516-5dfde546a156)

Error occurred because of incorrect object id specified in the access policy.Posty chnaging user object id able to post the secret.

**Error6**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/631b010a-c337-42a5-80e6-f3e52b87cfbd)

Error occurred due to cache stored in statefile or init(not sure) the secret is not deleted and storing the old value. post deleting state file and detroying resources able to get the new scret value in key vault.

**Error 7**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/dbadd5cc-e109-4922-a691-f13c1a05a638)

Error occurrred while detroying all resources keyvalut tries to purge the secret when it is still in deleted state and currently being deleted. post deletion only we have to do that operations.

**Error 8**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/4afe3612-596c-439e-ace9-f91e49c75d30)

Error occureed after destroying manually from azure again deploying the resources in terraform but due to cache random password is not generated and key vault is unable to recover the deleted secret value as it does not have Recover permission. we can give Recover permission to get the deleted key or remove the cache memory or change the name and deploy the infra again.


**Error 9**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/5956e577-d3e7-4f84-bbcf-51b2bbf4083d)

When you change any verison of terraform make sure to upgrade it using terraform init -upgrade to upgrade to new version and cache will also getremoved.

**Error 10**

![image](https://github.com/Koushikdp/New-Terraform-codes/assets/86507986/ebb94c47-a643-470e-bb2e-ecea39f5d0f0)

Error occurred due to case sensitive value provided for private ip allocation. few versions have values as case sensitive so it shuld be Static not static.

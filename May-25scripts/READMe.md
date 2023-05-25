Today task may25

1. Deploying infra with out client and subscription id's.
2. Vm Password should be in encrypted mode
3. Vm passwords should store in Azure key vault & azure vm has to get the encrypted password from keyvault
4. Resources with  tags
5. Storing state file in storage account container
6. Deleting the state file and importing the resources into statefile and destroy resources.
7. Errors.


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

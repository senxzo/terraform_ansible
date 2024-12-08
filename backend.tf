
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-N01657870-RG"
    storage_account_name = "tfstaten01657870sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}

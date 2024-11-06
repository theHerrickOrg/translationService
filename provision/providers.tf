terraform {
  backend "azurerm" {
  }
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.7"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = false
    }
  }

  skip_provider_registration = true
}

data azurerm_client_config "current" {
}
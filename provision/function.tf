resource "azurerm_service_plan" "asp" {
  name                = var.asp
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "fa" {
  name                = var.fa
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  service_plan_id            = azurerm_service_plan.asp.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_connection_string = azurerm_application_insights.appinsights.connection_string
    always_on = true
    application_stack {
      node_version = "18"
    }
  }

  app_settings = {
    "GH_TOKEN" = "@Microsoft.KeyVault(SecretUri=https://translationserviceukskv.vault.azure.net/secrets/ghtoken)"
    "GH_OWNER" = "@Microsoft.KeyVault(SecretUri=https://translationserviceukskv.vault.azure.net/secrets/ghowner)"
    "GH_REPO" = "@Microsoft.KeyVault(SecretUri=https://translationserviceukskv.vault.azure.net/secrets/ghrepo)"
    "GH_WORKFLOW" = "@Microsoft.KeyVault(SecretUri=https://translationserviceukskv.vault.azure.net/secrets/ghworkflow)"
  }

}
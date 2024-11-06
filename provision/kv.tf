resource "azurerm_key_vault" "kv" {
  name                        = var.keyvault
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization = true
  sku_name = "standard"
}

resource "azurerm_role_assignment" "fatokv" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Reader"
  principal_id         = azurerm_linux_function_app.fa.identity.principal_id
}
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
  depends_on = [ azurerm_linux_function_app.fa, azurerm_key_vault.kv ]
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Reader"
  principal_id         = azurerm_linux_function_app.fa.identity[0].principal_id
}

resource "azurerm_key_vault_secret" "gh_owner" {
  name         = "ghowner"
  value        = "theHerrickOrg"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "gh_repo" {
  name         = "ghrepo"
  value        = "translationService"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "gh_workflow" {
  name         = "ghworkflow"
  value        = "template-provision.yaml"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "gh_token" {
  name         = "ghtoken"
  value        = var.gh_token
  key_vault_id = azurerm_key_vault.kv.id
}

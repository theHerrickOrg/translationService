resource "azurerm_application_insights" "appinsights" {
  name                = var.appinsights
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "Node.JS"
}
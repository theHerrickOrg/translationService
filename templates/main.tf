module "resource_group" {
  source = "./modules/rg"

  resource_group = var.resource_group
  location = var.location
}
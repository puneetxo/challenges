# Create Azure Resource Group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Create Azure App Service Plan
resource "azurerm_app_service_plan" "frontend" {
  name                = var.frontend_app_service_plan_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service_plan" "backend" {
  name                = var.backend_app_service_plan_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create Azure App Services
resource "azurerm_app_service" "frontend" {
  name                = var.frontend_app_service_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.frontend.id
}

resource "azurerm_app_service" "backend" {
  name                = var.backend_app_service_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.backend.id
}

# Create Azure SQL Managed Instance
resource "azurerm_sql_managed_instance" "database" {
  name                = var.database_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "GP_Gen5_2"
  storage_size_gb     = 128
  vnet_subnet_id      = var.vnet_subnet_id
  version             = "12.0"
  administrator_login = var.database_admin_login
  administrator_login_password = var.database_admin_password
}

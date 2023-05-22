# Create Azure Virtual Network
resource "azurerm_virtual_network" "network" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Create Azure Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Associate Subnet with App Services
resource "azurerm_app_service_virtual_network_swift_connection" "subnet_association" {
  app_service_id           = azurerm_app_service.frontend.id
  subnet_id                = azurerm_subnet.subnet.id
  app_service_name         = azurerm_app_service.frontend.name
  subnet_association_name  = "frontend-subnet-association"
}

resource "azurerm_app_service_virtual_network_swift_connection" "subnet_association_backend" {
  app_service_id           = azurerm_app_service.backend.id
  subnet_id                = azurerm_subnet.subnet.id
  app_service_name         = azurerm_app_service.backend.name
  subnet_association_name  = "backend-subnet-association"
}

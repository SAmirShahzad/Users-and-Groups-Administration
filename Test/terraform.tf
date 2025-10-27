# Terraform configuration for Users and Groups Administration - Test Environment

terraform {
  required_version = ">= 1.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Configure the Azure Active Directory Provider
provider "azuread" {}

# Data source to get current Azure AD tenant information
data "azuread_client_config" "current" {}

# Example: Create an Azure AD Group for Test Environment
resource "azuread_group" "test_users" {
  display_name            = "Test Users"
  description             = "Test environment users group"
  security_enabled        = true
  prevent_duplicate_names = true
  
  owners = [data.azuread_client_config.current.object_id]
}

# Example: Create an Azure AD User for Test Environment
resource "azuread_user" "test_admin" {
  user_principal_name = "testadmin@yourdomain.com"
  display_name        = "Test Administrator"
  mail_nickname       = "testadmin"
  password            = "TestPassword123!"
  
  force_password_change = true
}

# Example: Add user to group
resource "azuread_group_member" "test_admin_member" {
  group_object_id  = azuread_group.test_users.object_id
  member_object_id = azuread_user.test_admin.object_id
}

# Create additional test users
resource "azuread_user" "test_user" {
  count = 3
  
  user_principal_name = "testuser${count.index + 1}@yourdomain.com"
  display_name        = "Test User ${count.index + 1}"
  mail_nickname       = "testuser${count.index + 1}"
  password            = "TestUserPassword123!"
  
  force_password_change = true
}

# Add test users to the test group
resource "azuread_group_member" "test_user_members" {
  count = length(azuread_user.test_user)
  
  group_object_id  = azuread_group.test_users.object_id
  member_object_id = azuread_user.test_user[count.index].object_id
}
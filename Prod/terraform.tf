# Terraform configuration for Users and Groups Administration - Production Environment

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

# Example: Create an Azure AD Group
resource "azuread_group" "prod_users" {
  display_name            = "Production Users"
  description             = "Production environment users group"
  security_enabled        = true
  prevent_duplicate_names = true
  
  owners = [data.azuread_client_config.current.object_id]
}

# Example: Create an Azure AD User
resource "azuread_user" "prod_admin" {
  user_principal_name = "prodadmin@yourdomain.com"
  display_name        = "Production Administrator"
  mail_nickname       = "prodadmin"
  password            = "SecurePassword123!"
  
  force_password_change = true
}

# Example: Add user to group
resource "azuread_group_member" "prod_admin_member" {
  group_object_id  = azuread_group.prod_users.object_id
  member_object_id = azuread_user.prod_admin.object_id
}
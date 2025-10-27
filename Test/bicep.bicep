// Bicep template for Users and Groups Administration - Test Environment
// Note: This template demonstrates the structure for Azure AD resources
// Azure AD resources in Bicep require specific providers and may need ARM templates

targetScope = 'resourceGroup'

@description('Location for any Azure resources')
param location string = resourceGroup().location

// Note: For Azure AD users and groups, you'll typically need to use:
// 1. ARM templates with Microsoft Graph API calls
// 2. PowerShell scripts with Microsoft Graph modules
// 3. Azure CLI commands
// 4. Terraform with AzureAD provider

// This template can be extended to include Azure resources that support the user management
// For example, Key Vault for storing secrets, Storage Account for logs, etc.

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'kv-test-users-${uniqueString(resourceGroup().id)}'
  location: location
  properties: {
    tenantId: tenant().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enableRbacAuthorization: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
  }
}

// Storage account for logging and monitoring
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'sttest${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

// Outputs
output keyVaultName string = keyVault.name
output storageAccountName string = storageAccount.name
output tenantId string = tenant().tenantId
output resourceGroupName string = resourceGroup().name
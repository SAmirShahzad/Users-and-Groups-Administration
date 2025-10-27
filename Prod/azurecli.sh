#!/bin/bash

# Azure CLI script for Users and Groups Administration - Production Environment
# This script manages Azure AD users and groups for production environment

# Set variables
RESOURCE_GROUP="rg-users-groups-prod"
LOCATION="eastus"
TENANT_ID=$(az account show --query tenantId -o tsv)

echo "Starting Azure AD Users and Groups management for Production..."
echo "Tenant ID: $TENANT_ID"

# Create a security group
echo "Creating production users security group..."
PROD_GROUP_ID=$(az ad group create \
  --display-name "Production Users" \
  --mail-nickname "production-users" \
  --description "Production environment users group" \
  --query objectId -o tsv)

echo "Production Users group created with ID: $PROD_GROUP_ID"

# Create a user (example)
echo "Creating production admin user..."
USER_UPN="prodadmin@yourdomain.com"
az ad user create \
  --display-name "Production Administrator" \
  --user-principal-name "$USER_UPN" \
  --password "SecurePassword123!" \
  --force-change-password-next-login true

# Get the user object ID
USER_OBJECT_ID=$(az ad user show --id "$USER_UPN" --query objectId -o tsv)

# Add user to the group
echo "Adding user to production users group..."
az ad group member add \
  --group "$PROD_GROUP_ID" \
  --member-id "$USER_OBJECT_ID"

# List group members to verify
echo "Current members of Production Users group:"
az ad group member list --group "$PROD_GROUP_ID" --query "[].displayName" -o table

echo "Production environment users and groups setup completed!"
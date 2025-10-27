#!/bin/bash

# Azure CLI script for Users and Groups Administration - Test Environment
# This script manages Azure AD users and groups for test environment

# Set variables
RESOURCE_GROUP="rg-users-groups-test"
LOCATION="eastus"
TENANT_ID=$(az account show --query tenantId -o tsv)

echo "Starting Azure AD Users and Groups management for Test Environment..."
echo "Tenant ID: $TENANT_ID"

# Create a security group for test users
echo "Creating test users security group..."
TEST_GROUP_ID=$(az ad group create \
  --display-name "Test Users" \
  --mail-nickname "test-users" \
  --description "Test environment users group" \
  --query objectId -o tsv)

echo "Test Users group created with ID: $TEST_GROUP_ID"

# Create test admin user
echo "Creating test admin user..."
TEST_ADMIN_UPN="testadmin@yourdomain.com"
az ad user create \
  --display-name "Test Administrator" \
  --user-principal-name "$TEST_ADMIN_UPN" \
  --password "TestPassword123!" \
  --force-change-password-next-login true

# Get the test admin user object ID
TEST_ADMIN_OBJECT_ID=$(az ad user show --id "$TEST_ADMIN_UPN" --query objectId -o tsv)

# Add test admin to the group
echo "Adding test admin to test users group..."
az ad group member add \
  --group "$TEST_GROUP_ID" \
  --member-id "$TEST_ADMIN_OBJECT_ID"

# Create additional test users
echo "Creating additional test users..."
for i in {1..3}; do
    TEST_USER_UPN="testuser${i}@yourdomain.com"
    echo "Creating test user: $TEST_USER_UPN"
    
    az ad user create \
      --display-name "Test User $i" \
      --user-principal-name "$TEST_USER_UPN" \
      --password "TestUserPassword123!" \
      --force-change-password-next-login true
    
    # Get user object ID and add to group
    USER_OBJECT_ID=$(az ad user show --id "$TEST_USER_UPN" --query objectId -o tsv)
    az ad group member add \
      --group "$TEST_GROUP_ID" \
      --member-id "$USER_OBJECT_ID"
    
    echo "Test user $i created and added to group"
done

# List group members to verify
echo "Current members of Test Users group:"
az ad group member list --group "$TEST_GROUP_ID" --query "[].displayName" -o table

# Create a developers group for testing
echo "Creating developers group for testing..."
DEV_GROUP_ID=$(az ad group create \
  --display-name "Test Developers" \
  --mail-nickname "test-developers" \
  --description "Test environment developers group" \
  --query objectId -o tsv)

echo "Test Developers group created with ID: $DEV_GROUP_ID"

echo "Test environment users and groups setup completed!"
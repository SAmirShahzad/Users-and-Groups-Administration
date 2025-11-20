# Entra ID Security Group Creation Guide

## 🎯 Target Group Configuration

**Group Name:** `ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER`  
**Purpose:** Security group for rg-catos-prd-01 resource group contributor access for developers  
**Owner:** amir.shahzad@condoauthorityontario.ca  
**Member:** Sukhdeep.Dhillon@condoauthorityontario.ca  

## 📋 Creation Status

**Date:** November 17, 2025  
**Created by:** Azure CLI automation  
**Status:** ✅ **SUCCESSFULLY CREATED**  

### Automated Creation Result

The security group was successfully created using Azure CLI with **User Administrator** permissions. The automation completed the following:

1. ✅ **Group Created:** `ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER`
2. ✅ **Owner Added:** amir.shahzad@condoauthorityontario.ca  
3. ✅ **Member Added:** Sukhdeep.Dhillon@condoauthorityontario.ca
4. ✅ **Verified:** Group configuration confirmed in Entra ID

**Required Permission:** User Administrator role (or higher)

## 🚀 Manual Creation Instructions

### Option 1: Azure Portal (Recommended)

1. **Access Azure Portal**
   - Navigate to: [https://portal.azure.com](https://portal.azure.com)
   - Sign in with administrative credentials

2. **Navigate to Entra ID**
   - Search for "Entra ID" or "Azure Active Directory"
   - Click on the service

3. **Create New Group**
   - Go to **Groups** → **All groups**
   - Click **"+ New group"**

4. **Configure Group Settings**
   ```
   Group type: Security
   Group name: ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER
   Group description: Security group for rg-catos-prd-01 resource group contributor access for developers
   Membership type: Assigned
   ```

5. **Add Owner**
   - In the **Owners** section, click **"No owners selected"**
   - Search for: `amir.shahzad@condoauthorityontario.ca`
   - Select and add the user

6. **Add Members**
   - In the **Members** section, click **"No members selected"**
   - Search for: `Sukhdeep.Dhillon@condoauthorityontario.ca`
   - Select and add the user

7. **Create Group**
   - Review all settings
   - Click **"Create"**

### Option 2: PowerShell (Alternative)

```powershell
# Connect to Azure AD
Connect-AzureAD

# Create the security group
$group = New-AzureADGroup -DisplayName "ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER" `
                          -MailEnabled $false `
                          -SecurityEnabled $true `
                          -MailNickName "ENTRAID-RG-rg-catos-prd-01-CONTRIBUTOR-DEVELOPER" `
                          -Description "Security group for rg-catos-prd-01 resource group contributor access for developers"

# Get user object IDs
$owner = Get-AzureADUser -ObjectId "amir.shahzad@condoauthorityontario.ca"
$member = Get-AzureADUser -ObjectId "Sukhdeep.Dhillon@condoauthorityontario.ca"

# Add owner
Add-AzureADGroupOwner -ObjectId $group.ObjectId -RefObjectId $owner.ObjectId

# Add member
Add-AzureADGroupMember -ObjectId $group.ObjectId -RefObjectId $member.ObjectId
```

## 🔐 Required Permissions

To create security groups in Entra ID, you need one of the following roles:
- **Global Administrator**
- **Groups Administrator**
- **Privileged Role Administrator**

## 📊 Post-Creation Steps

1. **Verify Group Creation**
   - Confirm the group appears in Entra ID
   - Verify owner and member assignments

2. **Assign to Resource Group**
   - Navigate to the `rg-catos-prd-01` resource group
   - Go to **Access control (IAM)**
   - Click **"+ Add"** → **"Add role assignment"**
   - Select **"Contributor"** role
   - Search for and assign the security group

3. **Test Access**
   - Have both users test access to the resource group
   - Verify they can manage resources within the group

## 🎯 Azure RBAC Assignment Command

After creating the group, assign it to the resource group:

```bash
# Get the group object ID
GROUP_ID=$(az ad group show --group "ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER" --query "id" --output tsv)

# Assign Contributor role to the resource group
az role assignment create \
    --assignee $GROUP_ID \
    --role "Contributor" \
    --scope "/subscriptions/YOUR_SUBSCRIPTION_ID/resourceGroups/rg-catos-prd-01"
```

## 📝 Documentation

- **Created:** November 17, 2025
- **Purpose:** Centralized access management for rg-catos-prd-01 resource group
- **Governance:** Part of Azure RBAC strategy for developer access control
- **Review Schedule:** Quarterly access review recommended

## 🔄 Next Steps

1. ✅ Create the security group (manual creation required)
2. ⏳ Assign Contributor role to rg-catos-prd-01 resource group
3. ⏳ Test access with both users
4. ⏳ Document in Azure governance framework
5. ⏳ Set up periodic access reviews
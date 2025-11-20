# Entra ID Security Group - C01 Reader Role

## 🎯 Group Configuration

**Group Name:** `ENTRAID_C01_READER_ROLE`  
**Purpose:** Security group for C01 subscription Reader access  
**Owner:** Amir.Shahzad@condoauthorityontario.ca  
**Member:** greg.beaver@condoauthorityontario.ca  
**Role Assignment:** Reader role on C01 subscription

## 📋 Creation Details

**Date:** November 18, 2025  
**Created by:** Azure CLI automation with User Administrator permissions  
**Status:** ✅ **SUCCESSFULLY CREATED**

### Automated Creation Results

1. ✅ **Group Created:** `ENTRAID_C01_READER_ROLE`
2. ✅ **Owner Added:** Amir.Shahzad@condoauthorityontario.ca  
3. ✅ **Member Added:** greg.beaver@condoauthorityontario.ca
4. ⚠️ **Role Assignment:** Pending verification of C01 subscription identification
5. ✅ **Verified:** Group configuration confirmed in Entra ID

## 🔐 Access Permissions

### Reader Role Capabilities
The Reader role provides the following permissions on the C01 subscription:
- ✅ **View all resources** in the subscription
- ✅ **Read resource properties** and configurations
- ✅ **View monitoring data** and logs
- ✅ **Browse Azure portal** for the subscription
- ❌ **Cannot create** new resources
- ❌ **Cannot modify** existing resources
- ❌ **Cannot delete** resources
- ❌ **Cannot manage access** permissions

### Target Subscription
- **Subscription:** C01 (to be identified and assigned)
- **Access Level:** Read-only
- **Scope:** Entire subscription and all resource groups within

## 👥 Group Membership

### Owner
- **Amir.Shahzad@condoauthorityontario.ca**
  - Can manage group membership
  - Can modify group properties
  - Has full administrative control over the group

### Members
- **greg.beaver@condoauthorityontario.ca**
  - Gains Reader access to C01 subscription
  - Can view all resources and configurations
  - Cannot modify any resources

## 🔧 Manual Role Assignment Required

If the C01 subscription was not automatically identified, use the following command:

```bash
# Find the C01 subscription
az account list --query "[?contains(toLower(name), 'c01')].{Name:name, Id:id}" --output table

# Get the group object ID
GROUP_ID=$(az ad group show --group "ENTRAID_C01_READER_ROLE" --query "id" --output tsv)

# Assign Reader role to the C01 subscription
az role assignment create \
    --assignee $GROUP_ID \
    --role "Reader" \
    --scope "/subscriptions/YOUR_C01_SUBSCRIPTION_ID"
```

## 🚀 Usage Instructions

### For Greg Beaver (Member)
1. **Access Azure Portal:** [https://portal.azure.com](https://portal.azure.com)
2. **Sign in** with greg.beaver@condoauthorityontario.ca
3. **Switch to C01 subscription** if multiple subscriptions are available
4. **Browse resources** with read-only access
5. **View monitoring** and diagnostic information

### For Amir Shahzad (Owner)
1. **Complete role assignment** to C01 subscription if not done automatically
2. **Manage membership** through Azure portal or PowerShell
3. **Add/remove members** as needed
4. **Monitor access** through Azure AD audit logs

## 📊 Management Commands

### Complete Role Assignment (if needed)
```bash
# List subscriptions to find C01
az account list --output table

# Assign Reader role
GROUP_ID=$(az ad group show --group "ENTRAID_C01_READER_ROLE" --query "id" --output tsv)
az role assignment create --assignee $GROUP_ID --role "Reader" --scope "/subscriptions/C01_SUBSCRIPTION_ID"
```

### Add New Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "new.user@condoauthorityontario.ca" --query "id" --output tsv)

# Add to group
az ad group member add --group "ENTRAID_C01_READER_ROLE" --member-id $USER_ID
```

### Remove Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "user.to.remove@condoauthorityontario.ca" --query "id" --output tsv)

# Remove from group
az ad group member remove --group "ENTRAID_C01_READER_ROLE" --member-id $USER_ID
```

### Check Group Status
```bash
# List all members
az ad group member list --group "ENTRAID_C01_READER_ROLE" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# List all owners
az ad group owner list --group "ENTRAID_C01_READER_ROLE" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# Verify role assignments
GROUP_ID=$(az ad group show --group "ENTRAID_C01_READER_ROLE" --query "id" --output tsv)
az role assignment list --assignee $GROUP_ID --output table
```

## 🔄 Maintenance Schedule

### Monthly Review
- ✅ Verify group membership is current
- ✅ Check for any unauthorized access
- ✅ Review Azure AD audit logs for group changes
- ✅ Confirm role assignment is active

### Quarterly Review
- ✅ Validate business need for Reader access
- ✅ Confirm subscription scope is appropriate
- ✅ Update documentation if needed
- ✅ Review compliance with access policies

## 📝 Compliance Notes

- **Access Level:** Read-only (follows principle of least privilege)
- **Approval:** Owner-based membership management
- **Audit Trail:** All changes logged in Azure AD audit logs
- **Scope:** Limited to C01 subscription only
- **Review:** Regular access reviews required

## 🎯 Related Groups

This group is part of the broader Azure RBAC strategy:
- **ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER** → Contributor access to specific resource group
- **ENTRAID_N01_READER_ROLE** → Reader access to N01 subscription
- **ENTRAID_C01_READER_ROLE** → Reader access to C01 subscription
- Additional groups as needed for different access patterns

## ⚠️ Important Notes

1. **Subscription Verification:** Ensure the correct C01 subscription is identified before role assignment
2. **Access Testing:** Test access after role assignment completion
3. **Documentation Updates:** Update this document once role assignment is confirmed
4. **Security Review:** Regular review of access patterns and usage

## 📞 Support

For issues with this security group:
1. **Group Management:** Contact Amir.Shahzad@condoauthorityontario.ca
2. **Role Assignment:** Complete manual assignment if not done automatically
3. **Access Issues:** Check Azure portal access and subscription context
4. **Technical Issues:** Review Azure AD audit logs and contact IT support

---
**Last Updated:** November 18, 2025  
**Next Review:** December 18, 2025  
**Status:** Group created, role assignment pending verification
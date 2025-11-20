# Entra ID Security Group - N01 Reader Role

## 🎯 Group Configuration

**Group Name:** `ENTRAID_N01_READER_ROLE`  
**Purpose:** Security group for N01 subscription Reader access  
**Owner:** Amir.Shahzad@condoauthorityontario.ca  
**Member:** greg.beaver@condoauthorityontario.ca  
**Role Assignment:** Reader role on N01 subscription

## 📋 Creation Details

**Date:** November 18, 2025  
**Created by:** Azure CLI automation with User Administrator permissions  
**Status:** ✅ **SUCCESSFULLY CREATED**

### Automated Creation Results

1. ✅ **Group Created:** `ENTRAID_N01_READER_ROLE`
2. ✅ **Owner Added:** Amir.Shahzad@condoauthorityontario.ca  
3. ✅ **Member Added:** greg.beaver@condoauthorityontario.ca
4. ✅ **Role Assigned:** Reader role on N01 subscription
5. ✅ **Verified:** Group configuration confirmed in Entra ID

## 🔐 Access Permissions

### Reader Role Capabilities
The Reader role provides the following permissions on the N01 subscription:
- ✅ **View all resources** in the subscription
- ✅ **Read resource properties** and configurations
- ✅ **View monitoring data** and logs
- ✅ **Browse Azure portal** for the subscription
- ❌ **Cannot create** new resources
- ❌ **Cannot modify** existing resources
- ❌ **Cannot delete** resources
- ❌ **Cannot manage access** permissions

### Target Subscription
- **Subscription:** N01 (identified by search)
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
  - Gains Reader access to N01 subscription
  - Can view all resources and configurations
  - Cannot modify any resources

## 🚀 Usage Instructions

### For Greg Beaver (Member)
1. **Access Azure Portal:** [https://portal.azure.com](https://portal.azure.com)
2. **Sign in** with greg.beaver@condoauthorityontario.ca
3. **Switch to N01 subscription** if multiple subscriptions are available
4. **Browse resources** with read-only access
5. **View monitoring** and diagnostic information

### For Amir Shahzad (Owner)
1. **Manage membership** through Azure portal or PowerShell
2. **Add/remove members** as needed
3. **Monitor access** through Azure AD audit logs
4. **Review permissions** periodically

## 📊 Management Commands

### Add New Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "new.user@condoauthorityontario.ca" --query "id" --output tsv)

# Add to group
az ad group member add --group "ENTRAID_N01_READER_ROLE" --member-id $USER_ID
```

### Remove Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "user.to.remove@condoauthorityontario.ca" --query "id" --output tsv)

# Remove from group
az ad group member remove --group "ENTRAID_N01_READER_ROLE" --member-id $USER_ID
```

### Check Group Membership
```bash
# List all members
az ad group member list --group "ENTRAID_N01_READER_ROLE" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# List all owners
az ad group owner list --group "ENTRAID_N01_READER_ROLE" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table
```

### Verify Role Assignment
```bash
# Check role assignments for the group
GROUP_ID=$(az ad group show --group "ENTRAID_N01_READER_ROLE" --query "id" --output tsv)
az role assignment list --assignee $GROUP_ID --output table
```

## 🔄 Maintenance Schedule

### Monthly Review
- ✅ Verify group membership is current
- ✅ Check for any unauthorized access
- ✅ Review Azure AD audit logs for group changes

### Quarterly Review
- ✅ Validate business need for Reader access
- ✅ Confirm subscription scope is appropriate
- ✅ Update documentation if needed

## 📝 Compliance Notes

- **Access Level:** Read-only (follows principle of least privilege)
- **Approval:** Owner-based membership management
- **Audit Trail:** All changes logged in Azure AD audit logs
- **Scope:** Limited to N01 subscription only

## 🎯 Related Groups

This group is part of the broader Azure RBAC strategy:
- **ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER** → Contributor access to specific resource group
- **ENTRAID_N01_READER_ROLE** → Reader access to N01 subscription
- Additional groups as needed for different access patterns

## 📞 Support

For issues with this security group:
1. **Group Management:** Contact Amir.Shahzad@condoauthorityontario.ca
2. **Access Issues:** Check Azure portal access and subscription context
3. **Technical Issues:** Review Azure AD audit logs and contact IT support

---
**Last Updated:** November 18, 2025  
**Next Review:** December 18, 2025
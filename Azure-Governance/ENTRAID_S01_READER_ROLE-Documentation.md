# Entra ID Security Group - S01 Reader Role

## 🎯 Group Configuration

**Group Name:** `ENTRAID_S01_READER_ROLE`  
**Purpose:** Security group for S01 subscription Reader access  
**Owner:** Amir.Shahzad@condoauthorityontario.ca  
**Member:** greg.beaver@condoauthorityontario.ca  
**Role Assignment:** Ready for Reader role assignment to S01 subscription
**Note:** S01 appears to be the sandbox subscription

## 📋 Creation Details

**Date:** November 18, 2025  
**Created by:** Azure CLI automation with User Administrator permissions  
**Status:** ✅ **SUCCESSFULLY CREATED**

### Automated Creation Results

1. ✅ **Group Created:** `ENTRAID_S01_READER_ROLE`
2. ✅ **Owner Added:** Amir.Shahzad@condoauthorityontario.ca  
3. ✅ **Member Added:** greg.beaver@condoauthorityontario.ca
4. ⏳ **Role Assignment:** Pending assignment to S01 subscription
5. ✅ **Verified:** Group configuration confirmed in Entra ID

## 🔐 Access Permissions (When Assigned)

### Reader Role Capabilities
When assigned to S01 subscription, the Reader role will provide:
- ✅ **View all resources** in the subscription
- ✅ **Read resource properties** and configurations
- ✅ **View monitoring data** and logs
- ✅ **Browse Azure portal** for the subscription
- ❌ **Cannot create** new resources
- ❌ **Cannot modify** existing resources
- ❌ **Cannot delete** resources
- ❌ **Cannot manage access** permissions

### Target Subscription
- **Subscription:** S01 (sandbox subscription)
- **Access Level:** Read-only (when assigned)
- **Scope:** Entire subscription and all resource groups within
- **Environment:** Sandbox/Development environment

## 👥 Group Membership

### Owner
- **Amir.Shahzad@condoauthorityontario.ca**
  - Can manage group membership
  - Can modify group properties
  - Has full administrative control over the group

### Members
- **greg.beaver@condoauthorityontario.ca**
  - Will gain Reader access to S01 subscription when assigned
  - Can view all resources and configurations in sandbox
  - Cannot modify any resources

## 🧪 Sandbox Environment Notes

Since S01 appears to be a sandbox subscription:
- **Purpose:** Development, testing, and experimentation
- **Access Pattern:** Read-only for monitoring and review
- **Resource Lifecycle:** Temporary resources for testing
- **Compliance:** Lower compliance requirements than production

## 🔧 Role Assignment Instructions

To complete the setup, assign this group to the S01 subscription:

### Find S01 Subscription
```bash
# Search for S01 subscription (sandbox)
az account list --query "[?contains(toLower(name), 's01')].{Name:name, Id:id}" --output table
```

### Assign Reader Role
```bash
# Get the group object ID
GROUP_ID=$(az ad group show --group "ENTRAID_S01_READER_ROLE" --query "id" --output tsv)

# Assign Reader role to S01 subscription
az role assignment create \
    --assignee $GROUP_ID \
    --role "Reader" \
    --scope "/subscriptions/YOUR_S01_SUBSCRIPTION_ID"
```

### Verify Assignment
```bash
# Check role assignments
az role assignment list --assignee $GROUP_ID --output table
```

## 🚀 Usage Instructions (After Role Assignment)

### For Greg Beaver (Member)
1. **Access Azure Portal:** [https://portal.azure.com](https://portal.azure.com)
2. **Sign in** with greg.beaver@condoauthorityontario.ca
3. **Switch to S01 subscription** (sandbox environment)
4. **Browse development/test resources** with read-only access
5. **Monitor sandbox activities** and resource usage

### For Amir Shahzad (Owner)
1. **Complete role assignment** to S01 subscription
2. **Manage membership** for sandbox access
3. **Add/remove members** as development team changes
4. **Monitor sandbox usage** through audit logs

## 📊 Management Commands

### Add New Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "new.user@condoauthorityontario.ca" --query "id" --output tsv)

# Add to group
az ad group member add --group "ENTRAID_S01_READER_ROLE" --member-id $USER_ID
```

### Remove Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "user.to.remove@condoauthorityontario.ca" --query "id" --output tsv)

# Remove from group
az ad group member remove --group "ENTRAID_S01_READER_ROLE" --member-id $USER_ID
```

### Check Group Status
```bash
# List all members
az ad group member list --group "ENTRAID_S01_READER_ROLE" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# List all owners
az ad group owner list --group "ENTRAID_S01_READER_ROLE" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# Check role assignments
GROUP_ID=$(az ad group show --group "ENTRAID_S01_READER_ROLE" --query "id" --output tsv)
az role assignment list --assignee $GROUP_ID --output table
```

## 🔄 Maintenance Schedule

### Monthly Review
- ✅ Verify group membership reflects current development team
- ✅ Check sandbox resource usage and costs
- ✅ Review Azure AD audit logs for group changes
- ✅ Confirm role assignment is active (after assignment)

### Quarterly Review
- ✅ Validate continued need for sandbox Reader access
- ✅ Review sandbox governance and policies
- ✅ Update documentation if needed
- ✅ Assess sandbox resource lifecycle management

## 📝 Compliance Notes

- **Access Level:** Read-only (follows principle of least privilege)
- **Environment:** Sandbox/Development (lower compliance requirements)
- **Approval:** Owner-based membership management
- **Audit Trail:** All changes logged in Azure AD audit logs
- **Scope:** Limited to S01 sandbox subscription only
- **Review:** Regular access reviews for development team changes

## 🎯 Complete Security Group Portfolio

This group completes the subscription-level Reader access strategy:

### Production/Business Subscriptions
- **ENTRAID_N01_READER_ROLE** → N01 subscription
- **ENTRAID_C01_READER_ROLE** → C01 subscription
- **ENTRAID_I01_READER_ROLE** → I01 subscription
- **ENTRAID_P01_READER_ROLE** → P01 subscription

### Development/Testing Subscriptions
- **ENTRAID_S01_READER_ROLE** → S01 subscription (sandbox)

### Resource Group Level
- **ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER** → Specific resource group contributor access

## 📞 Support

For issues with this security group:
1. **Group Management:** Contact Amir.Shahzad@condoauthorityontario.ca
2. **Role Assignment:** Complete assignment to S01 subscription when ready
3. **Sandbox Access:** Check Azure portal access and subscription context
4. **Technical Issues:** Review Azure AD audit logs and contact IT support

## 🔗 Quick Links

- **Azure Portal:** [https://portal.azure.com](https://portal.azure.com)
- **PIM Portal:** [https://portal.azure.com/#view/Microsoft_Azure_PIMCommon/CommonMenuBlade/~/MyActions](https://portal.azure.com/#view/Microsoft_Azure_PIMCommon/CommonMenuBlade/~/MyActions)
- **Azure AD Groups:** [https://portal.azure.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups](https://portal.azure.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups)
- **Sandbox Subscription:** Switch to S01 in Azure portal after role assignment

---
**Last Updated:** November 18, 2025  
**Next Review:** December 18, 2025  
**Status:** Group created, pending S01 subscription role assignment  
**Environment:** Sandbox/Development
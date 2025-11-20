# Entra ID Security Group - P02 Reader Role

## 🎯 Group Configuration

**Group Name:** `ENTRAID_P02_READER_ROLE`  
**Purpose:** Security group for P02 subscription Reader access  
**Owner:** Amir.Shahzad@condoauthorityontario.ca  
**Member:** greg.beaver@condoauthorityontario.ca  
**Role Assignment:** Ready for Reader role assignment to P02 subscription

## 📋 Creation Details

**Date:** November 18, 2025  
**Created by:** Azure CLI automation with User Administrator permissions  
**Status:** ✅ **SUCCESSFULLY CREATED**

### Automated Creation Results

1. ✅ **Group Created:** `ENTRAID_P02_READER_ROLE`
2. ✅ **Owner Added:** Amir.Shahzad@condoauthorityontario.ca  
3. ✅ **Member Added:** greg.beaver@condoauthorityontario.ca
4. ⏳ **Role Assignment:** Pending assignment to P02 subscription
5. ✅ **Verified:** Group configuration confirmed in Entra ID

## 🔐 Access Permissions (When Assigned)

### Reader Role Capabilities
When assigned to P02 subscription, the Reader role will provide:
- ✅ **View all resources** in the subscription
- ✅ **Read resource properties** and configurations
- ✅ **View monitoring data** and logs
- ✅ **Browse Azure portal** for the subscription
- ❌ **Cannot create** new resources
- ❌ **Cannot modify** existing resources
- ❌ **Cannot delete** resources
- ❌ **Cannot manage access** permissions

### Target Subscription
- **Subscription:** P02 (to be identified and assigned)
- **Access Level:** Read-only (when assigned)
- **Scope:** Entire subscription and all resource groups within

## 👥 Group Membership

### Owner
- **Amir.Shahzad@condoauthorityontario.ca**
  - Can manage group membership
  - Can modify group properties
  - Has full administrative control over the group

### Members
- **greg.beaver@condoauthorityontario.ca**
  - Will gain Reader access to P02 subscription when assigned
  - Can view all resources and configurations
  - Cannot modify any resources

## 🔧 Role Assignment Instructions

To complete the setup, assign this group to the P02 subscription:

### Find P02 Subscription
```bash
# Search for P02 subscription
az account list --query "[?contains(toLower(name), 'p02')].{Name:name, Id:id}" --output table
```

### Assign Reader Role
```bash
# Get the group object ID
GROUP_ID=$(az ad group show --group "ENTRAID_P02_READER_ROLE" --query "id" --output tsv)

# Assign Reader role to P02 subscription
az role assignment create \
    --assignee $GROUP_ID \
    --role "Reader" \
    --scope "/subscriptions/YOUR_P02_SUBSCRIPTION_ID"
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
3. **Switch to P02 subscription** if multiple subscriptions are available
4. **Browse resources** with read-only access
5. **View monitoring** and diagnostic information

### For Amir Shahzad (Owner)
1. **Complete role assignment** to P02 subscription
2. **Manage membership** through Azure portal or PowerShell
3. **Add/remove members** as needed
4. **Monitor access** through Azure AD audit logs

## 📊 Management Commands

### Add New Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "new.user@condoauthorityontario.ca" --query "id" --output tsv)

# Add to group
az ad group member add --group "ENTRAID_P02_READER_ROLE" --member-id $USER_ID
```

### Remove Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "user.to.remove@condoauthorityontario.ca" --query "id" --output tsv)

# Remove from group
az ad group member remove --group "ENTRAID_P02_READER_ROLE" --member-id $USER_ID
```

### Check Group Status
```bash
# List all members
az ad group member list --group "ENTRAID_P02_READER_ROLE" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# List all owners
az ad group owner list --group "ENTRAID_P02_READER_ROLE" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# Check role assignments
GROUP_ID=$(az ad group show --group "ENTRAID_P02_READER_ROLE" --query "id" --output tsv)
az role assignment list --assignee $GROUP_ID --output table
```

## 🔄 Maintenance Schedule

### Monthly Review
- ✅ Verify group membership is current
- ✅ Check for any unauthorized access
- ✅ Review Azure AD audit logs for group changes
- ✅ Confirm role assignment is active (after assignment)

### Quarterly Review
- ✅ Validate business need for Reader access
- ✅ Confirm subscription scope is appropriate
- ✅ Update documentation if needed
- ✅ Review compliance with access policies

## 📝 Compliance Notes

- **Access Level:** Read-only (follows principle of least privilege)
- **Approval:** Owner-based membership management
- **Audit Trail:** All changes logged in Azure AD audit logs
- **Scope:** Limited to P02 subscription only
- **Review:** Regular access reviews required

## 🎯 Complete Subscription Portfolio

This group completes a comprehensive subscription-level Reader access strategy:

### Production/Business Subscriptions
- **ENTRAID_N01_READER_ROLE** → N01 subscription
- **ENTRAID_N02_READER_ROLE** → N02 subscription
- **ENTRAID_C01_READER_ROLE** → C01 subscription
- **ENTRAID_I01_READER_ROLE** → I01 subscription
- **ENTRAID_P01_READER_ROLE** → P01 subscription
- **ENTRAID_P02_READER_ROLE** → P02 subscription ← **NEW**

### Development/Testing Subscriptions
- **ENTRAID_S01_READER_ROLE** → S01 subscription (sandbox)

### Resource Group Level
- **ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER** → Specific resource group contributor access

## 🔍 P01 vs P02 Distinction

With both P01 and P02 subscription groups now available, consider:

### Potential Use Cases
- **Geographic Separation:** P01 for one region, P02 for another
- **Business Unit Separation:** Different departments or divisions
- **Environment Separation:** P01 for production, P02 for pre-production
- **Service Separation:** Different application stacks or services
- **Compliance Separation:** Different regulatory requirements

### Management Considerations
- **Access Patterns:** Same team needs access to both or different teams?
- **Governance:** Consistent or different policies and procedures?
- **Cost Management:** Separate billing or combined cost tracking?
- **Security:** Same or different security requirements?

## 📞 Support

For issues with this security group:
1. **Group Management:** Contact Amir.Shahzad@condoauthorityontario.ca
2. **Role Assignment:** Complete assignment to P02 subscription when ready
3. **Access Issues:** Check Azure portal access and subscription context
4. **Technical Issues:** Review Azure AD audit logs and contact IT support

## 🔗 Quick Links

- **Azure Portal:** [https://portal.azure.com](https://portal.azure.com)
- **PIM Portal:** [https://portal.azure.com/#view/Microsoft_Azure_PIMCommon/CommonMenuBlade/~/MyActions](https://portal.azure.com/#view/Microsoft_Azure_PIMCommon/CommonMenuBlade/~/MyActions)
- **Azure AD Groups:** [https://portal.azure.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups](https://portal.azure.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups)

## 📈 Portfolio Statistics

**Total Groups:** 7 subscription-level + 1 resource group-level = **8 security groups**  
**Coverage:** Complete subscription Reader access strategy  
**Consistency:** Standardized naming, ownership, and governance patterns  
**Scalability:** Ready for additional subscriptions or access patterns

---
**Last Updated:** November 18, 2025  
**Next Review:** December 18, 2025  
**Status:** Group created, pending P02 subscription role assignment
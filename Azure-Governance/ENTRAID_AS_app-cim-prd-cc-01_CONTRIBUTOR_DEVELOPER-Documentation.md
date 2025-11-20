# Entra ID Security Group - Azure App Service Contributor Developer

## 🎯 Group Configuration

**Group Name:** `ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER`  
**Object ID:** `3c8e3b64-16d2-4ee4-9d19-a5e8013dcc5c`  
**Purpose:** Security group for Azure App Service AS app-cim-prd-cc-01 resource contributor developer access  
**Owner:** Amir.Shahzad@condoauthorityontario.ca  
**Member:** Ali.Ahmed@condoauthorityontario.ca  
**Role Assignment:** Ready for Contributor role assignment to AS app-cim-prd-cc-01 App Service

## 📋 Creation Details

**Date:** November 19, 2025  
**Created by:** Azure CLI automation with User Administrator permissions  
**Status:** ✅ **SUCCESSFULLY CREATED**

### Automated Creation Results

1. ✅ **Group Created:** `ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER`
2. ✅ **Owner Added:** Amir.Shahzad@condoauthorityontario.ca  
3. ✅ **Member Added:** Ali.Ahmed@condoauthorityontario.ca
4. ⏳ **Role Assignment:** Pending assignment to AS app-cim-prd-cc-01 App Service
5. ✅ **Verified:** Group configuration confirmed in Entra ID

## 🔐 Access Permissions (When Assigned)

### Contributor Role Capabilities
When assigned to AS app-cim-prd-cc-01 App Service, the Contributor role will provide:
- ✅ **Full management** of the App Service
- ✅ **Configure application settings** and connection strings
- ✅ **Deploy code** and manage deployment slots
- ✅ **Scale applications** up/down and in/out
- ✅ **Configure SSL certificates** and custom domains
- ✅ **Manage monitoring** and diagnostic settings
- ✅ **View and modify** all App Service configurations
- ❌ **Cannot manage access** permissions (requires Owner role)
- ❌ **Cannot delete** the App Service (requires higher permissions)

### Target Resource
- **Resource:** Azure App Service `AS app-cim-prd-cc-01`
- **Access Level:** Contributor (full management except access control)
- **Scope:** Specific App Service resource only

## 👥 Group Membership

### Owner
- **Amir.Shahzad@condoauthorityontario.ca**
  - Can manage group membership
  - Can modify group properties
  - Has full administrative control over the group

### Members
- **Ali.Ahmed@condoauthorityontario.ca**
  - Will gain Contributor access to AS app-cim-prd-cc-01 when assigned
  - Can fully manage the App Service configuration and deployments
  - Cannot manage access permissions

## 🔧 Role Assignment Instructions

To complete the setup, assign this group to the AS app-cim-prd-cc-01 App Service:

### Find the App Service Resource
```bash
# Search for the App Service
az webapp list --query "[?contains(name, 'app-cim-prd-cc-01')].{Name:name, ResourceGroup:resourceGroup, Id:id}" --output table
```

### Assign Contributor Role
```bash
# Get the group object ID
GROUP_ID=$(az ad group show --group "ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER" --query "id" --output tsv)

# Assign Contributor role to the App Service
az role assignment create \
    --assignee $GROUP_ID \
    --role "Contributor" \
    --scope "/subscriptions/YOUR_SUBSCRIPTION_ID/resourceGroups/YOUR_RESOURCE_GROUP/providers/Microsoft.Web/sites/app-cim-prd-cc-01"
```

### Verify Assignment
```bash
# Check role assignments for the App Service
az role assignment list --assignee $GROUP_ID --output table
```

## 🚀 Usage Instructions (After Role Assignment)

### For Ali Ahmed (Member)
1. **Access Azure Portal:** [https://portal.azure.com](https://portal.azure.com)
2. **Sign in** with Ali.Ahmed@condoauthorityontario.ca
3. **Navigate** to the AS app-cim-prd-cc-01 App Service
4. **Manage configurations** including:
   - Application settings and connection strings
   - Deployment slots and continuous deployment
   - SSL certificates and custom domains
   - Scaling and performance settings
   - Monitoring and diagnostics

### App Service Management Capabilities
- **Code Deployment:** Deploy via FTP, Git, GitHub, Azure DevOps, or ZIP
- **Configuration:** Manage app settings, connection strings, and runtime versions
- **Scaling:** Configure manual or automatic scaling rules
- **SSL/TLS:** Upload and bind SSL certificates
- **Custom Domains:** Add and verify custom domain names
- **Monitoring:** Configure Application Insights and diagnostic logs
- **Backup:** Set up automated backups and restore points

## 📊 Management Commands

### Add New Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "new.user@condoauthorityontario.ca" --query "id" --output tsv)

# Add to group
az ad group member add --group "ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER" --member-id $USER_ID
```

### Remove Member
```bash
# Get user object ID
USER_ID=$(az ad user show --id "user.to.remove@condoauthorityontario.ca" --query "id" --output tsv)

# Remove from group
az ad group member remove --group "ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER" --member-id $USER_ID
```

### Check Group Status
```bash
# List all members
az ad group member list --group "ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# List all owners
az ad group owner list --group "ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER" --query "[].{DisplayName:displayName, UserPrincipalName:userPrincipalName}" --output table

# Check role assignments
GROUP_ID=$(az ad group show --group "ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER" --query "id" --output tsv)
az role assignment list --assignee $GROUP_ID --output table
```

### App Service Specific Commands
```bash
# Check App Service status
az webapp show --name "app-cim-prd-cc-01" --resource-group "YOUR_RESOURCE_GROUP" --query "{Name:name, State:state, DefaultHostName:defaultHostName}"

# List deployment slots
az webapp deployment slot list --name "app-cim-prd-cc-01" --resource-group "YOUR_RESOURCE_GROUP"

# Check application settings
az webapp config appsettings list --name "app-cim-prd-cc-01" --resource-group "YOUR_RESOURCE_GROUP"
```

## 🔄 Maintenance Schedule

### Weekly Review
- ✅ Verify App Service health and performance
- ✅ Check for any deployment issues
- ✅ Review application logs and metrics
- ✅ Confirm SSL certificate validity

### Monthly Review
- ✅ Verify group membership is current
- ✅ Check for any unauthorized access
- ✅ Review Azure AD audit logs for group changes
- ✅ Confirm role assignment is active (after assignment)
- ✅ Review App Service costs and usage

### Quarterly Review
- ✅ Validate business need for Contributor access
- ✅ Confirm resource scope is appropriate
- ✅ Update documentation if needed
- ✅ Review compliance with access policies
- ✅ Assess App Service configuration and optimization

## 📝 Compliance Notes

- **Access Level:** Contributor (follows principle of appropriate privilege)
- **Approval:** Owner-based membership management
- **Audit Trail:** All changes logged in Azure AD audit logs
- **Scope:** Limited to AS app-cim-prd-cc-01 App Service only
- **Review:** Regular access reviews required
- **Resource Type:** Azure App Service (Platform-as-a-Service)

## 🎯 App Service Context

### Resource Information
- **Service Type:** Azure App Service
- **Name Pattern:** AS app-cim-prd-cc-01
- **Environment:** Production (prd)
- **Application:** Customer Information Management (cim)
- **Instance:** cc-01 (possibly customer care instance 01)

### Common Use Cases
- **Web Applications:** Hosting customer-facing web applications
- **API Services:** RESTful APIs for customer information management
- **Integration Services:** Connecting with other business systems
- **Customer Portal:** Self-service customer management interface

### Security Considerations
- **Production Environment:** Extra care required for changes
- **Customer Data:** May contain sensitive customer information
- **Compliance:** Follow organizational data protection policies
- **Change Management:** Use proper deployment processes

## 🔍 Integration with Governance Strategy

This App Service security group complements your existing portfolio:

### Resource-Level Groups
- **ENTRAID_RG_rg-catos-prd-01_CONTRIBUTOR_DEVELOPER** → Resource group contributor access
- **ENTRAID_AS_app-cim-prd-cc-01_CONTRIBUTOR_DEVELOPER** → App Service contributor access ← **NEW**

### Subscription-Level Groups
- **ENTRAID_N01_READER_ROLE** → N01 subscription
- **ENTRAID_N02_READER_ROLE** → N02 subscription
- **ENTRAID_C01_READER_ROLE** → C01 subscription
- **ENTRAID_I01_READER_ROLE** → I01 subscription
- **ENTRAID_P01_READER_ROLE** → P01 subscription
- **ENTRAID_P02_READER_ROLE** → P02 subscription
- **ENTRAID_S01_READER_ROLE** → S01 subscription

### Access Pattern
This follows a **granular resource-level access** approach:
- More specific than subscription-level access
- Focused on application management needs
- Contributor role for development and operations
- Targeted to specific App Service instance

## 📞 Support

For issues with this security group or App Service access:
1. **Group Management:** Contact Amir.Shahzad@condoauthorityontario.ca
2. **Role Assignment:** Complete assignment to AS app-cim-prd-cc-01 when ready
3. **App Service Issues:** Check Azure portal and application logs
4. **Access Issues:** Verify role assignment and resource permissions
5. **Technical Issues:** Review Azure AD audit logs and contact IT support

## 🔗 Quick Links

- **Azure Portal:** [https://portal.azure.com](https://portal.azure.com)
- **App Services:** [https://portal.azure.com/#view/HubsExtension/BrowseResource/resourceType/Microsoft.Web%2Fsites](https://portal.azure.com/#view/HubsExtension/BrowseResource/resourceType/Microsoft.Web%2Fsites)
- **Azure AD Groups:** [https://portal.azure.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups](https://portal.azure.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups)
- **Role Assignments:** [https://portal.azure.com/#view/Microsoft_Azure_PIM/CrossProviderActivationMenuBlade/~/aadmigratedRoles](https://portal.azure.com/#view/Microsoft_Azure_PIM/CrossProviderActivationMenuBlade/~/aadmigratedRoles)

## 📈 Governance Statistics

**Total Groups:** 8 subscription-level + 2 resource-level = **10 security groups**  
**Coverage:** Comprehensive subscription Reader + granular resource Contributor access  
**Consistency:** Standardized naming, ownership, and governance patterns  
**Scalability:** Ready for additional resources or access patterns

---
**Last Updated:** November 19, 2025  
**Next Review:** December 19, 2025  
**Status:** Group created, pending AS app-cim-prd-cc-01 role assignment
# Azure Tag Compliance Management

## 🎯 Overview

This repository contains scripts and documentation for managing Azure resource tag compliance across the N01 subscription and other Azure environments. Tag compliance is crucial for governance, cost management, and resource organization.

## 📋 Current Status

**Last Audit Date:** November 19, 2025  
**Subscription:** N01 (36e1a024-de9e-4454-84f2-3d5c0a2014bc)

### Compliance Summary
- **Resource Groups:** 14/55 compliant (25%)
- **Individual Resources:** 133/521 compliant (26%)
- **Total Non-compliant Items:** 429
- **Required Tags:** 4 standard governance tags

## 🏷️ Standard Tag Schema

All Azure resources and resource groups must have these tags:

| Tag Name | Value | Purpose |
|----------|--------|---------|
| `Project` | `Azure Landing Zone` | Project identification |
| `Dept` | `IT` | Department ownership |
| `Approved by` | `Tejinder` | Approval authority |
| `Requested by` | `Monty` | Original requester |

## 📁 Files in This Repository

### Tag Compliance Scripts
- **`tag-compliance-audit.ps1`** - Comprehensive audit script that checks all resource groups and resources for tag compliance
- **`tag-fix-resourcegroups.ps1`** - Automated fix script for resource group tags (41 resource groups)
- **`tag-fix-resources.ps1`** - Automated fix script for individual resource tags (388 resources)

### Azure Governance Documentation
- **`Azure-Governance/`** - Complete documentation for all Entra ID security groups and Azure governance

## 🚀 Usage Instructions

### Running the Audit

1. **Set Active Subscription:**
   ```powershell
   az account set --subscription "36e1a024-de9e-4454-84f2-3d5c0a2014bc"
   ```

2. **Run Compliance Audit:**
   ```powershell
   .\tag-compliance-audit.ps1
   ```

3. **Review Results:**
   - Check console output for compliance status
   - Review generated fix scripts

### Applying Tag Fixes

#### Resource Groups (Recommended First)
```powershell
# Apply all resource group tag fixes
.\tag-fix-resourcegroups.ps1

# Or apply individually for testing
az group update --name "rg-example" --tags "Project"="Azure Landing Zone" "Dept"="IT" "Approved by"="Tejinder" "Requested by"="Monty"
```

#### Individual Resources
```powershell
# Apply all resource tag fixes (WARNING: Large operation)
.\tag-fix-resources.ps1

# Or apply in batches
Get-Content .\tag-fix-resources.ps1 | Select-Object -First 50 | ForEach-Object { Invoke-Expression $_ }
```

### Verification
```powershell
# Re-run audit to verify fixes
.\tag-compliance-audit.ps1

# Check specific resource group
az group show --name "rg-example" --query "tags"

# Check specific resource
az resource show --ids "/subscriptions/.../resourceGroups/.../providers/..." --query "tags"
```

## 🏗️ Resource Group Categories

### Production Environments
- `rg-logicapps-it-cc-prod-1` - Production Logic Apps

### Development Environments
- `rg-catos-dev-*` - CATOS application development
- `rg-returns-dev-*` - Returns application development
- `rg-cim-d-cc-*` - Customer Information Management development
- `rg-connect365-dev-*` - Connect365 development
- `rg-catodr-dev-*` - CAT ODR development

### UAT/Staging Environments
- `rg-*-uat-*` - User Acceptance Testing environments
- `rg-*-stage-*` - Staging environments
- `rg-*-staging-*` - Staging environments

### QA/Test Environments
- `rg-*-qa-*` - Quality Assurance environments
- `rg-*-test-*` - Testing environments

### Shared Infrastructure
- `rg-*-shared-*` - Shared resources
- `n01-cc-rg-*` - Cloud operations and infrastructure
- `NetworkWatcherRG` - Azure Network Watcher
- `AzureBackupRG_*` - Azure Backup services

## 📊 Compliance Metrics

### Before Tag Remediation
| Category | Total | Compliant | Non-Compliant | Compliance % |
|----------|-------|-----------|---------------|--------------|
| Resource Groups | 55 | 14 | 41 | 25% |
| Resources | 521 | 133 | 388 | 26% |
| **Total** | **576** | **147** | **429** | **26%** |

### Target Compliance Goals
- **Resource Groups:** 100% compliance
- **Resources:** 95%+ compliance (some system resources may be excluded)
- **New Resources:** 100% compliance through automation and policies

## 🔄 Maintenance Process

### Monthly Tasks
1. **Run compliance audit** across all subscriptions
2. **Review new resources** for tag compliance
3. **Update fix scripts** for any new non-compliant resources
4. **Apply fixes** in batches to minimize impact

### Quarterly Tasks
1. **Review tag schema** for any updates
2. **Update documentation** with new patterns
3. **Validate governance policies** are enforcing tags
4. **Training updates** for development teams

## 🛡️ Best Practices

### When Creating New Resources
- **Always apply tags** during resource creation
- **Use ARM templates** or Bicep with tag parameters
- **Implement Azure Policy** to enforce tagging
- **Use resource group inheritance** where appropriate

### When Updating Existing Resources
- **Test tag changes** on non-production resources first
- **Apply in batches** to monitor for issues
- **Verify functionality** after tag application
- **Document any exceptions** for system resources

## 🔗 Related Documentation

### Azure Governance
- **Security Groups:** Complete Entra ID security group documentation in `Azure-Governance/`
- **Role Assignments:** Documentation for subscription and resource-level access
- **Access Management:** Patterns for user and application access

### Azure Resources
- **Subscription Portfolio:** N01, N02, C01, I01, P01, P02, S01 subscriptions
- **Application Stack:** CATOS, Returns, CIM, Connect365, ODR, PayByBank
- **Infrastructure:** VMs, App Services, Databases, Storage, Networking

## 📞 Support and Contacts

### Tag Governance
- **Owner:** Amir Shahzad (amir.shahzad@condoauthorityontario.ca)
- **Approved by:** Tejinder
- **Requested by:** Monty

### Technical Support
- **Azure Infrastructure:** IT Department
- **Security Groups:** Entra ID Administrators
- **Resource Management:** Cloud Operations Team

## 🎯 Future Enhancements

### Automation
- **Azure Policy:** Implement mandatory tagging policies
- **ARM Templates:** Update all templates with standard tags
- **CI/CD Integration:** Automatic tag validation in deployment pipelines

### Monitoring
- **Cost Management:** Tag-based cost allocation and reporting
- **Resource Tracking:** Automated resource lifecycle management
- **Compliance Dashboards:** Real-time compliance monitoring

### Governance
- **Tag Taxonomy:** Expand tag schema for additional metadata
- **Lifecycle Management:** Automated resource cleanup based on tags
- **Multi-Subscription:** Extend compliance across all subscriptions

---

**Last Updated:** November 19, 2025  
**Next Audit:** December 19, 2025  
**Status:** Tag compliance audit complete, ready for remediation
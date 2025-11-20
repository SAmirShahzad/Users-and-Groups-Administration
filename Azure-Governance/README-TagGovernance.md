# Azure Tag Governance Multi-Subscription Deployment

This repository contains scripts and documentation for deploying comprehensive Azure tag governance policies across multiple subscriptions. The solution implements a standardized 3-tag governance model with automatic inheritance and remediation capabilities.

## 📋 Overview

The tag governance solution implements:

- **Required Tags**: Environment, Owner, Project (mandatory for resource groups)
- **Tag Inheritance**: Automatic propagation from resource groups to child resources
- **Remediation**: Automatic fixing of existing non-compliant resources
- **RBAC**: Managed identity permissions for policy enforcement

## 🏗️ Architecture

### Policy Components

1. **Required Tag Policies** (Policy ID: `96670d01-0a4d-4649-9c89-2d3abc0a5025`)
   - Enforces mandatory tags on resource groups
   - Applied to: Environment, Owner, Project tags

2. **Tag Inheritance Policies** (Policy ID: `cd3aa116-8754-49c9-a813-ad46512ece54`)
   - Automatically inherits tags from resource group to child resources
   - Creates managed identities with Tag Contributor permissions
   - Applied to: Environment, Owner, Project tags

### Governance Flow

```
Resource Group Creation → Must have Environment/Owner/Project tags
       ↓
New Resource Creation → Automatically inherits tags from parent RG
       ↓
Existing Resources → Remediated via policy-driven tasks
```

## 📁 Files

| File | Description |
|------|-------------|
| `Deploy-TagGovernance-MultiSubscription.ps1` | PowerShell deployment script |
| `deploy-tag-governance.sh` | Bash/Azure CLI deployment script |
| `subscription-config.txt` | Subscription configuration and helper functions |
| `AzTagsReadmesync.md` | Complete implementation history and chat log |

## 🚀 Quick Start

### Prerequisites

1. **Azure CLI** installed and authenticated
   ```bash
   az login
   az account list --output table
   ```

2. **Appropriate permissions** on target subscriptions:
   - Policy Contributor
   - User Access Administrator (for RBAC assignments)

### Option 1: PowerShell Script

```powershell
# Dry run to preview changes
.\Deploy-TagGovernance-MultiSubscription.ps1 -SubscriptionIds @("sub-id-1", "sub-id-2") -DryRun

# Actual deployment
.\Deploy-TagGovernance-MultiSubscription.ps1 -SubscriptionIds @("36e1a024-de9e-4454-84f2-3d5c0a2014bc", "edfdf882-6e18-4946-85dd-502c22c07569")

# Custom configuration
.\Deploy-TagGovernance-MultiSubscription.ps1 `
  -SubscriptionIds @("sub-id") `
  -Location "eastus" `
  -RequiredTags @("Environment", "Owner", "Project", "CostCenter") `
  -CreateRemediation $true
```

### Option 2: Bash Script

```bash
# Make script executable
chmod +x deploy-tag-governance.sh

# Dry run to preview changes
./deploy-tag-governance.sh --dry-run 36e1a024-de9e-4454-84f2-3d5c0a2014bc edfdf882-6e18-4946-85dd-502c22c07569

# Actual deployment
./deploy-tag-governance.sh 36e1a024-de9e-4454-84f2-3d5c0a2014bc edfdf882-6e18-4946-85dd-502c22c07569

# Custom location
./deploy-tag-governance.sh --location eastus sub-id-1 sub-id-2
```

## 📊 Available Subscriptions

Based on your Azure environment:

### Development/Test (Recommended for initial testing)
- `n01`: 36e1a024-de9e-4454-84f2-3d5c0a2014bc
- `n02`: edfdf882-6e18-4946-85dd-502c22c07569
- Various Dev/Test subscriptions (see `subscription-config.txt`)

### Production (Deploy after testing)
- `p01`: 0fa0e70d-9209-4a78-90fa-76cafcceedf1
- `p02`: 27bc2fdd-b261-4aeb-b298-5e713d97d85c

### Reference (Already configured)
- `s01`: eb638095-1683-4289-bdc3-cffc016329d8 ✅

## 📝 Step-by-Step Deployment

### Phase 1: Testing (Dev/Test Subscriptions)

1. **Dry Run Validation**
   ```bash
   ./deploy-tag-governance.sh --dry-run 36e1a024-de9e-4454-84f2-3d5c0a2014bc
   ```

2. **Deploy to Single Test Subscription**
   ```bash
   ./deploy-tag-governance.sh 36e1a024-de9e-4454-84f2-3d5c0a2014bc
   ```

3. **Verify Deployment**
   ```bash
   az account set --subscription 36e1a024-de9e-4454-84f2-3d5c0a2014bc
   az policy assignment list --query "[?contains(displayName, 'tag') || contains(displayName, 'Tag')].{Name:displayName, TagName:parameters.tagName.value}" --output table
   ```

4. **Test Tag Inheritance**
   ```bash
   # Create test resource group with required tags
   az group create \
     --name "test-rg-tags" \
     --location "canadacentral" \
     --tags Environment="Test" Owner="YourName" Project="TagGovernanceTest"
   
   # Create a resource and verify tag inheritance
   az storage account create \
     --name "teststoragetagtest$(date +%s)" \
     --resource-group "test-rg-tags" \
     --location "canadacentral" \
     --sku "Standard_LRS"
   
   # Check if tags were inherited
   az storage account show --name "teststoragetagtest$(date +%s)" --resource-group "test-rg-tags" --query "tags"
   ```

### Phase 2: Scaling (Multiple Non-Prod)

```bash
# Deploy to multiple non-production subscriptions
./deploy-tag-governance.sh 36e1a024-de9e-4454-84f2-3d5c0a2014bc edfdf882-6e18-4946-85dd-502c22c07569 abb7f2ff-1d93-49f5-934a-e51e418bbf87
```

### Phase 3: Production (With Careful Review)

```bash
# Always dry run first for production
./deploy-tag-governance.sh --dry-run 0fa0e70d-9209-4a78-90fa-76cafcceedf1

# Deploy to production after approval
./deploy-tag-governance.sh 0fa0e70d-9209-4a78-90fa-76cafcceedf1
```

## 🔍 Monitoring and Verification

### Check Policy Assignments

```bash
az policy assignment list --subscription <subscription-id> --query "[?contains(displayName, 'tag') || contains(displayName, 'Tag')].{Name:displayName, TagName:parameters.tagName.value, Status:enforcementMode}" --output table
```

### Monitor Remediation Status

```bash
az policy remediation list --subscription <subscription-id> --output table
```

### Verify Tag Inheritance

```bash
# List resource groups and their tags
az group list --subscription <subscription-id> --query "[].{Name:name, Tags:tags}" --output table

# List resources and their tags in a specific resource group
az resource list --resource-group <rg-name> --query "[].{Name:name, Type:type, Tags:tags}" --output table
```

## 🛠️ Troubleshooting

### Common Issues

1. **Permission Errors**
   ```
   Error: "insufficient privileges to complete the operation"
   ```
   **Solution**: Ensure you have Policy Contributor and User Access Administrator roles

2. **Policy Assignment Already Exists**
   ```
   Error: "policy assignment with name 'Inherit-Environment-Tag' already exists"
   ```
   **Solution**: Use `az policy assignment delete` to remove existing assignments first

3. **Managed Identity Permission Issues**
   ```
   Error: "The client does not have authorization to perform action"
   ```
   **Solution**: Wait 5-10 minutes for role assignments to propagate, or manually assign Tag Contributor role

4. **Remediation Task Failures**
   ```
   Check remediation status and logs
   ```
   **Solution**: Ensure managed identities have proper permissions and re-run remediation

### Manual Cleanup

If you need to remove tag policies from a subscription:

```bash
# List all tag-related policy assignments
az policy assignment list --subscription <subscription-id> --query "[?contains(displayName, 'tag') || contains(displayName, 'Tag')].{Name:name, DisplayName:displayName}" --output table

# Delete specific policy assignments
az policy assignment delete --name "Inherit-Environment-Tag" --subscription <subscription-id>
az policy assignment delete --name "Require-Environment-Tag-RG" --subscription <subscription-id>
```

## 📈 Expected Results

After successful deployment:

- **6 Policy Assignments** per subscription (3 required + 3 inheritance)
- **3 Managed Identities** with Tag Contributor permissions
- **Automatic tag inheritance** for new resources
- **Remediation tasks** for existing non-compliant resources

### Success Metrics

- New resource groups must have Environment, Owner, Project tags
- New resources automatically inherit tags from parent resource group
- Existing resources receive tags through remediation tasks
- Policy compliance reports show 100% compliance after remediation

## 🔗 References

- [Azure Policy Documentation](https://docs.microsoft.com/en-us/azure/governance/policy/)
- [Tag Governance Best Practices](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/decision-guides/resource-tagging/)
- [Built-in Policy Definitions](https://docs.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
- [Policy Remediation](https://docs.microsoft.com/en-us/azure/governance/policy/how-to/remediate-resources)

---

## 📞 Support

For questions or issues with this deployment:

1. Check the `AzTagsReadmesync.md` file for complete implementation history
2. Review Azure Policy compliance reports in the portal
3. Verify managed identity permissions and role assignments
4. Test with a small resource in a dev/test environment first
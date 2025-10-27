# Users and Groups Administration

This repository contains infrastructure as code (IaC) templates and scripts for managing Azure AD users and groups across different environments.

## Repository Structure

```
Users-and-Groups-Administration/
├── Prod/
│   ├── terraform.tf     # Terraform configuration for production
│   ├── azurecli.sh      # Azure CLI script for production
│   ├── bicep.bicep      # Bicep template for production
│   └── powershell.ps1   # PowerShell script for production
├── Test/
│   ├── terraform.tf     # Terraform configuration for test
│   ├── azurecli.sh      # Azure CLI script for test
│   ├── bicep.bicep      # Bicep template for test
│   └── powershell.ps1   # PowerShell script for test
└── README.md           # This file
```

## Prerequisites

### For Terraform
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- Azure CLI or Azure PowerShell for authentication
- Appropriate Azure AD permissions

### For Azure CLI
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) >= 2.0
- Authenticated session with `az login`
- Azure AD Global Administrator or User Administrator role

### For Bicep
- [Azure CLI with Bicep extension](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
- Resource group for Azure resources
- Azure AD permissions for user/group management

### For PowerShell
- [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell) >= 7.0
- Microsoft Graph PowerShell modules:
  ```powershell
  Install-Module Microsoft.Graph.Authentication
  Install-Module Microsoft.Graph.Groups
  Install-Module Microsoft.Graph.Users
  ```

## Usage

### Production Environment

#### Using Terraform
```bash
cd Prod
terraform init
terraform plan
terraform apply
```

#### Using Azure CLI
```bash
cd Prod
chmod +x azurecli.sh
./azurecli.sh
```

#### Using Bicep
```bash
cd Prod
# Create resource group first
az group create --name rg-users-groups-prod --location eastus
az deployment group create --resource-group rg-users-groups-prod --template-file bicep.bicep
```

#### Using PowerShell
```powershell
cd Prod
.\powershell.ps1
```

### Test Environment

#### Using Terraform
```bash
cd Test
terraform init
terraform plan
terraform apply
```

#### Using Azure CLI
```bash
cd Test
chmod +x azurecli.sh
./azurecli.sh
```

#### Using Bicep
```bash
cd Test
# Create resource group first
az group create --name rg-users-groups-test --location eastus
az deployment group create --resource-group rg-users-groups-test --template-file bicep.bicep
```

#### Using PowerShell
```powershell
cd Test
.\powershell.ps1
```

## Environment Differences

### Production Environment
- Creates production-focused users and groups
- Implements stricter security settings
- Uses production naming conventions
- Includes administrative accounts

### Test Environment
- Creates multiple test users for testing scenarios
- Includes developer groups
- Uses test naming conventions
- Focuses on testing and development scenarios

## Security Considerations

1. **Passwords**: All scripts use placeholder passwords. In production:
   - Use Azure Key Vault for password storage
   - Implement proper password policies
   - Consider using managed identities where possible

2. **Permissions**: Ensure proper RBAC assignments:
   - Minimum required permissions for service accounts
   - Regular review of group memberships
   - Implement Just-In-Time access where applicable

3. **Monitoring**: Implement logging and monitoring:
   - Azure AD audit logs
   - Security alerts for unusual activities
   - Regular access reviews

## Customization

Before running any scripts, update the following:

1. **Domain Names**: Replace `yourdomain.com` with your actual domain
2. **User Names**: Modify user principal names and display names
3. **Group Names**: Adjust group names to match your organization
4. **Passwords**: Implement secure password generation and storage
5. **Resource Names**: Update Azure resource names to match your naming conventions

## Contributing

1. Create feature branches for changes
2. Test changes in the Test environment first
3. Update documentation for any new features
4. Follow infrastructure as code best practices

## Support

For issues and questions:
1. Check the documentation in each script
2. Review Azure AD documentation
3. Check Terraform/Bicep/Azure CLI documentation
4. Create issues in this repository

## License

This project is licensed under the MIT License - see the LICENSE file for details.
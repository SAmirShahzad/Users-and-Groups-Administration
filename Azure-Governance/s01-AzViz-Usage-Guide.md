# AzViz Usage Guide for s01 Sandbox Subscription

**Date**: November 13, 2025  
**Subscription**: s01 (eb638095-1683-4289-bdc3-cffc016329d8)  
**Status**: ✅ Successfully Installed and Configured

## 🎯 Installation Summary

### ✅ **Complete Installation Achieved**:
- **GraphViz**: ✅ Installed via Windows Package Manager (v14.0.2)
- **AzViz Module**: ✅ Installed from PowerShell Gallery (v1.2.1)
- **Azure Connection**: ✅ Connected to s01 sandbox subscription
- **Test Run**: ✅ Successfully generated visualizations

## 📋 Available Resource Groups in s01

| Resource Group | Purpose | Resources |
|---|---|---|
| **s01-cc-rg-cldops-1** | Main Cloud Operations | 86 resources (VMs, Storage, Synapse, etc.) |
| **rg-it-developer-pratik** | Developer Environment | Development resources |
| **rg-it-consultant-catos-alina** | Consultant Environment | Consultant resources |
| **rg-avd-resources** | Azure Virtual Desktop | AVD resources |
| **dashboards** | Azure Dashboards | Portal dashboards |
| **resource-graph-queries** | Resource Graph Queries | Query collections |
| **azure-governance-queries_group** | Governance Queries | Governance resources |
| **NetworkWatcherRG** | Network Monitoring | Network Watcher resources |
| **AzureBackupRG_canadacentral_1** | Backup Services | Backup resources |
| **vm-it-start-stop-automation-1** | VM Automation | Start/Stop automation |
| **s01-cc-rg-rsv-1** | Recovery Services | Recovery vault |
| **DefaultResourceGroup-EUS** | Default East US | Default resources |
| **synapseworkspace-managedrg-***** | Synapse Managed RG | Synapse managed resources |

## 🚀 Quick Start Commands

### **Basic Usage Pattern**
```powershell
# 1. Set the s01 subscription context
Set-AzContext -SubscriptionId "eb638095-1683-4289-bdc3-cffc016329d8"

# 2. Generate visualization
Export-AzViz -ResourceGroup "resource-group-name" -Theme light -OutputFormat png -Show
```

### **Example Visualizations for Your Environment**

#### **1. Cloud Operations Overview (Main Environment)**
```powershell
# Comprehensive view of your main cloud operations
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1" -Theme light -OutputFormat svg -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-main-infrastructure.svg" -CategoryDepth 1 -LabelVerbosity 1
```
**Result**: 86 resources including VMs, Synapse, Storage, Network components

#### **2. Developer Environment**
```powershell
# Visualize developer resources
Export-AzViz -ResourceGroup "rg-it-developer-pratik" -Theme dark -OutputFormat png -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-developer-env.png" -Show
```

#### **3. Azure Virtual Desktop Resources**
```powershell
# AVD infrastructure visualization
Export-AzViz -ResourceGroup "rg-avd-resources" -Theme neon -OutputFormat svg -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-avd-infrastructure.svg"
```

#### **4. Multiple Resource Groups Overview**
```powershell
# Combined view of key resource groups
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1","rg-avd-resources","rg-it-developer-pratik" -Theme light -OutputFormat png -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-combined-overview.png" -Show -LabelVerbosity 1
```

## 🎨 Visualization Options

### **Themes Available**:
```powershell
# Light theme (best for documentation)
-Theme light

# Dark theme (modern look)
-Theme dark

# Neon theme (colorful highlights)
-Theme neon
```

### **Output Formats**:
```powershell
# PNG for presentations
-OutputFormat png

# SVG for web and scalability
-OutputFormat svg
```

### **Detail Levels**:
```powershell
# Basic labeling
-LabelVerbosity 1

# Detailed labeling with resource types
-LabelVerbosity 2

# Simple categorization
-CategoryDepth 1

# Detailed subcategorization
-CategoryDepth 2
```

## 📁 Organized Output Structure

```
C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\
├── s01-main-infrastructure.svg         # Main cloud ops (86 resources)
├── s01-developer-env.png              # Developer environment
├── s01-avd-infrastructure.svg         # AVD resources
├── s01-combined-overview.png          # Multiple RGs
├── s01-dashboards.png                 # Portal dashboards
└── s01-governance-queries.svg         # Governance resources
```

## 🔍 Specific Use Cases for Your Environment

### **1. Infrastructure Documentation**
```powershell
# Create comprehensive infrastructure documentation
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1" -Theme light -OutputFormat svg -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-infrastructure-doc.svg" -CategoryDepth 2 -LabelVerbosity 2
```

### **2. Network Topology Focus**
```powershell
# Focus on network relationships in main environment
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1" -Theme dark -OutputFormat png -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-network-topology.png" -CategoryDepth 2 -Show
```

### **3. Quick Resource Overview**
```powershell
# Simple overview for presentations
Export-AzViz -ResourceGroup "dashboards","resource-graph-queries" -Theme light -OutputFormat png -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-quick-overview.png" -Show
```

## 🔧 Advanced Features

### **Exclude Specific Resource Types**
```powershell
# Exclude specific resource types from visualization
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1" -Theme light -OutputFormat svg -ExcludedResourceTypes "microsoft.insights/components","microsoft.storage/storageaccounts/blobservices" -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-filtered.svg"
```

### **Custom Output Directory**
```powershell
# Always specify custom output path for organized storage
-OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\filename.format"
```

## 📊 Your s01 Environment Analysis

### **✅ Successfully Discovered**:
- **Main Infrastructure**: 86 resources in s01-cc-rg-cldops-1
  - Virtual Machines (vm-pratik-dev, aem-project-vm)
  - Synapse Workspace (s01-cc-syn-test-1)
  - Storage Accounts (stdwtestcc2, crmdiag393)
  - Network Infrastructure (Public IPs, NICs, Route Tables)
  - Azure Compute Gallery
  - Private DNS Zones
  - Managed Identities

- **Development Environment**: rg-it-developer-pratik
- **AVD Infrastructure**: rg-avd-resources
- **Governance Tools**: Multiple query and dashboard resource groups

## 🚀 Quick Commands for Daily Use

```powershell
# Quick check of main infrastructure
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1" -Theme light -OutputFormat png -Show

# Network-focused view
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1" -Theme dark -OutputFormat svg -CategoryDepth 2 -Show

# Multiple environments overview
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1","rg-avd-resources" -Theme neon -OutputFormat png -Show

# Documentation-ready visualization
Export-AzViz -ResourceGroup "s01-cc-rg-cldops-1" -Theme light -OutputFormat svg -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\s01-documentation-$(Get-Date -Format 'yyyy-MM-dd').svg" -CategoryDepth 2 -LabelVerbosity 2
```

## 🎯 Integration with Your Tag Governance

Since you have comprehensive tag governance implemented on s01, your visualizations will show:
- **Properly tagged resources** with Environment, Owner, Project tags
- **Resource relationships** respecting tag inheritance
- **Governance compliance** visible through consistent labeling

This makes AzViz perfect for:
- **Audit presentations** showing tagged resources
- **Compliance documentation** with proper governance
- **Infrastructure reviews** with organized resource categorization

---

**🎉 AzViz is now ready for production use in your s01 sandbox environment!**

*All visualizations are saved to `C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\` for easy access and organization.*
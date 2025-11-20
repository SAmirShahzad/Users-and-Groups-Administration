# AzViz - Azure Environment Visualization Tool Installation Guide

**Date**: November 13, 2025  
**Purpose**: Install and configure AzViz for Azure environment visualization

## 🎯 What is AzViz?

**AzViz (Azure Visualizer)** is a PowerShell module that automatically generates Azure resource topology diagrams. It can:

- ✅ Find resources in Azure Resource Groups and identify dependencies
- ✅ Plot nodes and edges to represent Azure Resources and their relationships
- ✅ Insert appropriate Azure icons based on resource category/sub-category
- ✅ Label resources with Name, Category, Type, etc.
- ✅ Generate visualizations in .png and .svg formats
- ✅ Support light, dark, and neon themes
- ✅ Target multiple resource groups at once
- ✅ Show network topology including VNets and subnets

## 🔧 Prerequisites

### Step 1: Install GraphViz (Required Dependency)

AzViz requires GraphViz to be installed on your system before you can use the PowerShell module.

#### **Windows Installation (Multiple Options)**:

**Option 1: Using Chocolatey (Recommended)**
```powershell
# Install chocolatey if not already installed
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install GraphViz using chocolatey
choco install graphviz
```

**Option 2: Using Windows Package Manager**
```powershell
winget install graphviz
```

**Option 3: Manual Download**
- Download from: https://graphviz.org/download/
- Install the Windows package manually

#### **Verify GraphViz Installation**:
```powershell
# Check if GraphViz is properly installed
dot -V
```
Expected output should show GraphViz version information.

---

## 📦 AzViz Installation

### Method 1: PowerShell Gallery (Recommended)

```powershell
# Install AzViz from PowerShell Gallery
Install-Module -Name AzViz -Scope CurrentUser -Repository PSGallery -Force

# Import the module
Import-Module AzViz

# Verify installation
Get-Module AzViz -ListAvailable
```

### Method 2: Clone from GitHub (Development)

```powershell
# Clone the project from GitHub
git clone https://github.com/PrateekKumarSingh/AzViz.git
Set-Location .\AzViz\AzViz

# Import the PowerShell module
Import-Module .\AzViz.psm1 -Verbose
```

---

## 🔐 Azure Authentication Setup

```powershell
# Connect to Azure (required for AzViz to work)
Connect-AzAccount

# Verify you're connected to the correct subscription
Get-AzContext

# If needed, switch to a specific subscription
Set-AzContext -SubscriptionId "your-subscription-id"
```

---

## 🚀 Quick Usage Examples

### Basic Single Resource Group Visualization
```powershell
# Generate diagram for a single resource group
Export-AzViz -ResourceGroup "your-resource-group-name" -Theme light -OutputFormat png -Show
```

### Multiple Resource Groups
```powershell
# Target multiple resource groups
Export-AzViz -ResourceGroup "rg1", "rg2", "rg3" -LabelVerbosity 1 -CategoryDepth 1 -Theme light -Show -OutputFormat png
```

### Advanced Visualization with More Details
```powershell
# More detailed visualization with subcategories
Export-AzViz -ResourceGroup "your-resource-group" -Theme dark -OutputFormat png -Show -CategoryDepth 2 -LabelVerbosity 2
```

### Network Topology Focus
```powershell
# Focus on network infrastructure
Export-AzViz -ResourceGroup "network-rg" -Theme neon -OutputFormat svg -Show -CategoryDepth 2
```

---

## 🎨 Available Options

### **Themes**:
- `light` - Light theme with white background
- `dark` - Dark theme with black background  
- `neon` - Neon theme with colorful highlights

### **Output Formats**:
- `png` - PNG image format
- `svg` - SVG vector format

### **Parameters**:
- `-ResourceGroup` - Target resource group(s)
- `-Theme` - Visual theme (light/dark/neon)
- `-OutputFormat` - Output file format (png/svg)
- `-Show` - Automatically open the generated diagram
- `-CategoryDepth` - Level of resource categorization detail (1-3)
- `-LabelVerbosity` - Amount of information in labels (0-2)

---

## 📋 Installation Verification Script

```powershell
# Complete verification script
Write-Host "🔍 Checking AzViz Installation..." -ForegroundColor Cyan

# Check GraphViz
try {
    $graphVizVersion = dot -V 2>&1
    Write-Host "✅ GraphViz installed: $graphVizVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ GraphViz not found. Please install GraphViz first." -ForegroundColor Red
    return
}

# Check AzViz module
$azVizModule = Get-Module AzViz -ListAvailable
if ($azVizModule) {
    Write-Host "✅ AzViz module installed: Version $($azVizModule.Version)" -ForegroundColor Green
} else {
    Write-Host "❌ AzViz module not found." -ForegroundColor Red
    return
}

# Check Azure connection
$azContext = Get-AzContext
if ($azContext) {
    Write-Host "✅ Azure connected: $($azContext.Account.Id)" -ForegroundColor Green
    Write-Host "   Subscription: $($azContext.Subscription.Name)" -ForegroundColor Gray
} else {
    Write-Host "⚠️  Not connected to Azure. Run 'Connect-AzAccount'" -ForegroundColor Yellow
}

Write-Host "`n🚀 AzViz is ready to use!" -ForegroundColor Green
```

---

## 🏢 Using AzViz with Your Current Environment

Based on your Azure environment with 17 subscriptions, here are some specific examples:

### Visualize Your Core Infrastructure
```powershell
# Set target subscription
Set-AzContext -SubscriptionId "8660919b-cf35-405f-80f6-479f7337219c"  # i01 - Identity

# Generate visualization for identity infrastructure
Export-AzViz -ResourceGroup "identity-rg" -Theme dark -OutputFormat png -Show -CategoryDepth 2
```

### Visualize Production Environment
```powershell
# Production 01
Set-AzContext -SubscriptionId "0fa0e70d-9209-4a78-90fa-76cafcceedf1"  # p01
Export-AzViz -ResourceGroup "production-rg" -Theme light -OutputFormat svg -Show -LabelVerbosity 2
```

### Network Topology Visualization
```powershell
# Network infrastructure
Set-AzContext -SubscriptionId "36e1a024-de9e-4454-84f2-3d5c0a2014bc"  # n01
Export-AzViz -ResourceGroup "network-rg" -Theme neon -OutputFormat png -Show -CategoryDepth 2
```

---

## 🔍 Troubleshooting

### Common Issues:

1. **GraphViz not found**:
   - Ensure GraphViz is installed and in PATH
   - Restart PowerShell after installation

2. **Azure connection issues**:
   - Run `Connect-AzAccount` to authenticate
   - Verify correct subscription with `Get-AzContext`

3. **Empty diagrams**:
   - Ensure the resource group exists and has resources
   - Check permissions on the target resource group

4. **Module import errors**:
   - Run PowerShell as Administrator
   - Update PowerShellGet: `Install-Module PowerShellGet -Force`

---

## 📚 Additional Resources

- **GitHub Repository**: https://github.com/PrateekKumarSingh/AzViz
- **PowerShell Gallery**: https://www.powershellgallery.com/packages/AzViz
- **Demo Video**: https://www.youtube.com/watch?v=7rsNGJ-QmEA
- **Documentation**: http://azviz.readthedocs.io/

---

*This installation guide will help you set up AzViz to create beautiful visualizations of your Azure environment, which is especially valuable given your comprehensive tag governance implementation across 8 subscriptions.*
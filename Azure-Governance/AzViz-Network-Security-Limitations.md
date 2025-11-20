# AzViz Limitations & Enhanced Network Security Visualization Guide

**Date**: November 13, 2025  
**Issue**: AzViz doesn't show IP addresses, NSG rules, inbound/outbound configurations  
**Analysis**: Understanding AzViz limitations and alternative approaches

## 🔍 **Why AzViz Doesn't Show Detailed Network Information**

### **AzViz Design Focus**:
- **Primary Purpose**: High-level resource topology and relationships
- **Target Audience**: Infrastructure overview, not detailed network security
- **Data Source**: ARM templates and Network Watcher topology (limited detail)
- **Visualization Engine**: GraphViz (optimized for simple node-edge relationships)

### **What AzViz Shows**:
✅ Resource types and categories  
✅ Resource relationships (parent-child, dependencies)  
✅ Resource names and basic metadata  
✅ Network topology (high-level connections)  

### **What AzViz Doesn't Show**:
❌ Private/Public IP addresses  
❌ NSG rules (inbound/outbound)  
❌ Subnet CIDR ranges  
❌ Route table details  
❌ Security group associations  
❌ Port configurations  
❌ Load balancer rules  
❌ Firewall policies  

---

## 🔍 **Your Environment Analysis - Detailed Network Security**

### **Discovered NSGs in s01 Subscription**:
| NSG Name | Resource Group | Associated Resource |
|----------|----------------|-------------------|
| vm-it-catos-consultant-alina1-nic-*-nsg | rg-it-consultant-catos-alina | Consultant VM |
| quick-vm-nsg | S01-CC-RG-CLDOPS-1 | AEM Project VM |
| vm-it-cc-1VMNic-nsg | s01-cc-rg-cldops-1 | VM 1 |
| vm-it-cc-2NSG | s01-cc-rg-cldops-1 | VM 2 |
| vm-it-cc-3NSG | s01-cc-rg-cldops-1 | VM 3 |
| vm-pratik-devNSG | s01-cc-rg-cldops-1 | Developer VM |

### **Sample NSG Rules Found**:
**Consultant VM NSG Rules**:
- **Rule**: `MicrosoftDefenderForCloud-JITRule_*`
- **Priority**: 4096
- **Direction**: Inbound
- **Access**: Deny
- **Protocol**: All (*)
- **Destination**: 10.22.50.7 (Consultant VM)
- **Port**: 3389 (RDP)
- **Source**: Any (*)

### **IP Address Assignments**:
| VM Name | Resource Group | Private IP | Public IP | NSG |
|---------|----------------|------------|-----------|-----|
| vm-avd-it-0 | rg-avd-resources | 10.22.50.13 | None | Not displayed by AzViz |
| vm-avd-it-1 | rg-avd-resources | 10.22.50.12 | None | Not displayed by AzViz |
| vm-it-catos-consultant-alina1 | rg-it-consultant-catos-alina | 10.22.50.7 | None | Has JIT access rules |

---

## 🎯 **Enhanced Visualization Approaches**

### **Method 1: Custom PowerShell Network Diagram Script**

```powershell
# Enhanced network visualization with security details
function Get-AzureNetworkDetails {
    param($ResourceGroupName)
    
    Write-Host "🔍 Analyzing Network Security for: $ResourceGroupName" -ForegroundColor Cyan
    
    # Get VMs with detailed network info
    $vms = az vm list --resource-group $ResourceGroupName --query "[].{Name:name, ResourceGroup:resourceGroup}" -o json | ConvertFrom-Json
    
    foreach ($vm in $vms) {
        Write-Host "`n🖥️  VM: $($vm.Name)" -ForegroundColor Green
        
        # Get IP addresses
        $ipInfo = az vm list-ip-addresses --ids $(az vm show --name $vm.Name --resource-group $vm.ResourceGroup --query id -o tsv) --query "[0]" -o json | ConvertFrom-Json
        
        if ($ipInfo.virtualMachine.network.privateIpAddresses) {
            Write-Host "   Private IP: $($ipInfo.virtualMachine.network.privateIpAddresses[0])" -ForegroundColor Yellow
        }
        
        if ($ipInfo.virtualMachine.network.publicIpAddresses) {
            Write-Host "   Public IP: $($ipInfo.virtualMachine.network.publicIpAddresses[0].ipAddress)" -ForegroundColor Yellow
        } else {
            Write-Host "   Public IP: None (Private only)" -ForegroundColor Gray
        }
        
        # Get associated NSG
        $nic = az network nic list --query "[?contains(virtualMachine.id, '$($vm.Name)')].{Name:name, NSG:networkSecurityGroup.id}" -o json | ConvertFrom-Json
        
        if ($nic.NSG) {
            $nsgName = ($nic.NSG -split '/')[-1]
            Write-Host "   NSG: $nsgName" -ForegroundColor Magenta
            
            # Get NSG rules
            $rules = az network nsg rule list --nsg-name $nsgName --resource-group $vm.ResourceGroup --query "[].{Name:name, Priority:priority, Direction:direction, Access:access, Protocol:protocol, SourcePort:sourcePortRange, DestPort:destinationPortRange}" -o json | ConvertFrom-Json
            
            foreach ($rule in $rules) {
                Write-Host "     Rule: $($rule.Name) | $($rule.Direction) | $($rule.Access) | Port: $($rule.DestPort)" -ForegroundColor White
            }
        }
    }
}

# Run the analysis
Get-AzureNetworkDetails -ResourceGroupName "rg-avd-resources"
Get-AzureNetworkDetails -ResourceGroupName "rg-it-consultant-catos-alina"
```

### **Method 2: Azure Resource Graph Query for Network Details**

```powershell
# Comprehensive network security query
$query = @"
Resources
| where type in ('microsoft.network/networkinterfaces', 'microsoft.network/networksecuritygroups', 'microsoft.network/publicipaddresses')
| extend resourceGroup = tostring(resourceGroup)
| where resourceGroup in ('rg-avd-resources', 'rg-it-consultant-catos-alina')
| project name, type, resourceGroup, location, properties
"@

az graph query -q $query --output table
```

---

## 🛠️ **Alternative Network Visualization Tools**

### **1. Azure Network Watcher Topology**
```powershell
# Use Network Watcher for detailed network topology
az network watcher show-topology --resource-group "rg-avd-resources" --output table
```

### **2. Custom Visio Diagram with Full Details**
Create enhanced Visio diagrams showing:
- VM names with IP addresses
- NSG rules as annotations
- Subnet boundaries with CIDR ranges
- Security flow directions

### **3. Azure Monitor Network Insights**
- Native Azure portal visualization
- Shows traffic flows, NSG hits, security alerts
- Real-time network performance

### **4. Third-Party Tools**
- **Lucidchart Azure Import**: Better network detail support
- **Draw.io with Azure Stencils**: Manual but comprehensive
- **CloudCraft**: 3D Azure architecture with security details

---

## 🎯 **Enhanced AzViz Workaround**

### **Step 1: Generate Base Topology with AzViz**
```powershell
Export-AzViz -ResourceGroup "rg-avd-resources" -Theme light -OutputFormat svg -OutputFilePath "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\base-topology.svg"
```

### **Step 2: Collect Detailed Network Data**
```powershell
# Export detailed network configuration to CSV
$networkDetails = @()

$vms = az vm list --query "[].{Name:name, ResourceGroup:resourceGroup}" -o json | ConvertFrom-Json
foreach ($vm in $vms) {
    $ipInfo = az vm list-ip-addresses --name $vm.Name --resource-group $vm.ResourceGroup --query "[0].virtualMachine.network" -o json | ConvertFrom-Json
    
    $detail = [PSCustomObject]@{
        VMName = $vm.Name
        ResourceGroup = $vm.ResourceGroup
        PrivateIP = $ipInfo.privateIpAddresses[0]
        PublicIP = if($ipInfo.publicIpAddresses) { $ipInfo.publicIpAddresses[0].ipAddress } else { "None" }
        SubnetId = $ipInfo.networkInterfaces[0].ipConfigurations[0].subnet.id
    }
    $networkDetails += $detail
}

$networkDetails | Export-Csv "C:\Users\AmirShahzad\.azure\Azure-Governance\AzViz-Output\network-details.csv" -NoTypeInformation
```

### **Step 3: Manual Enhancement in Visio**
1. Import AzViz SVG as base layout
2. Add IP address labels manually
3. Include NSG rule annotations
4. Create security boundary zones

---

## 📊 **Comprehensive Network Security Report**

### **Why This Information is Missing from AzViz**:

1. **Scope Limitation**: AzViz focuses on resource relationships, not detailed configurations
2. **ARM Template Source**: Limited to what's exported in ARM templates
3. **Performance**: Including all security details would make diagrams cluttered
4. **Use Case**: Designed for high-level architecture, not security auditing

### **Better Tools for Network Security Visualization**:

| Tool | IP Addresses | NSG Rules | Security Details | Automation |
|------|-------------|-----------|------------------|------------|
| **AzViz** | ❌ | ❌ | ❌ | ✅ |
| **Network Watcher** | ✅ | ✅ | ✅ | ⚠️ |
| **Azure Monitor** | ✅ | ✅ | ✅ | ✅ |
| **Custom PowerShell** | ✅ | ✅ | ✅ | ✅ |
| **Manual Visio** | ✅ | ✅ | ✅ | ❌ |

---

## 🎯 **Recommendation for Your Environment**

### **For Quick Overview**: Use AzViz (current approach)
### **For Security Details**: Use the PowerShell script above
### **For Professional Docs**: Combine AzViz + manual Visio enhancement
### **For Monitoring**: Azure Network Watcher + Monitor

**🔍 The limitation you've identified is a fundamental design choice in AzViz - it prioritizes simplicity and high-level topology over detailed network security configuration display.**
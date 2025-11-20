# Azure Tag Compliance Audit and Fix Script
# N01 Subscription - Resource Groups and Resources Tagging Audit

Write-Host "🏷️ Azure Tag Compliance Audit - N01 Subscription" -ForegroundColor Green
Write-Host "Date: $(Get-Date)" -ForegroundColor Yellow
Write-Host "Subscription: N01 (36e1a024-de9e-4454-84f2-3d5c0a2014bc)" -ForegroundColor Yellow
Write-Host ""

# Define standard tags that should be on all resources
$standardTags = @{
    "Project" = "Azure Landing Zone"
    "Dept" = "IT" 
    "Approved by" = "Tejinder"
    "Requested by" = "Monty"
}

Write-Host "📋 Standard Tags Required:" -ForegroundColor Cyan
foreach ($tag in $standardTags.GetEnumerator()) {
    Write-Host "   $($tag.Key): $($tag.Value)" -ForegroundColor White
}
Write-Host ""

# Get all resource groups
Write-Host "🔍 Auditing Resource Groups..." -ForegroundColor Yellow
$resourceGroups = az group list --query "[].name" -o tsv

$missingTagsRGs = @()
$compliantRGs = @()

foreach ($rg in $resourceGroups) {
    Write-Host "Checking: $rg" -ForegroundColor Gray
    
    $currentTags = az group show --name $rg --query "tags" -o json | ConvertFrom-Json
    $missingTags = @()
    
    foreach ($requiredTag in $standardTags.GetEnumerator()) {
        if (-not $currentTags -or -not $currentTags.PSObject.Properties.Name.Contains($requiredTag.Key)) {
            $missingTags += $requiredTag
        }
    }
    
    if ($missingTags.Count -gt 0) {
        $missingTagsRGs += @{
            ResourceGroup = $rg
            MissingTags = $missingTags
            CurrentTags = $currentTags
        }
        Write-Host "   ❌ Missing $($missingTags.Count) tags" -ForegroundColor Red
    } else {
        $compliantRGs += $rg
        Write-Host "   ✅ Compliant" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "📊 Resource Group Audit Results:" -ForegroundColor Green
Write-Host "   ✅ Compliant: $($compliantRGs.Count)" -ForegroundColor Green
Write-Host "   ❌ Non-compliant: $($missingTagsRGs.Count)" -ForegroundColor Red
Write-Host "   📁 Total: $($resourceGroups.Count)" -ForegroundColor Yellow

if ($missingTagsRGs.Count -gt 0) {
    Write-Host ""
    Write-Host "❌ Resource Groups Missing Tags:" -ForegroundColor Red
    foreach ($rgInfo in $missingTagsRGs) {
        Write-Host "   📂 $($rgInfo.ResourceGroup)" -ForegroundColor Cyan
        foreach ($tag in $rgInfo.MissingTags) {
            Write-Host "      Missing: $($tag.Key) = $($tag.Value)" -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "🔧 Generating Fix Commands for Resource Groups..." -ForegroundColor Yellow

$fixCommands = @()
foreach ($rgInfo in $missingTagsRGs) {
    $tagString = ""
    foreach ($tag in $rgInfo.MissingTags) {
        $tagString += """$($tag.Key)""=""$($tag.Value)"" "
    }
    if ($tagString) {
        $fixCommands += "az group update --name ""$($rgInfo.ResourceGroup)"" --tags $($tagString.Trim())"
    }
}

if ($fixCommands.Count -gt 0) {
    $fixCommands | Out-File -FilePath "C:\Users\AmirShahzad\.azure\tag-fix-resourcegroups.ps1" -Encoding UTF8
    Write-Host "✅ Fix commands saved to: tag-fix-resourcegroups.ps1" -ForegroundColor Green
}

Write-Host ""
Write-Host "🔍 Now checking resources within resource groups..." -ForegroundColor Yellow
Write-Host ""

# Check resources within each resource group
$resourceIssues = @()
$checkedResources = 0

foreach ($rg in $resourceGroups) {
    Write-Host "Checking resources in: $rg" -ForegroundColor Gray
    
    $resources = az resource list --resource-group $rg --query "[].{Name:name, Type:type, Id:id}" -o json | ConvertFrom-Json
    
    if ($resources) {
        foreach ($resource in $resources) {
            $checkedResources++
            $resourceTags = az resource show --ids $resource.Id --query "tags" -o json | ConvertFrom-Json
            
            $resourceMissingTags = @()
            foreach ($requiredTag in $standardTags.GetEnumerator()) {
                if (-not $resourceTags -or -not $resourceTags.PSObject.Properties.Name.Contains($requiredTag.Key)) {
                    $resourceMissingTags += $requiredTag
                }
            }
            
            if ($resourceMissingTags.Count -gt 0) {
                $resourceIssues += @{
                    ResourceGroup = $rg
                    ResourceName = $resource.Name
                    ResourceType = $resource.Type
                    ResourceId = $resource.Id
                    MissingTags = $resourceMissingTags
                }
                Write-Host "   ❌ $($resource.Name) missing $($resourceMissingTags.Count) tags" -ForegroundColor Red
            } else {
                Write-Host "   ✅ $($resource.Name)" -ForegroundColor Green
            }
        }
    }
}

Write-Host ""
Write-Host "📊 Resource Audit Results:" -ForegroundColor Green
Write-Host "   🔍 Resources checked: $checkedResources" -ForegroundColor Yellow
Write-Host "   ❌ Resources with missing tags: $($resourceIssues.Count)" -ForegroundColor Red
Write-Host "   ✅ Compliant resources: $($checkedResources - $resourceIssues.Count)" -ForegroundColor Green

if ($resourceIssues.Count -gt 0) {
    Write-Host ""
    Write-Host "🔧 Generating Fix Commands for Resources..." -ForegroundColor Yellow
    
    $resourceFixCommands = @()
    foreach ($issue in $resourceIssues) {
        $tagString = ""
        foreach ($tag in $issue.MissingTags) {
            $tagString += """$($tag.Key)""=""$($tag.Value)"" "
        }
        if ($tagString) {
            $resourceFixCommands += "az resource update --ids ""$($issue.ResourceId)"" --tags $($tagString.Trim())"
        }
    }
    
    $resourceFixCommands | Out-File -FilePath "C:\Users\AmirShahzad\.azure\tag-fix-resources.ps1" -Encoding UTF8
    Write-Host "✅ Resource fix commands saved to: tag-fix-resources.ps1" -ForegroundColor Green
}

Write-Host ""
Write-Host "🎯 Summary:" -ForegroundColor Green
Write-Host "   📂 Resource Groups: $($compliantRGs.Count)/$($resourceGroups.Count) compliant" -ForegroundColor White
Write-Host "   🏗️ Resources: $($checkedResources - $resourceIssues.Count)/$checkedResources compliant" -ForegroundColor White
Write-Host ""
Write-Host "📁 Generated Files:" -ForegroundColor Cyan
if ($fixCommands.Count -gt 0) {
    Write-Host "   • tag-fix-resourcegroups.ps1" -ForegroundColor White
}
if ($resourceFixCommands.Count -gt 0) {
    Write-Host "   • tag-fix-resources.ps1" -ForegroundColor White
}
Write-Host ""
Write-Host "✅ Audit Complete!" -ForegroundColor Green
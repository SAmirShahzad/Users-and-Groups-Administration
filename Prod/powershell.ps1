# PowerShell script for Users and Groups Administration - Production Environment
# This script manages Azure AD users and groups using PowerShell and Microsoft Graph

# Import required modules
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Groups
Import-Module Microsoft.Graph.Users

# Connect to Microsoft Graph
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Yellow
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"

# Variables
$prodGroupName = "Production Users"
$prodGroupDescription = "Production environment users group"
$prodAdminDisplayName = "Production Administrator"
$prodAdminUPN = "prodadmin@yourdomain.com"

try {
    # Create Production Users Group
    Write-Host "Creating production users group..." -ForegroundColor Green
    
    $groupParams = @{
        DisplayName = $prodGroupName
        Description = $prodGroupDescription
        MailEnabled = $false
        SecurityEnabled = $true
        MailNickname = ($prodGroupName -replace ' ', '-').ToLower()
    }
    
    $prodGroup = New-MgGroup @groupParams
    Write-Host "Production Users group created with ID: $($prodGroup.Id)" -ForegroundColor Green
    
    # Create Production Admin User
    Write-Host "Creating production admin user..." -ForegroundColor Green
    
    # Generate a secure password
    $password = ConvertTo-SecureString "SecurePassword123!" -AsPlainText -Force
    
    $userParams = @{
        DisplayName = $prodAdminDisplayName
        UserPrincipalName = $prodAdminUPN
        MailNickname = ($prodAdminUPN -split '@')[0]
        PasswordProfile = @{
            Password = "SecurePassword123!"
            ForceChangePasswordNextSignIn = $true
        }
        AccountEnabled = $true
    }
    
    $prodUser = New-MgUser @userParams
    Write-Host "Production admin user created with ID: $($prodUser.Id)" -ForegroundColor Green
    
    # Add user to group
    Write-Host "Adding user to production users group..." -ForegroundColor Green
    
    New-MgGroupMember -GroupId $prodGroup.Id -DirectoryObjectId $prodUser.Id
    Write-Host "User successfully added to the group!" -ForegroundColor Green
    
    # Verify group membership
    Write-Host "Verifying group membership..." -ForegroundColor Yellow
    $groupMembers = Get-MgGroupMember -GroupId $prodGroup.Id
    
    Write-Host "Current members of Production Users group:" -ForegroundColor Cyan
    foreach ($member in $groupMembers) {
        $memberDetails = Get-MgUser -UserId $member.Id
        Write-Host "- $($memberDetails.DisplayName) ($($memberDetails.UserPrincipalName))" -ForegroundColor White
    }
    
    Write-Host "Production environment users and groups setup completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
} finally {
    # Disconnect from Microsoft Graph
    Disconnect-MgGraph
    Write-Host "Disconnected from Microsoft Graph." -ForegroundColor Yellow
}
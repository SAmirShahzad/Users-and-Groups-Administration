# PowerShell script for Users and Groups Administration - Test Environment
# This script manages Azure AD users and groups using PowerShell and Microsoft Graph

# Import required modules
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Groups
Import-Module Microsoft.Graph.Users

# Connect to Microsoft Graph
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Yellow
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"

# Variables
$testGroupName = "Test Users"
$testGroupDescription = "Test environment users group"
$testDevGroupName = "Test Developers"
$testDevGroupDescription = "Test environment developers group"
$testAdminDisplayName = "Test Administrator"
$testAdminUPN = "testadmin@yourdomain.com"
$numberOfTestUsers = 3

try {
    # Create Test Users Group
    Write-Host "Creating test users group..." -ForegroundColor Green
    
    $testGroupParams = @{
        DisplayName = $testGroupName
        Description = $testGroupDescription
        MailEnabled = $false
        SecurityEnabled = $true
        MailNickname = ($testGroupName -replace ' ', '-').ToLower()
    }
    
    $testGroup = New-MgGroup @testGroupParams
    Write-Host "Test Users group created with ID: $($testGroup.Id)" -ForegroundColor Green
    
    # Create Test Developers Group
    Write-Host "Creating test developers group..." -ForegroundColor Green
    
    $testDevGroupParams = @{
        DisplayName = $testDevGroupName
        Description = $testDevGroupDescription
        MailEnabled = $false
        SecurityEnabled = $true
        MailNickname = ($testDevGroupName -replace ' ', '-').ToLower()
    }
    
    $testDevGroup = New-MgGroup @testDevGroupParams
    Write-Host "Test Developers group created with ID: $($testDevGroup.Id)" -ForegroundColor Green
    
    # Create Test Admin User
    Write-Host "Creating test admin user..." -ForegroundColor Green
    
    $testAdminParams = @{
        DisplayName = $testAdminDisplayName
        UserPrincipalName = $testAdminUPN
        MailNickname = ($testAdminUPN -split '@')[0]
        PasswordProfile = @{
            Password = "TestPassword123!"
            ForceChangePasswordNextSignIn = $true
        }
        AccountEnabled = $true
    }
    
    $testAdminUser = New-MgUser @testAdminParams
    Write-Host "Test admin user created with ID: $($testAdminUser.Id)" -ForegroundColor Green
    
    # Add test admin to both groups
    Write-Host "Adding test admin to groups..." -ForegroundColor Green
    New-MgGroupMember -GroupId $testGroup.Id -DirectoryObjectId $testAdminUser.Id
    New-MgGroupMember -GroupId $testDevGroup.Id -DirectoryObjectId $testAdminUser.Id
    
    # Create additional test users
    Write-Host "Creating $numberOfTestUsers additional test users..." -ForegroundColor Green
    $testUsers = @()
    
    for ($i = 1; $i -le $numberOfTestUsers; $i++) {
        $testUserUPN = "testuser$i@yourdomain.com"
        $testUserDisplayName = "Test User $i"
        
        $testUserParams = @{
            DisplayName = $testUserDisplayName
            UserPrincipalName = $testUserUPN
            MailNickname = "testuser$i"
            PasswordProfile = @{
                Password = "TestUserPassword123!"
                ForceChangePasswordNextSignIn = $true
            }
            AccountEnabled = $true
        }
        
        $testUser = New-MgUser @testUserParams
        $testUsers += $testUser
        
        # Add user to test users group
        New-MgGroupMember -GroupId $testGroup.Id -DirectoryObjectId $testUser.Id
        
        Write-Host "Test user $i created and added to group: $testUserDisplayName" -ForegroundColor Green
    }
    
    # Verify group memberships
    Write-Host "`nVerifying group memberships..." -ForegroundColor Yellow
    
    # Test Users Group
    Write-Host "`nCurrent members of Test Users group:" -ForegroundColor Cyan
    $testGroupMembers = Get-MgGroupMember -GroupId $testGroup.Id
    foreach ($member in $testGroupMembers) {
        $memberDetails = Get-MgUser -UserId $member.Id
        Write-Host "- $($memberDetails.DisplayName) ($($memberDetails.UserPrincipalName))" -ForegroundColor White
    }
    
    # Test Developers Group
    Write-Host "`nCurrent members of Test Developers group:" -ForegroundColor Cyan
    $testDevGroupMembers = Get-MgGroupMember -GroupId $testDevGroup.Id
    foreach ($member in $testDevGroupMembers) {
        $memberDetails = Get-MgUser -UserId $member.Id
        Write-Host "- $($memberDetails.DisplayName) ($($memberDetails.UserPrincipalName))" -ForegroundColor White
    }
    
    # Summary
    Write-Host "`n=== SUMMARY ===" -ForegroundColor Magenta
    Write-Host "Groups created: 2" -ForegroundColor White
    Write-Host "- Test Users ($($testGroup.Id))" -ForegroundColor White
    Write-Host "- Test Developers ($($testDevGroup.Id))" -ForegroundColor White
    Write-Host "Users created: $($numberOfTestUsers + 1)" -ForegroundColor White
    Write-Host "- 1 Test Administrator" -ForegroundColor White
    Write-Host "- $numberOfTestUsers Test Users" -ForegroundColor White
    
    Write-Host "`nTest environment users and groups setup completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    Write-Host "Error details: $($_.Exception)" -ForegroundColor Red
} finally {
    # Disconnect from Microsoft Graph
    Disconnect-MgGraph
    Write-Host "`nDisconnected from Microsoft Graph." -ForegroundColor Yellow
}
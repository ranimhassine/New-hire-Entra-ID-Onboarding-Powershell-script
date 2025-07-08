param (
    [Parameter(Mandatory)]
    [string]$DisplayName,

    [Parameter(Mandatory)]
    [string]$UserPrincipalName,

    [Parameter(Mandatory)]
    [string]$MailNickname,

    [Parameter(Mandatory)]
    [string]$InitialPassword,

    [Parameter(Mandatory)]
    [string]$Department,

    [Parameter(Mandatory)]
    [string]$JobTitle,

    [string[]]$GroupIds = @(),  # Optional: Group Object IDs to add user to

    [string]$UsageLocation = "US",  # Optional: Used for license assignment

    [string]$SkuId = ""  # Optional: License SKU ID (e.g., Office 365)
)

# Connect to Graph (if not already connected)
if (-not (Get-MgContext)) {
    Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"
}

# Step 1: Create the user
$userParams = @{
    DisplayName = $DisplayName
    MailNickname = $MailNickname
    UserPrincipalName = $UserPrincipalName
    AccountEnabled = $true
    PasswordProfile = @{
        ForceChangePasswordNextSignIn = $true
        Password = $InitialPassword
    }
    UsageLocation = $UsageLocation
    Department = $Department
    JobTitle = $JobTitle
}

$newUser = New-MgUser @userParams
Write-Host " User '$DisplayName' created successfully."

# Step 2: Add user to groups
foreach ($groupId in $GroupIds) {
    try {
        Add-MgGroupMember -GroupId $groupId -DirectoryObjectId $newUser.Id
        Write-Host "Added to group: $groupId"
    } catch {
        Write-Warning " Failed to add to group ${groupId}: $_"
    }
}

# Step 3: Assign license (optional)
if ($SkuId -ne "") {
    $licenseParams = @{
        AddLicenses = @(
            @{
                SkuId = $SkuId
            }
        )
        RemoveLicenses = @()
    }

    Set-MgUserLicense -UserId $newUser.Id -BodyParameter $licenseParams
    Write-Host "License assigned: $SkuId"
}

Write-Host "Onboarding complete for: $DisplayName"

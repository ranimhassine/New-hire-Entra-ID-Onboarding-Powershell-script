# 🧑‍💼 Azure AD User Onboarding Script

This PowerShell script simplifies the process of onboarding new users in Microsoft Entra ID (Azure Active Directory). It automates user creation, group assignment, and license provisioning using Microsoft Graph PowerShell.

## 📋 Features

- Creates a new Azure AD user with specified attributes
- Adds the user to one or more Azure AD groups
- Optionally assigns a license to the user
- Supports department and job title tagging
- Connects securely using Microsoft Graph

## 🚀 Usage

```powershell
.\Onboard-AADUser.ps1 `
    -DisplayName "Jane Doe" `
    -UserPrincipalName "jane.doe@yourdomain.com" `
    -MailNickname "janedoe" `
    -InitialPassword "P@ssword123!" `
    -Department "Marketing" `
    -JobTitle "Content Manager" `
    -GroupIds @("group-id-1", "group-id-2") `
    -UsageLocation "US" `
    -SkuId "license-sku-id"
```

## 🔧 Parameters

| Name | Required | Description |
|------|----------|-------------|
| `DisplayName` | ✅ | Full name of the user |
| `UserPrincipalName` | ✅ | User's sign-in address |
| `MailNickname` | ✅ | Alias used for email |
| `InitialPassword` | ✅ | Temporary password (user must change at first sign-in) |
| `Department` | ✅ | User's department |
| `JobTitle` | ✅ | User's job title |
| `GroupIds` | ❌ | Array of group Object IDs for group membership |
| `UsageLocation` | ❌ | Country code for license assignment (default: US) |
| `SkuId` | ❌ | License SKU ID (e.g., for Microsoft 365) |

> ℹ️ **Note**: Ensure you have the correct permissions (User.ReadWrite.All, Group.ReadWrite.All, Directory.ReadWrite.All) and that you are connected via `Connect-MgGraph`.

## ✅ Requirements

- PowerShell 7+
- Microsoft Graph PowerShell SDK (Microsoft.Graph module)

### Installation

Install the required module using:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

## 🔐 Permissions Needed

This script uses Microsoft Graph and requires the following delegated permissions:

- `User.ReadWrite.All`
- `Group.ReadWrite.All`
- `Directory.ReadWrite.All`

## 📝 Example

Here's a complete example of how to use the script:

```powershell
# First, connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"

# Run the onboarding script
.\Onboard-AADUser.ps1 `
    -DisplayName "John Smith" `
    -UserPrincipalName "john.smith@company.com" `
    -MailNickname "johnsmith" `
    -InitialPassword "TempPass123!" `
    -Department "IT" `
    -JobTitle "Software Developer" `
    -GroupIds @("12345678-1234-1234-1234-123456789012") `
    -UsageLocation "US" `
    -SkuId "c42b9cae-ea4f-4ab7-9717-81576235ccac"
```

## 🛠️ Troubleshooting

### Common Issues

1. **Authentication Error**: Make sure you're connected to Microsoft Graph using `Connect-MgGraph`
2. **Permission Denied**: Verify you have the required permissions listed above
3. **Invalid Group ID**: Ensure the Group IDs are valid Object IDs from Azure AD
4. **License Assignment Failed**: Check that the SKU ID is correct and licenses are available

### Getting Group IDs

To find Group Object IDs:

```powershell
Get-MgGroup -Filter "displayName eq 'Your Group Name'" | Select-Object Id, DisplayName
```

### Getting License SKU IDs

To find available license SKUs:

```powershell
Get-MgSubscribedSku | Select-Object SkuId, SkuPartNumber
```

## 📄 License

This script is provided as-is for educational and administrative purposes. Please ensure compliance with your organization's policies and Microsoft's terms of service.

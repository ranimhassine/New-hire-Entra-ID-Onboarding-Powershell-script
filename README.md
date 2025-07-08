🧑‍💼 Azure AD User Onboarding Script
This PowerShell script simplifies the process of onboarding new users in Microsoft Entra ID (Azure Active Directory). It automates user creation, group assignment, and license provisioning using Microsoft Graph PowerShell.

📋 Features
Creates a new Azure AD user with specified attributes

Adds the user to one or more Azure AD groups

Optionally assigns a license to the user

Supports department and job title tagging

Connects securely using Microsoft Graph

🚀 Usage
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
🔧 Parameters
Name	Required	Description
DisplayName	✅	Full name of the user
UserPrincipalName	✅	User’s sign-in address
MailNickname	✅	Alias used for email
InitialPassword	✅	Temporary password (user must change at first sign-in)
Department	✅	User’s department
JobTitle	✅	User’s job title
GroupIds	❌	Array of group Object IDs for group membership
UsageLocation	❌	Country code for license assignment (default: US)
SkuId	❌	License SKU ID (e.g., for Microsoft 365)

ℹ️ Ensure you have the correct permissions (User.ReadWrite.All, Group.ReadWrite.All, Directory.ReadWrite.All) and that you are connected via Connect-MgGraph.

✅ Requirements
PowerShell 7+

Microsoft Graph PowerShell SDK (Microsoft.Graph module)

Install it using:

Install-Module Microsoft.Graph -Scope CurrentUser
🔐 Permissions Needed
This script uses Microsoft Graph and requires the following delegated permissions:

User.ReadWrite.All

Group.ReadWrite.All

Directory.ReadWrite.All

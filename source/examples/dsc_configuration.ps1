
<#PSScriptInfo

.VERSION 0.0.2

.GUID 52c929ef-be26-4714-8804-4707b2628008

.AUTHOR Gael Colas

.COMPANYNAME SynEdgy Limited

.COPYRIGHT (c) 2021 Gael Colas. All rights reserved.

.TAGS

.LICENSEURI https://github.com/chocolatey-community/Chocolatey/blob/master/LICENSE

.PROJECTURI https://github.com/chocolatey-community/Chocolatey/

.ICONURI https://blog.chocolatey.org/assets/images/chocolatey-icon.png

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES
Updated author, copyright notice, and URLs.

.PRIVATEDATA

#>

<#

.DESCRIPTION
 This is an unofficial module with DSC resource to Install and configure Chocolatey.

#>

param ()


configuration Default {
    Import-DscResource -ModuleName Chocolatey

    Node localhost {
        ChocolateySoftware nugetproviderRemove {
            Ensure = 'Present'
        }
    }
}

configuration Remove {
    Import-DscResource -ModuleName Chocolatey

    Node localhost {
        ChocolateySoftware nugetproviderRemove {
            Ensure = 'Absent'
        }
    }
}

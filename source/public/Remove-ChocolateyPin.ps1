<#
.SYNOPSIS
    Remove a Pin from a Chocolatey Package

.DESCRIPTION
    Allows you to remove a pinned Chocolatey Package like choco pin remove -n=packagename

.PARAMETER Name
    Name of the Chocolatey Package to remove the pin.

.EXAMPLE
    Remove-ChocolateyPin -Name 'PackageName'

.NOTES
    https://chocolatey.org/docs/commands-pin
#>
function Remove-ChocolateyPin
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High'
    )]
    param (
        [Parameter(
            Mandatory = $true
            , ValueFromPipelineByPropertyName
        )]
        [Alias('Package')]
        [System.String]
        $Name
    )

    process
    {
        if (-not ($chocoCmd = Get-Command 'choco.exe' -CommandType Application -ErrorAction SilentlyContinue))
        {
            throw "Chocolatey Software not found."
        }

        if (!(Get-ChocolateyPackage -Name $Name))
        {
            throw "The Pin for Chocolatey Package $Name cannot be found."
        }

        $ChocoArguments = @('pin', 'remove', '-r')
        $ChocoArguments += Get-ChocolateyDefaultArgument @PSBoundParameters
        # Write-Debug "choco $($ChocoArguments -join ' ')"

        if ($PSCmdlet.ShouldProcess("$Name", "Remove Pin"))
        {
            $Output = &$chocoCmd $ChocoArguments

            # LASTEXITCODE is always 0 unless point an existing version (0 when remove but already removed)
            if ($LASTEXITCODE -ne 0)
            {
                throw ("Error when trying to remove Pin for {0}.`r`n {1}" -f "$Name", ($output -join "`r`n"))
            }
            else
            {
                $output | Write-Verbose
            }
        }
    }
}

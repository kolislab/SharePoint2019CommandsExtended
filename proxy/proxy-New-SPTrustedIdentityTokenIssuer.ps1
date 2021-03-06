function New-SPTrustedIdentityTokenIssuer() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='BasicParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Name},

    [Parameter(ParameterSetName='BasicParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Description},

    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet')]
    [ValidateNotNull()]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${ImportTrustCertificate},

    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true)]
    [ValidateNotNull()]
    [uri]
    ${MetadataEndPoint},

    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='BasicParameterSet', Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPClaimMappingPipeBind[]]
    ${ClaimsMappings},

    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='BasicParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SignInUrl},

    [Parameter(ParameterSetName='BasicParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${IdentifierClaim},

    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [Microsoft.SharePoint.PowerShell.SPClaimProviderPipeBind]
    ${ClaimProvider},

    [Parameter(ParameterSetName='BasicParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true)]
    [ValidateNotNull()]
    [string]
    ${Realm},

    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet')]
    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [switch]
    ${UseWReply},

    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet', Mandatory=$true)]
    [switch]
    ${UseDefaultConfiguration},

    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet')]
    [ValidateSet('EMAIL','USER-PRINCIPAL-NAME','ACCOUNT-NAME')]
    [string]
    ${IdentifierClaimIs},

    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [Parameter(ParameterSetName='BasicParameterSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SignOutUrl},

    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='ActiveDirectoryBackedParameterSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${RegisteredIssuerName},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPAssignmentCollection]
    ${AssignmentCollection})

begin
{
    try {
        $startTime = [DateTime]::Now
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPTrustedIdentityTokenIssuer', [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process
{
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end
{
    try {
        $steppablePipeline.End()
        $elapsedTime = New-TimeSpan $startTime ([DateTime]::Now)
        Send-SharePointTelemetry -Inputobject $PSCmdlet.CommandRuntime.ToString() -Properties @{"elapsedTime" = $elapsedTime;"ParameterSet" = $PSCmdlet.ParameterSetName}
    } catch {
        throw
    }
}
<#

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPTrustedIdentityTokenIssuer
.ForwardHelpCategory Cmdlet

#>
}

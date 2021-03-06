function Set-SPTrustedIdentityTokenIssuer() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='BasicParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='ImportCertificateParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPTrustedIdentityTokenIssuerPipeBind]
    ${Identity},

    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [Parameter(ParameterSetName='ImportCertificateParameterSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Description},

    [Parameter(ParameterSetName='ImportCertificateParameterSet', Mandatory=$true)]
    [ValidateNotNull()]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${ImportTrustCertificate},

    [Parameter(ParameterSetName='MetadataEndPointParameterSet', Mandatory=$true)]
    [ValidateNotNull()]
    [uri]
    ${MetadataEndPoint},

    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [Parameter(ParameterSetName='ImportCertificateParameterSet')]
    [Microsoft.SharePoint.PowerShell.SPClaimMappingPipeBind[]]
    ${ClaimsMappings},

    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [Parameter(ParameterSetName='ImportCertificateParameterSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SignInUrl},

    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [Parameter(ParameterSetName='ImportCertificateParameterSet')]
    [Parameter(ParameterSetName='BasicParameterSet')]
    [Microsoft.SharePoint.PowerShell.SPClaimProviderPipeBind]
    ${ClaimProvider},

    [Parameter(ParameterSetName='ImportCertificateParameterSet')]
    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [string]
    ${Realm},

    [Parameter(ParameterSetName='ImportCertificateParameterSet')]
    [Parameter(ParameterSetName='BasicParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [switch]
    ${UseWReply},

    [Parameter(ParameterSetName='ImportCertificateParameterSet')]
    [Parameter(ParameterSetName='MetadataEndPointParameterSet')]
    [Parameter(ParameterSetName='BasicParameterSet')]
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPTrustedIdentityTokenIssuer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPTrustedIdentityTokenIssuer
.ForwardHelpCategory Cmdlet

#>
}

function Set-SPSecurityTokenServiceConfig() {
[CmdletBinding(DefaultParameterSetName='SigningCertificateImport', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(ParameterSetName='SigningCertificateImport')]
    [ValidateNotNull()]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${ImportSigningCertificate},

    [Parameter(ParameterSetName='SigningCertificateReference')]
    [string]
    ${SigningCertificateThumbprint},

    [Parameter(ParameterSetName='SigningCertificateReference')]
    [string]
    ${SigningCertificateStoreName},

    [Parameter(ParameterSetName='SigningCertificateQueue')]
    [ValidateNotNull()]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${QueueSigningCertificate},

    [Parameter(ParameterSetName='SigningCertificateReference')]
    [string]
    ${QueueSigningCertificateThumbprint},

    [Parameter(ParameterSetName='SigningCertificateReference')]
    [string]
    ${QueueSigningCertificateStoreName},

    [Parameter(ParameterSetName='SigningCertificateRevoke')]
    [ValidateNotNull()]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${RevokeSigningCertificate},

    [Parameter(ParameterSetName='RevokeSigningCertificateReference', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${RevokeSigningCertificateThumbprint},

    [Parameter(ParameterSetName='RevokeSigningCertificateReference')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${RevokeSigningCertificateStoreName},

    [int]
    ${ServiceTokenLifetime},

    [int]
    ${ServiceTokenCacheExpirationWindow},

    [int]
    ${FormsTokenLifetime},

    [int]
    ${WindowsTokenLifetime},

    [int]
    ${MaxLogonTokenCacheItems},

    [int]
    ${MaxServiceTokenCacheItems},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPSecurityTokenServiceConfig', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPSecurityTokenServiceConfig
.ForwardHelpCategory Cmdlet

#>
}

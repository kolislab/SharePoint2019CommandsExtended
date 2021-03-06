function Set-SPServiceHostConfig() {
[CmdletBinding(DefaultParameterSetName='SslCertificateImport', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(ParameterSetName='SslCertificateImport', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SslCertificateReferenceRunInProcess', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SslCertificateReference', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.Administration.SPIisWebServiceSettings, Microsoft.SharePoint, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${Identity},

    [Parameter(ParameterSetName='SslCertificateReference')]
    [Parameter(ParameterSetName='SslCertificateImport')]
    [Alias('Port')]
    [ValidateRange(1, 65535)]
    [int]
    ${HttpPort},

    [Parameter(ParameterSetName='SslCertificateReference')]
    [Parameter(ParameterSetName='SslCertificateImport')]
    [Alias('SecurePort')]
    [ValidateRange(1, 65535)]
    [int]
    ${HttpsPort},

    [Parameter(ParameterSetName='SslCertificateReference')]
    [Parameter(ParameterSetName='SslCertificateImport')]
    [ValidateRange(1, 65535)]
    [int]
    ${NetTcpPort},

    [Parameter(ParameterSetName='SslCertificateReference', Mandatory=$true)]
    [Parameter(ParameterSetName='SslCertificateReferenceRunInProcess', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SslCertificateThumbprint},

    [Parameter(ParameterSetName='SslCertificateReferenceRunInProcess')]
    [Parameter(ParameterSetName='SslCertificateReference')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SslCertificateStoreName},

    [Parameter(ParameterSetName='SslCertificateImport')]
    [ValidateNotNull()]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${ImportSslCertificate},

    [Parameter(ParameterSetName='SslCertificateReference')]
    [Parameter(ParameterSetName='SslCertificateImport')]
    [switch]
    ${NoWait},

    [Parameter(ParameterSetName='SslCertificateReferenceRunInProcess', Mandatory=$true)]
    [switch]
    ${RunInProcess},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPServiceHostConfig', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPServiceHostConfig
.ForwardHelpCategory Cmdlet

#>
}

function New-SPWebApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [string]
    ${Name},

    [Parameter(Mandatory=$true)]
    [string]
    ${ApplicationPool},

    [Microsoft.SharePoint.PowerShell.SPProcessAccountPipeBind]
    ${ApplicationPoolAccount},

    [Alias('ProxyGroup')]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationProxyGroupPipeBind]
    ${ServiceApplicationProxyGroup},

    [switch]
    ${SecureSocketsLayer},

    [string]
    ${HostHeader},

    [uint32]
    ${Port},

    [switch]
    ${AllowAnonymousAccess},

    [string]
    ${Path},

    [string]
    ${Url},

    [ValidateSet('Kerberos','NTLM')]
    [string]
    ${AuthenticationMethod},

    [Microsoft.SharePoint.PowerShell.SPAuthenticationProviderPipeBind[]]
    ${AuthenticationProvider},

    [Microsoft.SharePoint.PowerShell.SPClaimProviderPipeBind[]]
    ${AdditionalClaimProvider},

    [string]
    ${SignInRedirectURL},

    [Microsoft.SharePoint.PowerShell.SPTrustedIdentityTokenIssuerPipeBind]
    ${SignInRedirectProvider},

    [Microsoft.SharePoint.PowerShell.SPUserSettingsProviderPipeBind]
    ${UserSettingsProvider},

    [pscredential]
    ${DatabaseCredentials},

    [string]
    ${DatabaseServer},

    [string]
    ${DatabaseName},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPWebApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPWebApplication
.ForwardHelpCategory Cmdlet

#>
}

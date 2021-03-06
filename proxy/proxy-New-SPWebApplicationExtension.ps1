function New-SPWebApplicationExtension() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${Identity},

    [Parameter(Mandatory=$true)]
    [string]
    ${Name},

    [Parameter(Mandatory=$true)]
    [Microsoft.SharePoint.Administration.SPUrlZone]
    ${Zone},

    [uint32]
    ${Port},

    [string]
    ${HostHeader},

    [string]
    ${Path},

    [string]
    ${Url},

    [ValidateSet('Kerberos','NTLM')]
    [string]
    ${AuthenticationMethod},

    [switch]
    ${AllowAnonymousAccess},

    [switch]
    ${SecureSocketsLayer},

    [Microsoft.SharePoint.PowerShell.SPAuthenticationProviderPipeBind[]]
    ${AuthenticationProvider},

    [Microsoft.SharePoint.PowerShell.SPClaimProviderPipeBind[]]
    ${AdditionalClaimProvider},

    [string]
    ${SignInRedirectURL},

    [Microsoft.SharePoint.PowerShell.SPTrustedIdentityTokenIssuerPipeBind]
    ${SignInRedirectProvider},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPWebApplicationExtension', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPWebApplicationExtension
.ForwardHelpCategory Cmdlet

#>
}

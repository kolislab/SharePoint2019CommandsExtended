function Set-SPWebApplication() {
[CmdletBinding(DefaultParameterSetName='UpdateGeneralSettings', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${Identity},

    [Parameter(ParameterSetName='UpdateClaimSettings', Mandatory=$true)]
    [Microsoft.SharePoint.Administration.SPUrlZone]
    ${Zone},

    [Parameter(ParameterSetName='UpdateGeneralSettings')]
    [int]
    ${DefaultTimeZone},

    [Parameter(ParameterSetName='UpdateGeneralSettings')]
    [string]
    ${DefaultQuotaTemplate},

    [Parameter(ParameterSetName='UpdateMailSettings', Mandatory=$true)]
    [string]
    ${SMTPServer},

    [Parameter(ParameterSetName='UpdateMailSettings')]
    [switch]
    ${DisableSMTPEncryption},

    [Parameter(ParameterSetName='UpdateMailSettings')]
    [pscredential]
    ${SMTPCredentials},

    [Parameter(ParameterSetName='UpdateMailSettings')]
    [int]
    ${SMTPServerPort},

    [Parameter(ParameterSetName='UpdateMailSettings')]
    [string]
    ${OutgoingEmailAddress},

    [Parameter(ParameterSetName='UpdateMailSettings')]
    [string]
    ${ReplyToEmailAddress},

    [Parameter(ParameterSetName='UpdateGeneralSettings')]
    [Alias('ProxyGroup')]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationProxyGroupPipeBind]
    ${ServiceApplicationProxyGroup},

    [Parameter(ParameterSetName='UpdateClaimSettings')]
    [Microsoft.SharePoint.PowerShell.SPAuthenticationProviderPipeBind[]]
    ${AuthenticationProvider},

    [Parameter(ParameterSetName='UpdateClaimSettings')]
    [Microsoft.SharePoint.PowerShell.SPClaimProviderPipeBind[]]
    ${AdditionalClaimProvider},

    [Parameter(ParameterSetName='UpdateClaimSettings')]
    [string]
    ${SignInRedirectURL},

    [Parameter(ParameterSetName='UpdateClaimSettings')]
    [Microsoft.SharePoint.PowerShell.SPTrustedIdentityTokenIssuerPipeBind]
    ${SignInRedirectProvider},

    [Parameter(ParameterSetName='UpdateClaimSettings')]
    [ValidateSet('Kerberos','NTLM')]
    [string]
    ${AuthenticationMethod},

    [switch]
    ${Force},

    [switch]
    ${NotProvisionGlobally},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPWebApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPWebApplication
.ForwardHelpCategory Cmdlet

#>
}

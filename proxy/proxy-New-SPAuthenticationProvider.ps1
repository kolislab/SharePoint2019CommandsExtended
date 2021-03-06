function New-SPAuthenticationProvider() {
[CmdletBinding(DefaultParameterSetName='Windows')]
param(
    [Parameter(ParameterSetName='Windows')]
    [switch]
    ${AllowAnonymous},

    [Parameter(ParameterSetName='Windows')]
    [switch]
    ${UseBasicAuthentication},

    [Parameter(ParameterSetName='Windows')]
    [switch]
    ${DisableKerberos},

    [Parameter(ParameterSetName='Windows')]
    [switch]
    ${UseWindowsIntegratedAuthentication},

    [Parameter(ParameterSetName='Forms', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ASPNETMembershipProvider},

    [Parameter(ParameterSetName='Forms', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ASPNETRoleProviderName},

    [Parameter(ParameterSetName='Trusted', Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPTrustedIdentityTokenIssuerPipeBind]
    ${TrustedIdentityTokenIssuer},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPAuthenticationProvider', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPAuthenticationProvider
.ForwardHelpCategory Cmdlet

#>
}

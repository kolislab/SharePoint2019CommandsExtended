function Enable-SPSessionStateService() {
[CmdletBinding(DefaultParameterSetName='AdvancedProvision', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='DefaultProvision', Mandatory=$true)]
    [switch]
    ${DefaultProvision},

    [Parameter(ParameterSetName='AdvancedProvision')]
    [string]
    ${DatabaseServer},

    [Parameter(ParameterSetName='AdvancedProvision', Mandatory=$true)]
    [string]
    ${DatabaseName},

    [System.Nullable[int]]
    ${SessionTimeout},

    [Parameter(ParameterSetName='AdvancedProvision')]
    [pscredential]
    ${DatabaseCredentials},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Enable-SPSessionStateService', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Enable-SPSessionStateService
.ForwardHelpCategory Cmdlet

#>
}

function Add-SPDistributedCacheServiceInstance() {
[CmdletBinding(DefaultParameterSetName='NoArgumentsDefaultSet')]
param(
    [Parameter(ParameterSetName='LocalServerRoleSet')]
    [ValidateSet('DistributedCache','SingleServerFarm','WebFrontEndWithDistributedCache')]
    [Microsoft.SharePoint.Administration.SPServerRole]
    ${Role},

    [Parameter(ParameterSetName='CacheSizeSet')]
    [ValidateRange(1, 2147483647)]
    [int]
    ${CacheSizeInMB},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Add-SPDistributedCacheServiceInstance', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Add-SPDistributedCacheServiceInstance
.ForwardHelpCategory Cmdlet

#>
}

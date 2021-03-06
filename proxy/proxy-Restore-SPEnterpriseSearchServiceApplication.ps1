function Restore-SPEnterpriseSearchServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='Config', Mandatory=$true)]
    [string]
    ${DatabaseServer},

    [Parameter(ParameterSetName='Config', Mandatory=$true)]
    [string]
    ${DatabaseName},

    [Parameter(ParameterSetName='Config')]
    [string]
    ${DatabaseUsername},

    [Parameter(ParameterSetName='Config')]
    [securestring]
    ${DatabasePassword},

    [Parameter(ParameterSetName='Config')]
    [string]
    ${FailoverDatabaseServer},

    [Parameter(ParameterSetName='Full', Mandatory=$true)]
    [string]
    ${TopologyFile},

    [Parameter(Mandatory=$true)]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [Parameter(ParameterSetName='Config', Mandatory=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceInstancePipeBind]
    ${AdminSearchServiceInstance},

    [Parameter(ParameterSetName='Full')]
    [switch]
    ${KeepId},

    [Parameter(ParameterSetName='Full')]
    [switch]
    ${DeferUpgradeActions},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Restore-SPEnterpriseSearchServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Restore-SPEnterpriseSearchServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

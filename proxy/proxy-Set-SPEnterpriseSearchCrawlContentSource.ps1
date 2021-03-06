function Set-SPEnterpriseSearchCrawlContentSource() {
[CmdletBinding(DefaultParameterSetName='NoSchedule', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.ContentSourcePipeBind]
    ${Identity},

    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Alias('n')]
    [string]
    ${Name},

    [Alias('t')]
    [string]
    ${Tag},

    [Alias('s')]
    [string]
    ${StartAddresses},

    [Alias('p')]
    [System.Nullable[Microsoft.Office.Server.Search.Administration.CrawlPriority]]
    ${CrawlPriority},

    [Parameter(ParameterSetName='Weekly')]
    [Parameter(ParameterSetName='Daily', Mandatory=$true)]
    [Parameter(ParameterSetName='MonthlyDate')]
    [Parameter(ParameterSetName='RemoveSchedule')]
    [System.Nullable`1[[Microsoft.Office.Server.Search.Cmdlet.ContentSourceCrawlScheduleType, Microsoft.Office.Server.Search.PowerShell, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]
    ${ScheduleType},

    [Parameter(ParameterSetName='Daily')]
    [Alias('daily')]
    [switch]
    ${DailyCrawlSchedule},

    [Parameter(ParameterSetName='Weekly')]
    [Alias('weekly')]
    [switch]
    ${WeeklyCrawlSchedule},

    [Parameter(ParameterSetName='MonthlyDate')]
    [Alias('monthly')]
    [switch]
    ${MonthlyCrawlSchedule},

    [Parameter(ParameterSetName='RemoveSchedule')]
    [switch]
    ${RemoveCrawlSchedule},

    [Parameter(ParameterSetName='MonthlyDate')]
    [Parameter(ParameterSetName='Daily')]
    [Parameter(ParameterSetName='Weekly')]
    [Alias('start')]
    [System.Nullable[datetime]]
    ${CrawlScheduleStartDateTime},

    [Parameter(ParameterSetName='Weekly')]
    [Parameter(ParameterSetName='Daily')]
    [Parameter(ParameterSetName='MonthlyDate')]
    [Alias('duration')]
    [System.Nullable[int]]
    ${CrawlScheduleRepeatDuration},

    [Parameter(ParameterSetName='MonthlyDate')]
    [Parameter(ParameterSetName='Weekly')]
    [Parameter(ParameterSetName='Daily')]
    [Alias('interval')]
    [System.Nullable[int]]
    ${CrawlScheduleRepeatInterval},

    [Parameter(ParameterSetName='Weekly')]
    [Parameter(ParameterSetName='Daily')]
    [Alias('every')]
    [System.Nullable[int]]
    ${CrawlScheduleRunEveryInterval},

    [Parameter(ParameterSetName='Weekly')]
    [System.Nullable[Microsoft.Office.Server.Search.Administration.DaysOfWeek]]
    ${CrawlScheduleDaysOfWeek},

    [Parameter(ParameterSetName='MonthlyDate')]
    [System.Nullable[int]]
    ${CrawlScheduleDaysOfMonth},

    [Parameter(ParameterSetName='MonthlyDate')]
    [Alias('month')]
    [System.Nullable[Microsoft.Office.Server.Search.Administration.MonthsOfYear]]
    ${CrawlScheduleMonthsOfYear},

    [System.Nullable[int]]
    ${MaxPageEnumerationDepth},

    [System.Nullable[int]]
    ${MaxSiteEnumerationDepth},

    [Microsoft.SharePoint.PowerShell.SPServiceApplicationProxyGroupPipeBind]
    ${BDCApplicationProxyGroup},

    [string[]]
    ${LOBSystemSet},

    [string]
    ${CustomProtocol},

    [System.Nullable[bool]]
    ${EnableContinuousCrawls},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchCrawlContentSource', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchCrawlContentSource
.ForwardHelpCategory Cmdlet

#>
}

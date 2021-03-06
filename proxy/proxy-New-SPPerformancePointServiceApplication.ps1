function New-SPPerformancePointServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateLength(0, 64)]
    [string]
    ${Name},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [bool]
    ${CommentsDisabled},

    [int]
    ${CommentsScorecardMax},

    [int]
    ${IndicatorImageCacheSeconds},

    [int]
    ${DataSourceQueryTimeoutSeconds},

    [int]
    ${FilterRememberUserSelectionsDays},

    [int]
    ${FilterTreeMembersMax},

    [int]
    ${FilterSearchResultsMax},

    [int]
    ${ShowDetailsInitialRows},

    [bool]
    ${ShowDetailsMaxRowsDisabled},

    [int]
    ${ShowDetailsMaxRows},

    [bool]
    ${MSMQEnabled},

    [string]
    ${MSMQName},

    [int]
    ${SessionHistoryHours},

    [bool]
    ${AnalyticQueryLoggingEnabled},

    [bool]
    ${TrustedDataSourceLocationsRestricted},

    [bool]
    ${TrustedContentLocationsRestricted},

    [int]
    ${SelectMeasureMaximum},

    [int]
    ${DecompositionTreeMaximum},

    [bool]
    ${ApplicationProxyCacheEnabled},

    [bool]
    ${ApplicationCacheEnabled},

    [int]
    ${ApplicationCacheMinimumHitCount},

    [int]
    ${AnalyticResultCacheMinimumHitCount},

    [int]
    ${ElementCacheSeconds},

    [int]
    ${AnalyticQueryCellMax},

    [string]
    ${DatabaseServer},

    [string]
    ${DatabaseName},

    [string]
    ${DatabaseFailoverServer},

    [pscredential]
    ${DatabaseSQLAuthenticationCredential},

    [bool]
    ${UseEffectiveUserName},

    [string]
    ${DataSourceUnattendedServiceAccountTargetApplication},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPPerformancePointServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPPerformancePointServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

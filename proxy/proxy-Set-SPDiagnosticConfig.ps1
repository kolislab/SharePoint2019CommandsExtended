function Set-SPDiagnosticConfig() {
[CmdletBinding()]
param(
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${AllowLegacyTraceProviders},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${AppAnalyticsAutomaticUploadEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${CustomerExperienceImprovementProgramEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${FarmTelemetryEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    ${FarmTelemetryEmailAddress},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${ErrorReportingEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${ErrorReportingAutomaticUploadEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${DownloadErrorReportingUpdatesEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 366)]
    [int]
    ${DaysToKeepLogs},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${LogMaxDiskSpaceUsageEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 1000)]
    [int]
    ${LogDiskSpaceUsageGB},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${LogLocation},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 1440)]
    [int]
    ${LogCutInterval},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${EventLogFloodProtectionEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 100)]
    [int]
    ${EventLogFloodProtectionThreshold},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 1440)]
    [int]
    ${EventLogFloodProtectionTriggerPeriod},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 1440)]
    [int]
    ${EventLogFloodProtectionQuietPeriod},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 1440)]
    [int]
    ${EventLogFloodProtectionNotifyInterval},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${ScriptErrorReportingEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${ScriptErrorReportingRequireAuth},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 1440)]
    [int]
    ${ScriptErrorReportingDelay},

    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPDiagnosticConfig', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPDiagnosticConfig
.ForwardHelpCategory Cmdlet

#>
}

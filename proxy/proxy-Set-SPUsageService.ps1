function Set-SPUsageService() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPUsageServicePipeBind]
    ${Identity},

    [Parameter(ValueFromPipeline=$true, HelpMessage='The max space, in GB, that Usage log files should take up.')]
    [ValidateRange(1, 20)]
    [uint32]
    ${UsageLogMaxSpaceGB},

    [Parameter(ValueFromPipeline=$true, HelpMessage='The location where Usage log files are created.')]
    [ValidateLength(1, 181)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${UsageLogLocation},

    [Parameter(ValueFromPipeline=$true, HelpMessage='The time interval, in minutes, that Usage log files should be cut and start a new one.')]
    [ValidateRange(1, 1440)]
    [uint32]
    ${UsageLogCutTime},

    [Parameter(ValueFromPipeline=$true, HelpMessage='The max usage file size, in KB, that Usage log files should be cut and start a new one.')]
    [ValidateRange(512, 65536)]
    [uint32]
    ${UsageLogMaxFileSizeKB},

    [System.Nullable[bool]]
    ${LoggingEnabled},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPUsageService', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPUsageService
.ForwardHelpCategory Cmdlet

#>
}

function Update-SPProfileSync() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [string]
    ${ExcludeWebApplications},

    [Parameter(Position=1, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SynchronizationTiming},

    [Parameter(Position=2, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SweepTiming},

    [Parameter(Position=3, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [bool]
    ${IgnoreIsActive},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Update-SPProfileSync', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Update-SPProfileSync
.ForwardHelpCategory Cmdlet

#>
}

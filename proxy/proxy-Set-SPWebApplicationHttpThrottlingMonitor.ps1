function Set-SPWebApplicationHttpThrottlingMonitor() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${Identity},

    [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Category},

    [Parameter(Mandatory=$true, Position=2, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Counter},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Instance},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('Upper')]
    [ValidateRange(0, 1.7976931348623157E+308)]
    [double]
    ${UpperLimit},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('Lower')]
    [ValidateRange(0, 1.7976931348623157E+308)]
    [double]
    ${LowerLimit},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('Buckets')]
    [double[]]
    ${HealthScoreBuckets},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${IsDESC},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPWebApplicationHttpThrottlingMonitor', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPWebApplicationHttpThrottlingMonitor
.ForwardHelpCategory Cmdlet

#>
}

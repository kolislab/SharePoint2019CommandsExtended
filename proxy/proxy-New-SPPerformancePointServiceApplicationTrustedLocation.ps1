function New-SPPerformancePointServiceApplicationTrustedLocation() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true)]
    [ValidateLength(0, 1024)]
    [string]
    ${Url},

    [Parameter(Mandatory=$true)]
    [Microsoft.PerformancePoint.Scorecards.RepositoryLocationType]
    ${Type},

    [Parameter(Mandatory=$true)]
    [Microsoft.PerformancePoint.Scorecards.TrustedFileType]
    ${TrustedLocationType},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.PerformancePoint.Scorecards.SPPerformancePointMonitoringServiceApplicationPipeBind]
    ${ServiceApplication},

    [string]
    ${Description},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPPerformancePointServiceApplicationTrustedLocation', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPPerformancePointServiceApplicationTrustedLocation
.ForwardHelpCategory Cmdlet

#>
}

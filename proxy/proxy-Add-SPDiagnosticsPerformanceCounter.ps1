function Add-SPDiagnosticsPerformanceCounter() {
[CmdletBinding(DefaultParameterSetName='AddCounter', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='AddCounter', Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddInstance', Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddMultipleCounters', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Category},

    [Parameter(ParameterSetName='AddCounter', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddInstance', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Counter},

    [Parameter(ParameterSetName='AddMultipleCounters', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [string[]]
    ${CounterList},

    [Parameter(ParameterSetName='AddInstance', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddMultipleCounters', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Instance},

    [Parameter(ParameterSetName='AddInstance', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddMultipleCounters', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddCounter', ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${WebFrontEnd},

    [Parameter(ParameterSetName='AddCounter', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddMultipleCounters', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddInstance', ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${DatabaseServer},

    [Parameter(ParameterSetName='AddCounter', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddMultipleCounters', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='AddInstance', ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${AllInstances},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Add-SPDiagnosticsPerformanceCounter', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Add-SPDiagnosticsPerformanceCounter
.ForwardHelpCategory Cmdlet

#>
}

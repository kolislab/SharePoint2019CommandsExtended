function Get-SPLogEvent() {
[CmdletBinding(DefaultParameterSetName='Directory')]
param(
    [Parameter(ParameterSetName='Directory')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Directory},

    [Parameter(ParameterSetName='File')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${File},

    [switch]
    ${AsString},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ContextKey},

    [datetime]
    ${StartTime},

    [datetime]
    ${EndTime},

    [ValidateNotNullOrEmpty()]
    [string]
    ${MinimumLevel},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Get-SPLogEvent', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Get-SPLogEvent
.ForwardHelpCategory Cmdlet

#>
}

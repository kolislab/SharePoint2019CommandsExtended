function Merge-SPLogFile() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]
    ${Path},

    [switch]
    ${Overwrite},

    [datetime]
    ${StartTime},

    [datetime]
    ${EndTime},

    [string[]]
    ${Process},

    [uint32[]]
    ${ThreadID},

    [string[]]
    ${Area},

    [string[]]
    ${Category},

    [string[]]
    ${EventID},

    [string]
    ${Level},

    [string[]]
    ${Message},

    [guid[]]
    ${Correlation},

    [string[]]
    ${ContextFilter},

    [switch]
    ${ExcludeNestedCorrelation},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Merge-SPLogFile', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Merge-SPLogFile
.ForwardHelpCategory Cmdlet

#>
}

function Set-SPProjectQueueSettings() {
[CmdletBinding()]
param(
    [Parameter(ValueFromPipeline=$true)]
    [Alias('sa')]
    [Microsoft.Office.Project.Server.Cmdlet.PsiServiceApplicationPipeBind, Microsoft.Office.Project.Server.StsAdmCommandHandler, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${ServiceApplication},

    [System.Nullable[int]]
    ${MaxDegreeOfConcurrency},

    [System.Nullable[int]]
    ${MsgRetryInterval},

    [System.Nullable[int]]
    ${MsgRetryLimit},

    [System.Nullable[int]]
    ${SqlRetryInterval},

    [System.Nullable[int]]
    ${SqlRetryLimit},

    [System.Nullable[int]]
    ${SqlCommandTimeout},

    [System.Nullable[int]]
    ${CleanupSuccessAgeLimit},

    [System.Nullable[int]]
    ${CleanupNonSuccessAgeLimit},

    [System.Nullable[int]]
    ${PeriodicTasksInterval},

    [System.Nullable[int]]
    ${QueueTimeout},

    [System.Nullable[int]]
    ${MaxConnections},

    [System.Nullable[int]]
    ${NetTcpPort},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPProjectQueueSettings', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPProjectQueueSettings
.ForwardHelpCategory Cmdlet

#>
}

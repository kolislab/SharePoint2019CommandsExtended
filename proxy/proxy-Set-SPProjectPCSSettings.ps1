function Set-SPProjectPCSSettings() {
[CmdletBinding()]
param(
    [Parameter(ValueFromPipeline=$true)]
    [Alias('sa')]
    [Microsoft.Office.Project.Server.Cmdlet.PsiServiceApplicationPipeBind, Microsoft.Office.Project.Server.StsAdmCommandHandler, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${ServiceApplication},

    [System.Nullable[int]]
    ${MaximumWorkersCount},

    [System.Nullable[int]]
    ${EditingSessionTimeout},

    [System.Nullable[int]]
    ${MaximumSessionsPerUser},

    [System.Nullable[int]]
    ${CachePersistence},

    [System.Nullable[int]]
    ${MinimumMemoryRequired},

    [System.Nullable[int]]
    ${RequestTimeLimits},

    [System.Nullable[int]]
    ${ResponseSizeLimits},

    [System.Nullable[int]]
    ${MaximumProjectSize},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPProjectPCSSettings', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPProjectPCSSettings
.ForwardHelpCategory Cmdlet

#>
}

function Set-SPProjectDatabaseQuota() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [uri]
    ${Url},

    [Parameter(ParameterSetName='settings', Mandatory=$true, Position=1)]
    [ValidateNotNull()]
    [Microsoft.Office.Project.Server.Cmdlet.ProjectDatabaseQuotaSettings]
    ${Settings},

    [Parameter(ParameterSetName='options', Mandatory=$true)]
    [switch]
    ${Enabled},

    [Parameter(ParameterSetName='options', Mandatory=$true)]
    [ValidateRange(0, 1024000)]
    [int]
    ${ReadOnlyLimit},

    [Parameter(ParameterSetName='options', Mandatory=$true)]
    [ValidateRange(0, 100)]
    [int]
    ${ReadOnlyWarningThreshold},

    [Parameter(ParameterSetName='options', Mandatory=$true)]
    [ValidateRange(0, 1024000)]
    [int]
    ${MaxDbSize},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPProjectDatabaseQuota', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPProjectDatabaseQuota
.ForwardHelpCategory Cmdlet

#>
}

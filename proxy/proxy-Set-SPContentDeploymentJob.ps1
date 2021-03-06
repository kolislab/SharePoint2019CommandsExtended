function Set-SPContentDeploymentJob() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.Publishing.Cmdlet.SPContentDeploymentJobPipeBind]
    ${Identity},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Name},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Description},

    [Microsoft.SharePoint.PowerShell.SPWebPipeBind[]]
    ${Scope},

    [string]
    ${Schedule},

    [switch]
    ${ScheduleEnabled},

    [switch]
    ${IncrementalEnabled},

    [Microsoft.SharePoint.Publishing.Administration.ContentDeploymentSqlSnapshotSetting]
    ${SqlSnapshotSetting},

    [switch]
    ${HostingSupportEnabled},

    [Microsoft.SharePoint.Publishing.Administration.ContentDeploymentNotificationSettings]
    ${EmailNotifications},

    [string[]]
    ${EmailAddresses},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPContentDeploymentJob', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPContentDeploymentJob
.ForwardHelpCategory Cmdlet

#>
}

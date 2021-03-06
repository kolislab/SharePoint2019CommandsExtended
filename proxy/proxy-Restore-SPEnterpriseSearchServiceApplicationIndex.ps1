function Restore-SPEnterpriseSearchServiceApplicationIndex() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [Microsoft.Office.Server.Search.Administration.SearchServiceApplication]
    ${SearchApplication},

    [Parameter(ParameterSetName='RestoreProgress', Mandatory=$true, Position=1)]
    [string]
    ${Handle},

    [Parameter(ParameterSetName='Restore', Mandatory=$true, Position=1)]
    [string]
    ${BackupFolder},

    [Parameter(ParameterSetName='Restore', Position=2)]
    [switch]
    ${AllReplicas},

    [Parameter(ParameterSetName='Restore', Position=3)]
    [switch]
    ${AllowMove},

    [Parameter(Position=4)]
    [int]
    ${Retries},

    [Parameter(Position=5)]
    [int]
    ${RetryPauseSeconds},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Restore-SPEnterpriseSearchServiceApplicationIndex', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Restore-SPEnterpriseSearchServiceApplicationIndex
.ForwardHelpCategory Cmdlet

#>
}

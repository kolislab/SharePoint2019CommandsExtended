function Backup-SPEnterpriseSearchServiceApplicationIndex() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='RunBackup', Mandatory=$true, Position=0)]
    [int]
    ${Phase},

    [Parameter(ParameterSetName='AbortBackup', Mandatory=$true, Position=0)]
    [switch]
    ${Abort},

    [Parameter(Mandatory=$true, Position=1, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Administration.SearchServiceApplication]
    ${SearchApplication},

    [Parameter(ParameterSetName='RunBackup', Mandatory=$true, Position=2)]
    [string]
    ${BackupFolder},

    [Parameter(Mandatory=$true, Position=3)]
    [string]
    ${BackupHandleFile},

    [Parameter(Position=4)]
    [int]
    ${Retries},

    [Parameter(Position=5)]
    [switch]
    ${PeerToPeer},

    [Parameter(Position=6)]
    [string]
    ${SpecifiedBackupHandle},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Backup-SPEnterpriseSearchServiceApplicationIndex', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Backup-SPEnterpriseSearchServiceApplicationIndex
.ForwardHelpCategory Cmdlet

#>
}

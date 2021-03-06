function Sync-SPProjectPermissions() {
[CmdletBinding()]
param(
    [Parameter(ParameterSetName='PSMode', Mandatory=$true, Position=0)]
    [Parameter(ParameterSetName='SPMode', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [uri]
    ${Url},

    [Parameter(ParameterSetName='SPMode', Position=1)]
    [ValidateSet('Full','Incremental')]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Office.Project.Server.Utility.SharePointPermissionModeSyncType]
    ${Type},

    [Parameter(ParameterSetName='PSMode', Position=1)]
    [switch]
    ${SyncPWASite},

    [Parameter(ParameterSetName='PSMode', Position=2)]
    [switch]
    ${SyncProjectSites},

    [Parameter(ParameterSetName='PSMode', Position=3)]
    [switch]
    ${Async},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Sync-SPProjectPermissions', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Sync-SPProjectPermissions
.ForwardHelpCategory Cmdlet

#>
}

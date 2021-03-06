function Get-SPSiteUpgradeSessionInfo() {
[CmdletBinding(DefaultParameterSetName='ContentDB')]
param(
    [Parameter(ParameterSetName='Site', Mandatory=$true)]
    [Microsoft.SharePoint.PowerShell.SPSitePipeBind]
    ${Site},

    [Parameter(ParameterSetName='ContentDB', Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPContentDatabasePipeBind]
    ${ContentDatabase},

    [Parameter(ParameterSetName='ContentDB')]
    [Microsoft.SharePoint.PowerShell.SPSiteSubscriptionPipeBind]
    ${SiteSubscription},

    [Parameter(ParameterSetName='ContentDB')]
    [switch]
    ${HideWaiting},

    [Parameter(ParameterSetName='ContentDB')]
    [switch]
    ${ShowInProgress},

    [Parameter(ParameterSetName='ContentDB')]
    [switch]
    ${ShowCompleted},

    [Parameter(ParameterSetName='ContentDB')]
    [switch]
    ${ShowFailed},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Get-SPSiteUpgradeSessionInfo', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Get-SPSiteUpgradeSessionInfo
.ForwardHelpCategory Cmdlet

#>
}

function Migrate-SPDatabase() {
[CmdletBinding(DefaultParameterSetName='SiteSubscription', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPDatabasePipeBind]
    ${Identity},

    [Parameter(ParameterSetName='SiteSubscription', Mandatory=$true, Position=1)]
    [Microsoft.SharePoint.PowerShell.SPContentDatabasePipeBind]
    ${DestinationDatabase},

    [Parameter(ParameterSetName='SiteCollection', Mandatory=$true, Position=2)]
    [Microsoft.SharePoint.PowerShell.SPSitePipeBind]
    ${SiteCollection},

    [Parameter(ParameterSetName='SiteSubscription', Mandatory=$true, Position=2)]
    [Microsoft.SharePoint.PowerShell.SPSiteSubscriptionPipeBind]
    ${SiteSubscription},

    [Parameter(Mandatory=$true, Position=3)]
    [Microsoft.SharePoint.Administration.ServiceExtensionType]
    ${ServiceType},

    [Parameter(Position=4)]
    [switch]
    ${Overwrite},

    [Parameter(Position=5)]
    [switch]
    ${UseLinkedSqlServer},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Migrate-SPDatabase', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Migrate-SPDatabase
.ForwardHelpCategory Cmdlet

#>
}

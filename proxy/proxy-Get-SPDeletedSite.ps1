function Get-SPDeletedSite() {
[CmdletBinding(DefaultParameterSetName='AllDeletedSitesInWebApplication', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='AllDeletedSitesInIdentity', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPDeletedSitePipeBind]
    ${Identity},

    [string]
    ${Limit},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${WebApplication},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPContentDatabasePipeBind]
    ${ContentDatabase},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPSiteSubscriptionPipeBind]
    ${SiteSubscription},

    [string]
    ${DateTimeFrom},

    [string]
    ${DateTimeTo},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Get-SPDeletedSite', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Get-SPDeletedSite
.ForwardHelpCategory Cmdlet

#>
}

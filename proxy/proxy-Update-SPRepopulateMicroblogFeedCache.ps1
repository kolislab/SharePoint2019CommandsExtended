function Update-SPRepopulateMicroblogFeedCache() {
[CmdletBinding(DefaultParameterSetName='Default')]
param(
    [Parameter(ParameterSetName='Default', Mandatory=$true, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='FollowableList', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationProxyPipeBind]
    ${ProfileServiceApplicationProxy},

    [Parameter(ParameterSetName='FollowableList', Mandatory=$true, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='Default', ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPSiteSubscriptionPipeBind]
    ${SiteSubscription},

    [Parameter(ParameterSetName='Default')]
    [ValidateNotNull()]
    [string]
    ${AccountName},

    [Parameter(ParameterSetName='Default')]
    [ValidateNotNull()]
    [string]
    ${SiteUrl},

    [Parameter(ParameterSetName='FollowableList', Mandatory=$true)]
    [ValidateNotNull()]
    [guid]
    ${SiteId},

    [Parameter(ParameterSetName='FollowableList', Mandatory=$true)]
    [ValidateNotNull()]
    [guid]
    ${WebId},

    [Parameter(ParameterSetName='FollowableList', Mandatory=$true)]
    [ValidateNotNull()]
    [guid]
    ${ListId},

    [Parameter(ParameterSetName='FollowableList', Mandatory=$true)]
    [ValidateNotNull()]
    [string]
    ${ListRootFolderUrl},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Update-SPRepopulateMicroblogFeedCache', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Update-SPRepopulateMicroblogFeedCache
.ForwardHelpCategory Cmdlet

#>
}

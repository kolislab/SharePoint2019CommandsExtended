function New-SPProfileServiceApplication() {
[CmdletBinding(DefaultParameterSetName='Default', SupportsShouldProcess=$true, ConfirmImpact='Low')]
param(
    [string]
    ${Name},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [string]
    ${ProfileDBName},

    [string]
    ${ProfileDBServer},

    [pscredential]
    ${ProfileDBCredentials},

    [string]
    ${ProfileDBFailoverServer},

    [string]
    ${SocialDBName},

    [string]
    ${SocialDBServer},

    [pscredential]
    ${SocialDBCredentials},

    [string]
    ${SocialDBFailoverServer},

    [string]
    ${ProfileSyncDBName},

    [string]
    ${ProfileSyncDBServer},

    [pscredential]
    ${ProfileSyncDBCredentials},

    [string]
    ${ProfileSyncDBFailoverServer},

    [switch]
    ${PartitionMode},

    [Parameter(ParameterSetName='MySiteSettings', Mandatory=$true, ValueFromPipeline=$true)]
    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPSitePipeBind]
    ${MySiteHostLocation},

    [Parameter(ParameterSetName='MySiteSettings', ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPPrefixPipeBind]
    ${MySiteManagedPath},

    [Parameter(ParameterSetName='MySiteSettings')]
    [ValidateSet('None','Resolve','Block')]
    [string]
    ${SiteNamingConflictResolution},

    [switch]
    ${DeferUpgradeActions},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPProfileServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPProfileServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

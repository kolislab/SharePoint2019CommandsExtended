function Set-SPSiteSubscriptionProfileConfig() {
[CmdletBinding(DefaultParameterSetName='Default', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPSiteSubscriptionPipeBind]
    ${Identity},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationProxyPipeBind]
    ${ProfileServiceApplicationProxy},

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

    [string]
    ${SynchronizationOU},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPSiteSubscriptionProfileConfig', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPSiteSubscriptionProfileConfig
.ForwardHelpCategory Cmdlet

#>
}

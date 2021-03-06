function Upgrade-SPContentDatabase() {
[CmdletBinding(DefaultParameterSetName='ContentDatabaseById', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(ParameterSetName='ContentDatabaseByName', Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${WebApplication},

    [Parameter(ParameterSetName='ContentDatabaseByName', Mandatory=$true)]
    [ValidateNotNull()]
    [string]
    ${Name},

    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPDatabaseServiceInstancePipeBind]
    ${ServerInstance},

    [switch]
    ${UseSnapshot},

    [Parameter(ParameterSetName='ContentDatabaseById', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPContentDatabasePipeBind]
    ${Identity},

    [Parameter(Position=1)]
    [switch]
    ${ForceDeleteLock},

    [switch]
    ${SkipIntegrityChecks},

    [Alias('NoB2BSiteUpgrade')]
    [switch]
    ${SkipSiteUpgrade},

    [switch]
    ${AllowUnattached},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Upgrade-SPContentDatabase', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Upgrade-SPContentDatabase
.ForwardHelpCategory Cmdlet

#>
}

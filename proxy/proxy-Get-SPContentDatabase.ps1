function Get-SPContentDatabase() {
[CmdletBinding(DefaultParameterSetName='DefaultSet')]
param(
    [Parameter(ParameterSetName='DefaultSet', Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPContentDatabasePipeBind]
    ${Identity},

    [Parameter(ParameterSetName='AllContentDatabasesInWebApplication', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${WebApplication},

    [Parameter(ParameterSetName='ContentDatabasesOfSite', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPSitePipeBind]
    ${Site},

    [Parameter(ParameterSetName='ContentDatabasesSinceLastProfileSync', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${DaysSinceLastProfileSync},

    [Parameter(ParameterSetName='Unattached', Mandatory=$true)]
    [switch]
    ${ConnectAsUnattachedDatabase},

    [Parameter(ParameterSetName='Unattached')]
    [pscredential]
    ${DatabaseCredentials},

    [Parameter(ParameterSetName='Unattached', Mandatory=$true)]
    [string]
    ${DatabaseServer},

    [Parameter(ParameterSetName='Unattached', Mandatory=$true)]
    [string]
    ${DatabaseName},

    [Parameter(ParameterSetName='ContentDatabasesSinceLastProfileSync')]
    [Parameter(ParameterSetName='DefaultSet')]
    [Parameter(ParameterSetName='AllContentDatabasesInWebApplication')]
    [switch]
    ${NoStatusFilter},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Get-SPContentDatabase', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Get-SPContentDatabase
.ForwardHelpCategory Cmdlet

#>
}

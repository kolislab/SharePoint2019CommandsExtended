function Test-SPContentDatabase() {
[CmdletBinding(DefaultParameterSetName='ContentDatabaseById')]
param(
    [Parameter(ParameterSetName='ContentDatabaseByName', Mandatory=$true)]
    [ValidateNotNull()]
    [string]
    ${Name},

    [Parameter(ParameterSetName='ContentDatabaseByName', Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${WebApplication},

    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPDatabaseServiceInstancePipeBind]
    ${ServerInstance},

    [ValidateNotNull()]
    [pscredential]
    ${DatabaseCredentials},

    [switch]
    ${ShowRowCounts},

    [switch]
    ${ShowLocation},

    [Parameter(ParameterSetName='ContentDatabaseById', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPContentDatabasePipeBind]
    ${Identity},

    [switch]
    ${ExtendedCheck},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Test-SPContentDatabase', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Test-SPContentDatabase
.ForwardHelpCategory Cmdlet

#>
}

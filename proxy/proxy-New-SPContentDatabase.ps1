function New-SPContentDatabase() {
[CmdletBinding(DefaultParameterSetName='DefaultSet', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNull()]
    [string]
    ${Name},

    [Parameter(Mandatory=$true, Position=1)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${WebApplication},

    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServer},

    [ValidateNotNull()]
    [pscredential]
    ${DatabaseCredentials},

    [ValidateNotNull()]
    [pscredential]
    ${DatabaseAccessCredentials},

    [ValidateRange(1, 2147483647)]
    [int]
    ${MaxSiteCount},

    [ValidateRange(0, 2147483647)]
    [int]
    ${WarningSiteCount},

    [switch]
    ${ClearChangeLog},

    [switch]
    ${ChangeSyncKnowledge},

    [switch]
    ${AssignNewDatabaseId},

    [switch]
    ${UseLatestSchema},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPContentDatabase', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPContentDatabase
.ForwardHelpCategory Cmdlet

#>
}

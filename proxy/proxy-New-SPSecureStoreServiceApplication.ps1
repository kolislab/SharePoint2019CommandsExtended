function New-SPSecureStoreServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true)]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [Parameter(Mandatory=$true)]
    [switch]
    ${AuditingEnabled},

    [System.Nullable[int]]
    ${AuditlogMaxSize},

    [Parameter(ParameterSetName='NoMinDBSet')]
    [pscredential]
    ${DatabaseCredentials},

    [Parameter(ParameterSetName='NoMinDBSet')]
    [string]
    ${DatabaseName},

    [Parameter(ParameterSetName='NoMinDBSet')]
    [securestring]
    ${DatabasePassword},

    [Parameter(ParameterSetName='NoMinDBSet')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServer},

    [Parameter(ParameterSetName='NoMinDBSet')]
    [string]
    ${DatabaseUsername},

    [Parameter(ParameterSetName='NoMinDBSet')]
    [string]
    ${FailoverDatabaseServer},

    [string]
    ${Name},

    [switch]
    ${PartitionMode},

    [switch]
    ${Sharing},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPSecureStoreServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPSecureStoreServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

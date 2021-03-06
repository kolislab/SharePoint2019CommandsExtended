function Set-SPSecureStoreServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Microsoft.SharePoint.Administration.SPIisWebServiceApplicationPool]
    ${ApplicationPool},

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

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationPipeBind]
    ${Identity},

    [switch]
    ${Sharing},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPSecureStoreServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPSecureStoreServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

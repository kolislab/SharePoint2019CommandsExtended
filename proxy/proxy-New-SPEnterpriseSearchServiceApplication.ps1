function New-SPEnterpriseSearchServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='DatabasePlacement', Position=0)]
    [Parameter(ParameterSetName='DefaultParameterSet', Position=0)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [string]
    ${DatabaseServer},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [string]
    ${DatabaseName},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [Parameter(ParameterSetName='DatabasePlacement')]
    [string]
    ${DatabaseUsername},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [Parameter(ParameterSetName='DatabasePlacement')]
    [securestring]
    ${DatabasePassword},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [string]
    ${FailoverDatabaseServer},

    [Parameter(ParameterSetName='DatabasePlacement')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [switch]
    ${Partitioned},

    [Parameter(ParameterSetName='DefaultParameterSet', Mandatory=$true)]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${AdminApplicationPool},

    [Parameter(ParameterSetName='DatabasePlacement', Mandatory=$true)]
    [hashtable]
    ${ParametersForDatabases},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [Parameter(ParameterSetName='DatabasePlacement')]
    [bool]
    ${CloudIndex},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

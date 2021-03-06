function Set-SPRoutingMachineInfo() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPRoutingMachineInfoPipeBind]
    ${Identity},

    [ValidateNotNull()]
    [System.Nullable[Microsoft.SharePoint.Administration.SPRoutingMachineAvailability]]
    ${Availability},

    [ValidateNotNull()]
    [System.Nullable[Microsoft.SharePoint.Administration.SPRoutingOutgoingScheme]]
    ${OutgoingScheme},

    [ValidateRange(1, 65535)]
    [ValidateNotNull()]
    [System.Nullable[int]]
    ${OutgoingPort},

    [ValidateNotNull()]
    [switch]
    ${ClearOutgoingPort},

    [ValidateNotNull()]
    [System.Nullable[double]]
    ${StaticWeight},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPRoutingMachineInfo', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPRoutingMachineInfo
.ForwardHelpCategory Cmdlet

#>
}

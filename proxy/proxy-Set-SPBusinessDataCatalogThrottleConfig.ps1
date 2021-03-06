function Set-SPBusinessDataCatalogThrottleConfig() {
[CmdletBinding(DefaultParameterSetName='MaxDefault', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.BusinessData.SharedService.ThrottleConfig]
    ${Identity},

    [Parameter(ParameterSetName='MaxDefault', Mandatory=$true)]
    [int]
    ${Maximum},

    [Parameter(ParameterSetName='MaxDefault', Mandatory=$true)]
    [int]
    ${Default},

    [Parameter(ParameterSetName='Enforcement', Mandatory=$true)]
    [switch]
    ${Enforced},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPBusinessDataCatalogThrottleConfig', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPBusinessDataCatalogThrottleConfig
.ForwardHelpCategory Cmdlet

#>
}

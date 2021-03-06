function Get-SPBusinessDataCatalogThrottleConfig() {
[CmdletBinding(DefaultParameterSetName='ProxyProvided')]
param(
    [Parameter(Mandatory=$true)]
    [Microsoft.BusinessData.SystemSpecific.ThrottleScope]
    ${Scope},

    [Parameter(Mandatory=$true)]
    [Microsoft.BusinessData.SystemSpecific.ThrottleType]
    ${ThrottleType},

    [Parameter(ParameterSetName='ProxyProvided', Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationProxyPipeBind]
    ${ServiceApplicationProxy},

    [Parameter(ParameterSetName='FileBackedProvided', Mandatory=$true)]
    [switch]
    ${FileBacked},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Get-SPBusinessDataCatalogThrottleConfig', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Get-SPBusinessDataCatalogThrottleConfig
.ForwardHelpCategory Cmdlet

#>
}

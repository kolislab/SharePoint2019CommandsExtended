function New-SPSecureStoreServiceApplicationProxy() {
[CmdletBinding(DefaultParameterSetName='Uri', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [switch]
    ${DefaultProxyGroup},

    [string]
    ${Name},

    [Parameter(ParameterSetName='PipeBind', Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationPipeBind]
    ${ServiceApplication},

    [Parameter(ParameterSetName='Uri', Mandatory=$true)]
    [ValidateNotNull()]
    [uri]
    ${Uri},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPSecureStoreServiceApplicationProxy', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPSecureStoreServiceApplicationProxy
.ForwardHelpCategory Cmdlet

#>
}

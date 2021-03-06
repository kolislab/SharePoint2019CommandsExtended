function Set-SPAccessServicesApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationPipeBind]
    ${Identity},

    [ValidateRange(-1, 2073600)]
    [int]
    ${RequestDurationMax},

    [ValidateRange(-1, 2147483647)]
    [int]
    ${SessionsPerUserMax},

    [ValidateRange(-1, 2147483647)]
    [int]
    ${SessionsPerAnonymousUserMax},

    [ValidateRange(-1, 2073600)]
    [int]
    ${CacheTimeout},

    [ValidateRange(-1, 2147483647)]
    [int]
    ${PrivateBytesMax},

    [ValidateRange(-1, 2073600)]
    [int]
    ${QueryTimeout},

    [ValidateRange(-1, 1440)]
    [int]
    ${RecoveryPointObjective},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPAccessServicesApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPAccessServicesApplication
.ForwardHelpCategory Cmdlet

#>
}

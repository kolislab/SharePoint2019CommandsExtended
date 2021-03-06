function Set-SPUsageApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPUsageApplicationPipeBind]
    ${Identity},

    [Microsoft.SharePoint.PowerShell.SPUsageServicePipeBind]
    ${UsageService},

    [ValidateLength(1, 135)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServer},

    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 128)]
    [string]
    ${DatabaseName},

    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 128)]
    [string]
    ${DatabaseUsername},

    [ValidateNotNull()]
    [securestring]
    ${DatabasePassword},

    [switch]
    ${EnableLogging},

    [ValidateLength(1, 135)]
    [string]
    ${FailoverDatabaseServer},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPUsageApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPUsageApplication
.ForwardHelpCategory Cmdlet

#>
}

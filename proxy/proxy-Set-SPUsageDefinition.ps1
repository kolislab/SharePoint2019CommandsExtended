function Set-SPUsageDefinition() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPUsageDefinitionPipeBind]
    ${Identity},

    [switch]
    ${Enable},

    [ValidateRange(0, 31)]
    [int]
    ${DaysRetained},

    [ValidateRange(0, 31)]
    [int]
    ${DaysToKeepUsageFiles},

    [ValidateRange(1, 9223372036854775807)]
    [long]
    ${MaxTotalSizeInBytes},

    [switch]
    ${UsageDatabaseEnabled},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPUsageDefinition', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPUsageDefinition
.ForwardHelpCategory Cmdlet

#>
}

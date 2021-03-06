function New-SPUsageApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Position=0)]
    [string]
    ${Name},

    [ValidateLength(1, 135)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServer},

    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 135)]
    [string]
    ${FailoverDatabaseServer},

    [ValidateLength(1, 128)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseName},

    [Parameter(ParameterSetName='SQLAuthentication')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 128)]
    [string]
    ${DatabaseUsername},

    [Parameter(ParameterSetName='SQLAuthentication')]
    [ValidateNotNull()]
    [securestring]
    ${DatabasePassword},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPUsageServicePipeBind]
    ${UsageService},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPUsageApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPUsageApplication
.ForwardHelpCategory Cmdlet

#>
}

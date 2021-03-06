function Install-SPFeature() {
[CmdletBinding(DefaultParameterSetName='PathSet', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='PathSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [string]
    ${Path},

    [Parameter(ParameterSetName='AllExistingFeatures', Mandatory=$true)]
    [switch]
    ${AllExistingFeatures},

    [Parameter(ParameterSetName='ScanForFeatures', Mandatory=$true)]
    [switch]
    ${ScanForFeatures},

    [switch]
    ${Force},

    [Parameter(ParameterSetName='ScanForFeatures')]
    [Parameter(ParameterSetName='AllExistingFeatures')]
    [string]
    ${SolutionId},

    [Parameter(ParameterSetName='PathSet')]
    [int]
    ${CompatibilityLevel},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Install-SPFeature', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Install-SPFeature
.ForwardHelpCategory Cmdlet

#>
}

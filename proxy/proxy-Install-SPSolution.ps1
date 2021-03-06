function Install-SPSolution() {
[CmdletBinding(DefaultParameterSetName='Deploy', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Deploy', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='Synchronize', Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPSolutionPipeBind]
    ${Identity},

    [Parameter(ParameterSetName='Deploy')]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${WebApplication},

    [Parameter(ParameterSetName='Deploy')]
    [string]
    ${Time},

    [Parameter(ParameterSetName='Deploy')]
    [switch]
    ${CASPolicies},

    [Parameter(ParameterSetName='Deploy')]
    [switch]
    ${GACDeployment},

    [Parameter(ParameterSetName='Deploy')]
    [switch]
    ${FullTrustBinDeployment},

    [Parameter(ParameterSetName='Deploy')]
    [switch]
    ${Local},

    [uint32]
    ${Language},

    [Parameter(ParameterSetName='Deploy')]
    [switch]
    ${Force},

    [Parameter(ParameterSetName='Deploy')]
    [switch]
    ${AllWebApplications},

    [Parameter(ParameterSetName='Deploy')]
    [string]
    ${CompatibilityLevel},

    [Parameter(ParameterSetName='Synchronize', Mandatory=$true)]
    [switch]
    ${Synchronize},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Install-SPSolution', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Install-SPSolution
.ForwardHelpCategory Cmdlet

#>
}

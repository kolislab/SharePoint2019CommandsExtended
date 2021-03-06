function Backup-SPFarm() {
[CmdletBinding(DefaultParameterSetName='DefaultSet', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='DefaultSet', Mandatory=$true)]
    [string]
    ${Directory},

    [Parameter(ParameterSetName='DefaultSet', Mandatory=$true)]
    [ValidateSet('Full','Differential','None')]
    [string]
    ${BackupMethod},

    [Parameter(ParameterSetName='DefaultSet')]
    [int]
    ${BackupThreads},

    [Parameter(ParameterSetName='DefaultSet')]
    [switch]
    ${Force},

    [string]
    ${Item},

    [Parameter(ParameterSetName='ShowTree', Mandatory=$true)]
    [switch]
    ${ShowTree},

    [switch]
    ${ConfigurationOnly},

    [Parameter(ParameterSetName='DefaultSet')]
    [int]
    ${Percentage},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Backup-SPFarm', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Backup-SPFarm
.ForwardHelpCategory Cmdlet

#>
}

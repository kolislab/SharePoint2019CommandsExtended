function Restore-SPFarm() {
[CmdletBinding(DefaultParameterSetName='DefaultSet', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(Mandatory=$true)]
    [string]
    ${Directory},

    [Parameter(ParameterSetName='DefaultSet', Mandatory=$true)]
    [ValidateSet('New','Overwrite')]
    [string]
    ${RestoreMethod},

    [Parameter(ParameterSetName='DefaultSet')]
    [int]
    ${RestoreThreads},

    [Parameter(ParameterSetName='DefaultSet')]
    [switch]
    ${Force},

    [Parameter(ValueFromPipeline=$true)]
    [guid]
    ${BackupId},

    [Parameter(ParameterSetName='DefaultSet')]
    [string]
    ${NewDatabaseServer},

    [Parameter(ParameterSetName='DefaultSet', ValueFromPipeline=$true)]
    [pscredential]
    ${FarmCredentials},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Restore-SPFarm', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Restore-SPFarm
.ForwardHelpCategory Cmdlet

#>
}

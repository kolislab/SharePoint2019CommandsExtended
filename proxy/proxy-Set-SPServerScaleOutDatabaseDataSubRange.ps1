function Set-SPServerScaleOutDatabaseDataSubRange() {
[CmdletBinding(DefaultParameterSetName='AttachedDatabase', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='AttachedDatabase', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPDatabasePipeBind]
    ${Database},

    [Parameter(ParameterSetName='UnattachedDatabase', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ConnectionString},

    [Parameter(ParameterSetName='UnattachedDatabase')]
    [switch]
    ${IsAzureDatabase},

    [Parameter(Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.Office.Server.SPScaleOutDataRange]
    ${Range},

    [byte[]]
    ${SubRangePoint},

    [Parameter(Mandatory=$true)]
    [Microsoft.Office.Server.SPScaleOutDatabaseSubRangeMode]
    ${SubRangeMode},

    [Parameter(Mandatory=$true)]
    [bool]
    ${IsUpperSubRange},

    [switch]
    ${IgnoreSubRangePointOnBoundary},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPServerScaleOutDatabaseDataSubRange', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPServerScaleOutDatabaseDataSubRange
.ForwardHelpCategory Cmdlet

#>
}

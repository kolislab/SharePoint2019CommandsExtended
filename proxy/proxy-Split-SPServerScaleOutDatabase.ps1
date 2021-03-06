function Split-SPServerScaleOutDatabase() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='NewDatabase', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${NewDatabaseName},

    [Parameter(ParameterSetName='NewDatabase')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${NewDatabaseServer},

    [Parameter(ParameterSetName='NewDatabase')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${NewDatabaseFailoverServer},

    [Parameter(ParameterSetName='NewDatabase')]
    [ValidateNotNull()]
    [pscredential]
    ${NewDatabaseCredentials},

    [Parameter(ParameterSetName='ExistingDatabase', Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPDatabasePipeBind]
    ${TargetDatabase},

    [Parameter(Mandatory=$true)]
    [Microsoft.SharePoint.PowerShell.SPDatabasePipeBind]
    ${SourceDatabase},

    [Parameter(Mandatory=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationPipeBind]
    ${SourceServiceApplication},

    [int]
    ${SourcePercentage},

    [switch]
    ${MoveLowerHalf},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Split-SPServerScaleOutDatabase', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Split-SPServerScaleOutDatabase
.ForwardHelpCategory Cmdlet

#>
}

function New-SPAccessServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [string]
    ${Name},

    [switch]
    ${Default},

    [ValidateRange(1, 255)]
    [int]
    ${ColumnsMax},

    [ValidateRange(1, 200000)]
    [int]
    ${RowsMax},

    [ValidateRange(1, 20)]
    [int]
    ${SourcesMax},

    [ValidateRange(0, 32)]
    [int]
    ${OutputCalculatedColumnsMax},

    [ValidateRange(0, 8)]
    [int]
    ${OrderByMax},

    [switch]
    ${OuterJoinsAllowed},

    [switch]
    ${NonRemotableQueriesAllowed},

    [ValidateRange(-1, 2147483647)]
    [int]
    ${RecordsInTableMax},

    [ValidateRange(-1, 2147483647)]
    [int]
    ${ApplicationLogSizeMax},

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

    [ValidateRange(0, 4096)]
    [int]
    ${SessionMemoryMax},

    [ValidateRange(-1, 2147483647)]
    [int]
    ${PrivateBytesMax},

    [ValidateRange(-1, 2147483647)]
    [int]
    ${TemplateSizeMax},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPAccessServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPAccessServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

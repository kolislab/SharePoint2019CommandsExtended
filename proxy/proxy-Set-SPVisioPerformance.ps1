function Set-SPVisioPerformance() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Office.Visio.Server.Cmdlet.SPVisioServiceApplicationPipeBind, Microsoft.Office.Visio.Server, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${VisioServiceApplication},

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [long]
    ${MaxDiagramSize},

    [Parameter(Mandatory=$true)]
    [int]
    ${MinDiagramCacheAge},

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [int]
    ${MaxDiagramCacheAge},

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [int]
    ${MaxRecalcDuration},

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [long]
    ${MaxCacheSize},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPVisioPerformance', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPVisioPerformance
.ForwardHelpCategory Cmdlet

#>
}

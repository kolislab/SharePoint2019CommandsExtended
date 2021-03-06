function New-SPEnterpriseSearchCrawlContentSource() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    ${Name},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(Mandatory=$true)]
    [Alias('t')]
    [Microsoft.Office.Server.Search.Administration.ContentSourceType]
    ${Type},

    [string]
    ${Tag},

    [Alias('s')]
    [string]
    ${StartAddresses},

    [Alias('p')]
    [System.Nullable[Microsoft.Office.Server.Search.Administration.CrawlPriority]]
    ${CrawlPriority},

    [System.Nullable[int]]
    ${MaxPageEnumerationDepth},

    [System.Nullable[int]]
    ${MaxSiteEnumerationDepth},

    [System.Nullable[Microsoft.Office.Server.Search.Administration.SharePointCrawlBehavior]]
    ${SharePointCrawlBehavior},

    [Microsoft.SharePoint.PowerShell.SPServiceApplicationProxyGroupPipeBind]
    ${BDCApplicationProxyGroup},

    [string[]]
    ${LOBSystemSet},

    [string]
    ${CustomProtocol},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchCrawlContentSource', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchCrawlContentSource
.ForwardHelpCategory Cmdlet

#>
}

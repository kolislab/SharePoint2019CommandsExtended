function New-SPEnterpriseSearchCrawlRule() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    ${Path},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(Mandatory=$true)]
    [Alias('t')]
    [Microsoft.Office.Server.Search.Administration.CrawlRuleType]
    ${Type},

    [System.Nullable[bool]]
    ${IsAdvancedRegularExpression},

    [System.Nullable[bool]]
    ${CrawlAsHttp},

    [System.Nullable[bool]]
    ${FollowComplexUrls},

    [System.Nullable[int]]
    ${PluggableSecurityTimmerId},

    [System.Nullable[bool]]
    ${SuppressIndexing},

    [System.Nullable[int]]
    ${Priority},

    [string]
    ${ContentClass},

    [System.Nullable[Microsoft.Office.Server.Search.Administration.CrawlRuleAuthenticationType]]
    ${AuthenticationType},

    [string]
    ${AccountName},

    [securestring]
    ${AccountPassword},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchCrawlRule', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchCrawlRule
.ForwardHelpCategory Cmdlet

#>
}

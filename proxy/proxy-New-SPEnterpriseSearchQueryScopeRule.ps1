function New-SPEnterpriseSearchQueryScopeRule() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(Mandatory=$true)]
    [Alias('u')]
    [uri]
    ${Url},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Alias('s')]
    [Microsoft.Office.Server.Search.Cmdlet.ScopePipeBind]
    ${Scope},

    [Parameter(Mandatory=$true)]
    [Alias('type')]
    [string]
    ${RuleType},

    [Alias('f')]
    [string]
    ${FilterBehavior},

    [Alias('ut')]
    [string]
    ${UrlScopeRuleType},

    [Alias('text')]
    [string]
    ${MatchingString},

    [Alias('value')]
    [string]
    ${PropertyValue},

    [Alias('mname')]
    [Microsoft.Office.Server.Search.Cmdlet.ManagedPropertyPipeBind]
    ${ManagedProperty},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchQueryScopeRule', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchQueryScopeRule
.ForwardHelpCategory Cmdlet

#>
}

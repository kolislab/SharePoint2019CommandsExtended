function Set-SPEnterpriseSearchResultItemType() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.ResultItemTypePipeBind]
    ${Identity},

    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationProxyPipeBind]
    ${SearchApplicationProxy},

    [Alias('n')]
    [string]
    ${Name},

    [Alias('rule')]
    [Microsoft.Office.Server.Search.Administration.PropertyRuleCollection]
    ${Rules},

    [Alias('priority')]
    [System.Nullable[int]]
    ${RulePriority},

    [Alias('dp')]
    [string]
    ${DisplayProperties},

    [Alias('sid')]
    [System.Nullable[guid]]
    ${SourceID},

    [Alias('url')]
    [string]
    ${DisplayTemplateUrl},

    [Parameter(Mandatory=$true)]
    [Alias('o')]
    [Microsoft.Office.Server.Search.Administration.SearchObjectOwner]
    ${Owner},

    [Alias('opt')]
    [System.Nullable[bool]]
    ${OptimizeForFrequentUse},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchResultItemType', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchResultItemType
.ForwardHelpCategory Cmdlet

#>
}

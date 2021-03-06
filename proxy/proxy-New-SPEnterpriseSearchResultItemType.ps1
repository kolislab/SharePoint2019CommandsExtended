function New-SPEnterpriseSearchResultItemType() {
[CmdletBinding(DefaultParameterSetName='New', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationProxyPipeBind]
    ${SearchApplicationProxy},

    [Parameter(ParameterSetName='Copy', Position=1)]
    [Parameter(ParameterSetName='New', Mandatory=$true, Position=1)]
    [Alias('n')]
    [string]
    ${Name},

    [Parameter(ParameterSetName='New', Mandatory=$true, Position=2)]
    [Parameter(ParameterSetName='Copy', Position=2)]
    [Alias('rule')]
    [Microsoft.Office.Server.Search.Administration.PropertyRuleCollection]
    ${Rules},

    [Parameter(Position=3)]
    [Alias('priority')]
    [int]
    ${RulePriority},

    [Parameter(Position=4)]
    [Alias('dp')]
    [string]
    ${DisplayProperties},

    [Parameter(Position=5)]
    [Alias('sid')]
    [System.Nullable[guid]]
    ${SourceID},

    [Parameter(ParameterSetName='New', Mandatory=$true, Position=6)]
    [Parameter(ParameterSetName='Copy', Position=6)]
    [Alias('url')]
    [string]
    ${DisplayTemplateUrl},

    [Parameter(Mandatory=$true)]
    [Alias('o')]
    [Microsoft.Office.Server.Search.Administration.SearchObjectOwner]
    ${Owner},

    [Parameter(ParameterSetName='Copy', Mandatory=$true)]
    [Alias('copy')]
    [Microsoft.Office.Server.Search.Cmdlet.ResultItemTypePipeBind]
    ${ExistingResultItemType},

    [Parameter(ParameterSetName='Copy', Mandatory=$true)]
    [Alias('eo')]
    [Microsoft.Office.Server.Search.Administration.SearchObjectOwner]
    ${ExistingResultItemTypeOwner},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchResultItemType', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchResultItemType
.ForwardHelpCategory Cmdlet

#>
}

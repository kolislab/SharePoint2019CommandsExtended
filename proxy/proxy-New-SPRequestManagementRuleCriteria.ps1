function New-SPRequestManagementRuleCriteria() {
[CmdletBinding()]
param(
    [Parameter(ParameterSetName='StandardParameterSet', Mandatory=$true, Position=0)]
    [Parameter(ParameterSetName='CustomPropertyParameterSet', Mandatory=$true, Position=0)]
    [AllowEmptyString()]
    [string]
    ${Value},

    [Parameter(ParameterSetName='CustomPropertyParameterSet', Mandatory=$true, Position=1)]
    [string]
    ${CustomHeader},

    [Parameter(ParameterSetName='StandardParameterSet', Mandatory=$true, Position=1)]
    [ValidateNotNull()]
    [System.Nullable[Microsoft.SharePoint.Administration.SPRequestManagementRulePropertyType]]
    ${Property},

    [Parameter(ParameterSetName='CustomPropertyParameterSet', Position=2)]
    [Parameter(ParameterSetName='StandardParameterSet', Position=2)]
    [ValidateNotNull()]
    [System.Nullable[Microsoft.SharePoint.Administration.SPRequestManagementRuleMatchType]]
    ${MatchType},

    [Parameter(ParameterSetName='StandardParameterSet', Position=2)]
    [Parameter(ParameterSetName='CustomPropertyParameterSet', Position=2)]
    [System.Nullable[switch]]
    ${CaseSensitive},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPRequestManagementRuleCriteria', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPRequestManagementRuleCriteria
.ForwardHelpCategory Cmdlet

#>
}

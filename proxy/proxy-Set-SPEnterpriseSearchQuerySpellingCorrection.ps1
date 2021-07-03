function Set-SPEnterpriseSearchQuerySpellingCorrection() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(Position=0, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.QuerySpellingCorrectionPipeBind]
    ${Identity},

    [System.Nullable[bool]]
    ${ContentAlignmentEnabled},

    [System.Nullable[int]]
    ${MaxDictionarySize},

    [System.Nullable[bool]]
    ${DiacriticsInSuggestionsEnabled},

    [System.Nullable[int]]
    ${TermFrequencyThreshold},

    [System.Nullable[bool]]
    ${SecurityTrimmingEnabled},

    [System.Nullable[Microsoft.Office.Server.Search.Administration.SpellingDictionaryType]]
    ${SpellingDictionary},

    [System.Nullable[timespan]]
    ${MaxProcessingTime},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchQuerySpellingCorrection', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchQuerySpellingCorrection
.ForwardHelpCategory Cmdlet

#>
}

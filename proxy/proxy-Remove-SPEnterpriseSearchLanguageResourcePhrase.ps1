function Remove-SPEnterpriseSearchLanguageResourcePhrase() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.LanguageResourcePhrasePipeBind]
    ${Identity},

    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [System.Nullable[Microsoft.Office.Server.Search.Administration.LanguageResourceType]]
    ${Type},

    [string]
    ${Language},

    [string]
    ${Mapping},

    [Parameter(Mandatory=$true)]
    [Alias('o')]
    [Microsoft.Office.Server.Search.Administration.SearchObjectOwner]
    ${Owner},

    [guid]
    ${SourceId},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Remove-SPEnterpriseSearchLanguageResourcePhrase', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Remove-SPEnterpriseSearchLanguageResourcePhrase
.ForwardHelpCategory Cmdlet

#>
}

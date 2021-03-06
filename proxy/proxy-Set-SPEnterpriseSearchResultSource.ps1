function Set-SPEnterpriseSearchResultSource() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.ResultSourcePipeBind]
    ${Identity},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Alias('o')]
    [Microsoft.Office.Server.Search.Administration.SearchObjectOwner]
    ${Owner},

    [string]
    ${Name},

    [string]
    ${Description},

    [string]
    ${QueryTemplate},

    [guid]
    ${ProviderId},

    [string]
    ${RemoteUrl},

    [System.Nullable[bool]]
    ${AutoDiscover},

    [System.Nullable[Microsoft.Office.Server.Search.Administration.FederationAuthType]]
    ${AuthenticationType},

    [string]
    ${UserName},

    [string]
    ${Password},

    [string]
    ${SsoId},

    [System.Nullable[bool]]
    ${MakeDefault},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchResultSource', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchResultSource
.ForwardHelpCategory Cmdlet

#>
}

function Set-SPInfoPathFormsService() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Microsoft.Office.InfoPath.Server.Cmdlet.SPFormsServicePipeBind]
    ${Identity},

    [ValidateSet('true','false')]
    [string]
    ${AllowUserFormBrowserEnabling},

    [ValidateSet('true','false')]
    [string]
    ${AllowUserFormBrowserRendering},

    [ValidateRange(0, 2147483647)]
    [System.Nullable[int]]
    ${DefaultDataConnectionTimeout},

    [ValidateRange(0, 2147483647)]
    [System.Nullable[int]]
    ${MemoryCacheSize},

    [ValidateRange(0, 2147483647)]
    [System.Nullable[int]]
    ${MaxDataConnectionTimeout},

    [ValidateRange(0, 2147483647)]
    [System.Nullable[int]]
    ${MaxDataConnectionResponseSize},

    [ValidateSet('true','false')]
    [string]
    ${RequireSslForDataConnections},

    [ValidateSet('true','false')]
    [string]
    ${AllowEmbeddedSqlForDataConnections},

    [ValidateSet('true','false')]
    [string]
    ${AllowUdcAuthenticationForDataConnections},

    [ValidateSet('true','false')]
    [string]
    ${AllowUserFormCrossDomainDataConnections},

    [ValidateRange(0, 999999)]
    [System.Nullable[int]]
    ${MaxPostbacksPerSession},

    [ValidateRange(0, 999999)]
    [System.Nullable[int]]
    ${MaxUserActionsPerPostback},

    [ValidateRange(0, 999999)]
    [System.Nullable[int]]
    ${ActiveSessionTimeout},

    [ValidateRange(0, 99999999)]
    [System.Nullable[int]]
    ${MaxSizeOfUserFormState},

    [ValidateSet('true','false')]
    [string]
    ${AllowViewState},

    [ValidateRange(0, 99999999)]
    [System.Nullable[int]]
    ${ViewStateThreshold},

    [ValidateRange(0, 99999999)]
    [System.Nullable[int]]
    ${MaxFormLoadTime},

    [ValidateRange(0, 99999999)]
    [System.Nullable[int]]
    ${MaxDataConnectionRoundTrip},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPInfoPathFormsService', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPInfoPathFormsService
.ForwardHelpCategory Cmdlet

#>
}

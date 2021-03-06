function Set-SPO365LinkSettings() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyString()]
    [string]
    ${MySiteHostUrl},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Audiences},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [bool]
    ${RedirectSites},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [bool]
    ${HybridAppLauncherEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [bool]
    ${OnedriveDefaultToCloudEnabled},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPO365LinkSettings', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPO365LinkSettings
.ForwardHelpCategory Cmdlet

#>
}

function Export-SPWeb() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPWebPipeBind]
    ${Identity},

    [switch]
    ${IncludeAlerts},

    [Microsoft.SharePoint.Deployment.SPIncludeVersions]
    ${IncludeVersions},

    [int]
    ${CompressionSize},

    [switch]
    ${UseSqlSnapshot},

    [string]
    ${AppLogFilePath},

    [string]
    ${ItemUrl},

    [Parameter(Mandatory=$true)]
    [string]
    ${Path},

    [switch]
    ${Force},

    [switch]
    ${IncludeUserSecurity},

    [switch]
    ${HaltOnWarning},

    [switch]
    ${HaltOnError},

    [switch]
    ${NoLogFile},

    [switch]
    ${NoFileCompression},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Export-SPWeb', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Export-SPWeb
.ForwardHelpCategory Cmdlet

#>
}

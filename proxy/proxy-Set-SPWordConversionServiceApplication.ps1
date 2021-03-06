function Set-SPWordConversionServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Low')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Microsoft.Office.Word.Server.Powershell.WordServiceApplicationPipeBind, Microsoft.Office.Word.Server, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${Identity},

    [string]
    ${DatabaseName},

    [pscredential]
    ${DatabaseCredential},

    [string]
    ${DatabaseServer},

    [System.Nullable[int]]
    ${TimerJobFrequency},

    [System.Nullable[int]]
    ${ConversionTimeout},

    [System.Nullable[int]]
    ${MaximumConversionAttempts},

    [System.Nullable[int]]
    ${KeepAliveTimeout},

    [System.Nullable[int]]
    ${MaximumConversionTime},

    [System.Nullable[int]]
    ${MaximumSyncConversionRequests},

    [System.Nullable[int]]
    ${ConversionsPerInstance},

    [switch]
    ${DisableEmbeddedFonts},

    [switch]
    ${DisableBinaryFileScan},

    [System.Nullable[int]]
    ${RecycleProcessThreshold},

    [System.Nullable[int]]
    ${ActiveProcesses},

    [System.Nullable[int]]
    ${MaximumMemoryUsage},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [string[]]
    ${AddSupportedFormats},

    [string[]]
    ${RemoveSupportedFormats},

    [switch]
    ${ClearSupportedFormats},

    [System.Nullable[int]]
    ${MaximumGroupSize},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPWordConversionServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPWordConversionServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

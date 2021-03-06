function Set-SPTranslationServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Low')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Microsoft.Office.TranslationServices.Powershell.TranslationServiceApplicationPipeBind, Microsoft.Office.TranslationServices, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${Identity},

    [string]
    ${DatabaseName},

    [pscredential]
    ${DatabaseCredential},

    [string]
    ${DatabaseServer},

    [string]
    ${FailoverDatabaseServer},

    [System.Nullable[int]]
    ${TimerJobFrequency},

    [System.Nullable[int]]
    ${MaximumTranslationAttempts},

    [System.Nullable[int]]
    ${KeepAliveTimeout},

    [System.Nullable[int]]
    ${MaximumTranslationTime},

    [System.Nullable[int]]
    ${TranslationsPerInstance},

    [System.Nullable[int]]
    ${MaximumSyncTranslationRequests},

    [System.Nullable[int]]
    ${RecycleProcessThreshold},

    [System.Nullable[int]]
    ${TotalActiveProcesses},

    [string]
    ${MachineTranslationClientId},

    [string]
    ${MachineTranslationCategory},

    [switch]
    ${UseDefaultInternetSettings},

    [string]
    ${WebProxyAddress},

    [string]
    ${MachineTranslationAddress},

    [System.Nullable[int]]
    ${JobExpirationDays},

    [System.Nullable[int]]
    ${MaximumItemsPerDay},

    [System.Nullable[int]]
    ${MaximumItemsPerPartitionPerDay},

    [System.Nullable[int]]
    ${MaximumBinaryFileSize},

    [System.Nullable[int]]
    ${MaximumTextFileSize},

    [System.Nullable[int]]
    ${MaximumWordCharacterCount},

    [System.Nullable[bool]]
    ${DisableBinaryFileScan},

    [Parameter(ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [string[]]
    ${AddEnabledFileExtensions},

    [string[]]
    ${RemoveEnabledFileExtensions},

    [switch]
    ${ClearEnabledFileExtensions},

    [switch]
    ${EnableAllFileExtensions},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPTranslationServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPTranslationServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

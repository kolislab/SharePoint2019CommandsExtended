function New-SPTranslationServiceApplicationProxy() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Low')]
param(
    [switch]
    ${DefaultProxyGroup},

    [Parameter(Mandatory=$true)]
    [string]
    ${Name},

    [switch]
    ${PartitionMode},

    [Parameter(ParameterSetName='ConnectLocal', Mandatory=$true)]
    [Microsoft.Office.TranslationServices.Powershell.TranslationServiceApplicationPipeBind, Microsoft.Office.TranslationServices, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${ServiceApplication},

    [Parameter(ParameterSetName='ConnectRemote', Mandatory=$true)]
    [string]
    ${Uri},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPTranslationServiceApplicationProxy', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPTranslationServiceApplicationProxy
.ForwardHelpCategory Cmdlet

#>
}

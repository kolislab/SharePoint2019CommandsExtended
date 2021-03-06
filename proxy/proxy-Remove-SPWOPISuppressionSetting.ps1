function Remove-SPWOPISuppressionSetting() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(ParameterSetName='DocTypeAndAction')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Extension},

    [Parameter(ParameterSetName='DocTypeAndAction')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ProgId},

    [Parameter(ParameterSetName='DocTypeAndAction')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Action},

    [Parameter(ParameterSetName='Identity', ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Identity},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Remove-SPWOPISuppressionSetting', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Remove-SPWOPISuppressionSetting
.ForwardHelpCategory Cmdlet

#>
}

function New-SPPowerPointConversionServiceApplicationProxy() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateLength(1, 128)]
    [string]
    ${Name},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.PowerPoint.PowerShell.SPPowerPointConversionServiceApplicationPipeBind, Microsoft.Office.Server.Powerpoint, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${ServiceApplication},

    [switch]
    ${AddToDefaultGroup},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPPowerPointConversionServiceApplicationProxy', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPPowerPointConversionServiceApplicationProxy
.ForwardHelpCategory Cmdlet

#>
}

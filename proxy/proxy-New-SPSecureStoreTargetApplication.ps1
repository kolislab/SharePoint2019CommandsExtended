function New-SPSecureStoreTargetApplication() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [Microsoft.BusinessData.Infrastructure.SecureStore.TargetApplicationType]
    ${ApplicationType},

    [string]
    ${ContactEmail},

    [Parameter(Mandatory=$true)]
    [string]
    ${FriendlyName},

    [Parameter(Mandatory=$true)]
    [string]
    ${Name},

    [ValidateNotNull()]
    [uri]
    ${SetCredentialsUri},

    [int]
    ${TimeoutInMinutes},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPSecureStoreTargetApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPSecureStoreTargetApplication
.ForwardHelpCategory Cmdlet

#>
}

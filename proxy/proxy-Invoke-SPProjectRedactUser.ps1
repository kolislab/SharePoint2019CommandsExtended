function Invoke-SPProjectRedactUser() {
[CmdletBinding()]
param(
    [Parameter(ParameterSetName='ByClaimsAccountWithUpdateName', Mandatory=$true)]
    [Parameter(ParameterSetName='ByResourceIdWithoutUpdateName', Mandatory=$true)]
    [Parameter(ParameterSetName='ByResourceIdWithUpdateName', Mandatory=$true)]
    [Parameter(ParameterSetName='ByClaimsAccountWithoutUpdateName', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [uri]
    ${Url},

    [Parameter(ParameterSetName='ByResourceIdWithoutUpdateName', Mandatory=$true)]
    [Parameter(ParameterSetName='ByResourceIdWithUpdateName', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [guid]
    ${ResourceId},

    [Parameter(ParameterSetName='ByClaimsAccountWithoutUpdateName', Mandatory=$true)]
    [Parameter(ParameterSetName='ByClaimsAccountWithUpdateName', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ClaimsAccount},

    [Parameter(ParameterSetName='ByClaimsAccountWithUpdateName', Mandatory=$true)]
    [Parameter(ParameterSetName='ByResourceIdWithUpdateName', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${UpdateDisplayName},

    [Parameter(ParameterSetName='ByClaimsAccountWithUpdateName', Mandatory=$true)]
    [Parameter(ParameterSetName='ByResourceIdWithUpdateName', Mandatory=$true)]
    [bool]
    ${RedactTimesheet},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Invoke-SPProjectRedactUser', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Invoke-SPProjectRedactUser
.ForwardHelpCategory Cmdlet

#>
}

function Connect-SPConfigurationDatabase() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [string]
    ${DatabaseName},

    [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServer},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [pscredential]
    ${DatabaseCredentials},

    [Parameter(Mandatory=$true, Position=8, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [securestring]
    ${Passphrase},

    [Parameter(Position=9, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${SkipRegisterAsDistributedCacheHost},

    [string]
    ${DatabaseFailOverPartner},

    [ValidateSet('Application','ApplicationWithSearch','Custom','DistributedCache','Search','SingleServerFarm','WebFrontEnd','WebFrontEndWithDistributedCache')]
    [System.Nullable[Microsoft.SharePoint.Administration.SPServerRole]]
    ${LocalServerRole},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Connect-SPConfigurationDatabase', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Connect-SPConfigurationDatabase
.ForwardHelpCategory Cmdlet

#>
}

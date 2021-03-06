function New-SPMetadataServiceApplication() {
[CmdletBinding(DefaultParameterSetName='Default', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [string]
    ${AdministratorAccount},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [string]
    ${DatabaseName},

    [string]
    ${DatabaseServer},

    [pscredential]
    ${DatabaseCredentials},

    [string]
    ${FailoverDatabaseServer},

    [string]
    ${FullAccessAccount},

    [string]
    ${HubUri},

    [Parameter(ParameterSetName='Quota', Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='NoQuota', Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Default', Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Name},

    [switch]
    ${PartitionMode},

    [string]
    ${ReadAccessAccount},

    [string]
    ${RestrictedAccount},

    [switch]
    ${SyndicationErrorReportEnabled},

    [int]
    ${CacheTimeCheckInterval},

    [int]
    ${MaxChannelCache},

    [Parameter(ParameterSetName='NoQuota', Mandatory=$true)]
    [switch]
    ${DisablePartitionQuota},

    [Parameter(ParameterSetName='Quota', Mandatory=$true)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${GroupsPerPartition},

    [Parameter(ParameterSetName='Quota', Mandatory=$true)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${TermSetsPerPartition},

    [Parameter(ParameterSetName='Quota', Mandatory=$true)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${TermsPerPartition},

    [Parameter(ParameterSetName='Quota', Mandatory=$true)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${LabelsPerPartition},

    [Parameter(ParameterSetName='Quota', Mandatory=$true)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${PropertiesPerPartition},

    [switch]
    ${DeferUpgradeActions},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPMetadataServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPMetadataServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

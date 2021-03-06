function Set-SPMetadataServiceApplication() {
[CmdletBinding(DefaultParameterSetName='Default', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [string]
    ${AdministratorAccount},

    [Parameter(ValueFromPipeline=$true)]
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

    [int]
    ${CacheTimeCheckInterval},

    [int]
    ${MaxChannelCache},

    [switch]
    ${DoNotUnpublishAllPackages},

    [Parameter(ParameterSetName='NoQuota', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='Quota', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='Default', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.Taxonomy.Cmdlet.SPMetadataServiceCmdletPipeBind, Microsoft.SharePoint.Taxonomy, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${Identity},

    [string]
    ${Name},

    [string]
    ${ReadAccessAccount},

    [string]
    ${RestrictedAccount},

    [switch]
    ${SyndicationErrorReportEnabled},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPMetadataServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPMetadataServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

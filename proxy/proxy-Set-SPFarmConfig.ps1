function Set-SPFarmConfig() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [int]
    ${WorkflowBatchSize},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [int]
    ${WorkflowPostponeThreshold},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [int]
    ${WorkflowEventDeliveryTimeout},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${InstalledProductsRefresh},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [bool]
    ${DataFormWebPartAutoRefreshEnabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [bool]
    ${ASPScriptOptimizationEnabled},

    [switch]
    ${ServiceConnectionPointDelete},

    [string]
    ${ServiceConnectionPointBindingInformation},

    [System.Nullable[Microsoft.SharePoint.Administration.SPSiteMasterMode]]
    ${SiteMasterMode},

    [System.Nullable[uint32]]
    ${SiteMasterValidationIntervalInHours},

    [System.Nullable[bool]]
    ${DefaultActivateOnSiteMasterValue},

    [switch]
    ${Force},

    [System.Nullable[switch]]
    ${UserAccountDirectoryPathIsImmutable},

    [System.Nullable[uint32]]
    ${MaxTenantStoreValueLength},

    [System.Nullable[uint32]]
    ${MaxSiteSubscriptionSettingsValueLength},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPFarmConfig', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPFarmConfig
.ForwardHelpCategory Cmdlet

#>
}

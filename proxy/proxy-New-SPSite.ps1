function New-SPSite() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [string]
    ${Url},

    [uint32]
    ${Language},

    [Microsoft.SharePoint.PowerShell.SPWebTemplatePipeBind]
    ${Template},

    [string]
    ${Name},

    [string]
    ${Description},

    [Microsoft.SharePoint.PowerShell.SPQuotaTemplatePipeBind]
    ${QuotaTemplate},

    [string]
    ${OwnerEmail},

    [Parameter(Mandatory=$true)]
    [Microsoft.SharePoint.PowerShell.SPUserPipeBind]
    ${OwnerAlias},

    [string]
    ${SecondaryEmail},

    [Microsoft.SharePoint.PowerShell.SPUserPipeBind]
    ${SecondaryOwnerAlias},

    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${HostHeaderWebApplication},

    [Microsoft.SharePoint.PowerShell.SPContentDatabasePipeBind]
    ${ContentDatabase},

    [Microsoft.SharePoint.PowerShell.SPSiteSubscriptionPipeBind]
    ${SiteSubscription},

    [Microsoft.SharePoint.SPAdministrationSiteType]
    ${AdministrationSiteType},

    [int]
    ${CompatibilityLevel},

    [switch]
    ${OverrideCompatibilityRestriction},

    [switch]
    ${CreateFromSiteMaster},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPSite', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPSite
.ForwardHelpCategory Cmdlet

#>
}

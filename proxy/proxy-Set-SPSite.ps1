function Set-SPSite() {
[CmdletBinding(DefaultParameterSetName='Default', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPSitePipeBind]
    ${Identity},

    [Parameter(ParameterSetName='Default')]
    [Microsoft.SharePoint.PowerShell.SPUserPipeBind]
    ${OwnerAlias},

    [Parameter(ParameterSetName='Default')]
    [Microsoft.SharePoint.PowerShell.SPQuotaTemplatePipeBind]
    ${QuotaTemplate},

    [Parameter(ParameterSetName='Default')]
    [Microsoft.SharePoint.PowerShell.SPWebTemplatePipeBind]
    ${Template},

    [Parameter(ParameterSetName='Default')]
    [string]
    ${Url},

    [Parameter(ParameterSetName='Default')]
    [long]
    ${MaxSize},

    [Parameter(ParameterSetName='Default')]
    [long]
    ${WarningSize},

    [Parameter(ParameterSetName='Default')]
    [string]
    ${SharingType},

    [Parameter(ParameterSetName='Default')]
    [ValidateSet('Unlock','NoAdditions','ReadOnly','NoAccess')]
    [string]
    ${LockState},

    [Parameter(ParameterSetName='Default')]
    [Microsoft.SharePoint.PowerShell.SPUserPipeBind]
    ${SecondaryOwnerAlias},

    [Parameter(ParameterSetName='Default')]
    [string]
    ${UserAccountDirectoryPath},

    [Parameter(ParameterSetName='SiteSubscription')]
    [Microsoft.SharePoint.PowerShell.SPSiteSubscriptionPipeBind]
    ${SiteSubscription},

    [Parameter(ParameterSetName='SiteSubscription')]
    [switch]
    ${Force},

    [Microsoft.SharePoint.SPAdministrationSiteType]
    ${AdministrationSiteType},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPSite', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPSite
.ForwardHelpCategory Cmdlet

#>
}

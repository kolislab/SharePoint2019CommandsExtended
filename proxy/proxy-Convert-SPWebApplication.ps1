function Convert-SPWebApplication() {
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${Identity},

    [Parameter(ParameterSetName='Claims', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateSet('LEGACY','CLAIMS-WINDOWS','CLAIMS-TRUSTED-DEFAULT')]
    [string]
    ${From},

    [Parameter(ParameterSetName='Claims', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateSet('CLAIMS','CLAIMS-WINDOWS','CLAIMS-TRUSTED-DEFAULT','CLAIMS-SHAREPOINT-ONLINE')]
    [string]
    ${To},

    [switch]
    ${Force},

    [switch]
    ${RetainPermissions},

    [ValidateNotNullOrEmpty()]
    [string]
    ${SourceSkipList},

    [Parameter(ParameterSetName='Claims')]
    [Parameter(ParameterSetName='ClaimOnline', Mandatory=$true)]
    [Parameter(ParameterSetName='ClaimOnlineToOnline', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${MapList},

    [switch]
    ${SkipSites},

    [switch]
    ${SkipPolicies},

    [ValidateNotNull()]
    [Microsoft.SharePoint.Administration.SPContentDatabase]
    ${Database},

    [Parameter(ParameterSetName='Claims')]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPTrustedIdentityTokenIssuerPipeBind]
    ${TrustedProvider},

    [Parameter(ParameterSetName='ClaimOnlineToOnline', Mandatory=$true)]
    [Parameter(ParameterSetName='ClaimOnline', Mandatory=$true)]
    [Parameter(ParameterSetName='Claims')]
    [guid]
    ${SiteSubsriptionId},

    [Parameter(ParameterSetName='ClaimOnlineToOnline', Mandatory=$true)]
    [guid]
    ${SourceSiteSubscriptionId},

    [ValidateNotNullOrEmpty()]
    [string]
    ${LoggingDirectory},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Convert-SPWebApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Convert-SPWebApplication
.ForwardHelpCategory Cmdlet

#>
}

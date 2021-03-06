function New-SPEnterpriseSearchMetadataCrawledProperty() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true)]
    [string]
    ${Name},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(Mandatory=$true)]
    [Alias('c')]
    [Microsoft.Office.Server.Search.Cmdlet.CategoryPipeBind]
    ${Category},

    [Parameter(Mandatory=$true)]
    [Alias('ie')]
    [bool]
    ${IsNameEnum},

    [Parameter(Mandatory=$true)]
    [Alias('vt')]
    [Obsolete()]
    [int]
    ${VariantType},

    [Parameter(Mandatory=$true)]
    [Alias('p')]
    [guid]
    ${PropSet},

    [Alias('im')]
    [System.Nullable[bool]]
    ${IsMappedToContents},

    [guid]
    ${Tenant},

    [guid]
    ${SiteCollection},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchMetadataCrawledProperty', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchMetadataCrawledProperty
.ForwardHelpCategory Cmdlet

#>
}

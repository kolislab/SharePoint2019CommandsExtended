function Import-SPBusinessDataCatalogModel() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [switch]
    ${ModelsIncluded},

    [switch]
    ${LocalizedNamesIncluded},

    [switch]
    ${PropertiesIncluded},

    [switch]
    ${PermissionsIncluded},

    [Parameter(ParameterSetName='Catalog', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.BusinessData.Administration.MetadataObject]
    ${Identity},

    [Parameter(ParameterSetName='ServiceContext', Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPServiceContextPipeBind]
    ${ServiceContext},

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Path},

    [switch]
    ${Force},

    [string]
    ${SettingId},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Import-SPBusinessDataCatalogModel', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Import-SPBusinessDataCatalogModel
.ForwardHelpCategory Cmdlet

#>
}

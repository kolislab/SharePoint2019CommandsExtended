function Set-SPEnterpriseSearchMetadataCategory() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.CategoryPipeBind]
    ${Identity},

    [Parameter(Mandatory=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Alias('n')]
    [string]
    ${Name},

    [Alias('d')]
    [System.Nullable[bool]]
    ${DiscoverNewProperties},

    [Alias('m')]
    [System.Nullable[bool]]
    ${MapToContents},

    [Alias('auto')]
    [System.Nullable[bool]]
    ${AutoCreateNewManagedProperties},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchMetadataCategory', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPEnterpriseSearchMetadataCategory
.ForwardHelpCategory Cmdlet

#>
}

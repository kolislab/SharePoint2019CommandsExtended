function Set-SPAccessServicesDatabaseServerGroupMapping() {
[CmdletBinding(DefaultParameterSetName='SetDatabaseServerGroupMappingParameter', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='ClearDatabaseServerGroupMappingParameterSetName', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SetDatabaseServerGroupMappingParameter', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceContextPipeBind]
    ${ServiceContext},

    [Parameter(ParameterSetName='SetDatabaseServerGroupMappingParameter', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Office.Access.Services.PowerShell.AccessServicesDatabaseServerGroupPipeBind, Microsoft.Office.Access.Services.Moss, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${DatabaseServerGroup},

    [Parameter(ParameterSetName='SetDatabaseServerGroupMappingParameter')]
    [Parameter(ParameterSetName='ClearDatabaseServerGroupMappingParameterSetName')]
    [switch]
    ${CorporateCatalog},

    [Parameter(ParameterSetName='ClearDatabaseServerGroupMappingParameterSetName')]
    [Parameter(ParameterSetName='SetDatabaseServerGroupMappingParameter')]
    [switch]
    ${ObjectModel},

    [Parameter(ParameterSetName='ClearDatabaseServerGroupMappingParameterSetName')]
    [Parameter(ParameterSetName='SetDatabaseServerGroupMappingParameter')]
    [switch]
    ${RemoteObjectModel},

    [Parameter(ParameterSetName='SetDatabaseServerGroupMappingParameter')]
    [Parameter(ParameterSetName='ClearDatabaseServerGroupMappingParameterSetName')]
    [switch]
    ${DeveloperSite},

    [Parameter(ParameterSetName='ClearDatabaseServerGroupMappingParameterSetName')]
    [Parameter(ParameterSetName='SetDatabaseServerGroupMappingParameter')]
    [switch]
    ${StoreFront},

    [Parameter(ParameterSetName='ClearDatabaseServerGroupMappingParameterSetName', Mandatory=$true)]
    [switch]
    ${ClearMapping},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPAccessServicesDatabaseServerGroupMapping', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPAccessServicesDatabaseServerGroupMapping
.ForwardHelpCategory Cmdlet

#>
}

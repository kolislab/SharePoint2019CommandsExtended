function Get-SPAccessServicesDatabaseServer() {
[CmdletBinding(DefaultParameterSetName='GetDatabaseServersParameterSet')]
param(
    [Parameter(ParameterSetName='GetDatabaseServersParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='GetSingleDatabaseServerParamterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceContextPipeBind]
    ${ServiceContext},

    [Parameter(ParameterSetName='GetSingleDatabaseServerParamterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='GetDatabaseServersParameterSet')]
    [Microsoft.Office.Access.Services.PowerShell.AccessServicesDatabaseServerGroupPipeBind, Microsoft.Office.Access.Services.Moss, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${DatabaseServerGroup},

    [Parameter(ParameterSetName='GetSingleDatabaseServerParamterSet', Mandatory=$true)]
    [Microsoft.Office.Access.Services.PowerShell.AccessServicesDatabaseServerPipeBind, Microsoft.Office.Access.Services.Moss, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${DatabaseServer},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Get-SPAccessServicesDatabaseServer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Get-SPAccessServicesDatabaseServer
.ForwardHelpCategory Cmdlet

#>
}

function New-SPAccessServicesDatabaseServer() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceContextPipeBind]
    ${ServiceContext},

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServerName},

    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServerGroupName},

    [ValidateNotNullOrEmpty()]
    [guid]
    ${ServerReferenceId},

    [ValidateNotNullOrEmpty()]
    [pscredential]
    ${DatabaseServerCredentials},

    [ValidateNotNullOrEmpty()]
    [bool]
    ${AvailableForCreate},

    [ValidateNotNullOrEmpty()]
    [bool]
    ${Exclusive},

    [bool]
    ${Encrypt},

    [bool]
    ${TrustServerCertificate},

    [bool]
    ${ValidateServer},

    [ValidateNotNullOrEmpty()]
    [string]
    ${SecondaryDatabaseServerName},

    [ValidateNotNullOrEmpty()]
    [string]
    ${UserDomain},

    [Microsoft.Office.Access.Services.Host.LoginType]
    ${LoginType},

    [Microsoft.Office.Access.Services.MossHost.DatabaseServerStates]
    ${State},

    [Microsoft.Office.Access.Services.MossHost.ServerStateOwner]
    ${StateOwner},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPAccessServicesDatabaseServer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPAccessServicesDatabaseServer
.ForwardHelpCategory Cmdlet

#>
}

function Set-SPAccessServicesDatabaseServer() {
[CmdletBinding(DefaultParameterSetName='SetCredentialsParameterSet', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='SetSecondaryDatabaseServerNameParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SetServerStateParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SetAvailableForCreateParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SetEncryptParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SetCredentialsParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SetFailoverParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='SetUserDomainParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceContextPipeBind]
    ${ServiceContext},

    [Parameter(ParameterSetName='SetServerStateParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetSecondaryDatabaseServerNameParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetUserDomainParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetFailoverParameterSet', Mandatory=$true)]
    [Parameter(Mandatory=$true)]
    [Parameter(ParameterSetName='SetCredentialsParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetAvailableForCreateParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetEncryptParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Office.Access.Services.PowerShell.AccessServicesDatabaseServerGroupPipeBind, Microsoft.Office.Access.Services.Moss, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${DatabaseServerGroup},

    [Parameter(ParameterSetName='SetServerStateParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetEncryptParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetUserDomainParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetFailoverParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetSecondaryDatabaseServerNameParameterSet', Mandatory=$true)]
    [Parameter(Mandatory=$true)]
    [Parameter(ParameterSetName='SetCredentialsParameterSet', Mandatory=$true)]
    [Parameter(ParameterSetName='SetAvailableForCreateParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Office.Access.Services.PowerShell.AccessServicesDatabaseServerPipeBind, Microsoft.Office.Access.Services.Moss, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c]
    ${DatabaseServer},

    [Parameter(ParameterSetName='SetCredentialsParameterSet')]
    [string]
    ${DatabaseServerName},

    [Parameter(ParameterSetName='SetCredentialsParameterSet')]
    [pscredential]
    ${DatabaseServerCredentials},

    [Parameter(ParameterSetName='SetAvailableForCreateParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [bool]
    ${AvailableForCreate},

    [Parameter(ParameterSetName='SetAvailableForCreateParameterSet')]
    [ValidateNotNullOrEmpty()]
    [bool]
    ${Exclusive},

    [Parameter(ParameterSetName='SetEncryptParameterSet', Mandatory=$true)]
    [bool]
    ${Encrypt},

    [Parameter(ParameterSetName='SetEncryptParameterSet', Mandatory=$true)]
    [bool]
    ${TrustServerCertificate},

    [Parameter(ParameterSetName='SetSecondaryDatabaseServerNameParameterSet')]
    [string]
    ${SecondaryDatabaseServerName},

    [Parameter(ParameterSetName='SetFailoverParameterSet', Mandatory=$true)]
    [bool]
    ${Failover},

    [Parameter(ParameterSetName='SetUserDomainParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${UserDomain},

    [Parameter(ParameterSetName='SetServerStateParameterSet', Mandatory=$true)]
    [Microsoft.Office.Access.Services.MossHost.DatabaseServerStates]
    ${State},

    [Parameter(ParameterSetName='SetServerStateParameterSet', Mandatory=$true)]
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPAccessServicesDatabaseServer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPAccessServicesDatabaseServer
.ForwardHelpCategory Cmdlet

#>
}

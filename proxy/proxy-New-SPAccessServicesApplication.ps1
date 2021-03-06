function New-SPAccessServicesApplication() {
[CmdletBinding(DefaultParameterSetName='NoApplicationServerParameterSet', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='DefaultParameterSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServer},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [ValidateNotNull()]
    [pscredential]
    ${DatabaseServerCredentials},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet', Mandatory=$true, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='DefaultParameterSet', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPIisWebServiceApplicationPoolPipeBind]
    ${ApplicationPool},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [string]
    ${Name},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet', Mandatory=$true)]
    [switch]
    ${Default},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [ValidateRange(-1, 2073600)]
    [int]
    ${RequestDurationMax},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [ValidateRange(-1, 2147483647)]
    [int]
    ${SessionsPerUserMax},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [ValidateRange(-1, 2147483647)]
    [int]
    ${SessionsPerAnonymousUserMax},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [ValidateRange(-1, 2073600)]
    [int]
    ${CacheTimeout},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [ValidateRange(-1, 2147483647)]
    [int]
    ${PrivateBytesMax},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [ValidateRange(-1, 2073600)]
    [int]
    ${QueryTimeout},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [ValidateRange(-1, 1440)]
    [int]
    ${RecoveryPointObjective},

    [Parameter(ParameterSetName='NoApplicationServerParameterSet')]
    [Parameter(ParameterSetName='DefaultParameterSet')]
    [bool]
    ${Hosted},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [bool]
    ${Encrypt},

    [Parameter(ParameterSetName='DefaultParameterSet')]
    [bool]
    ${TrustServerCertificate},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPAccessServicesApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPAccessServicesApplication
.ForwardHelpCategory Cmdlet

#>
}

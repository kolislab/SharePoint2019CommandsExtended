function Set-SPODataConnectionSetting() {
[CmdletBinding(DefaultParameterSetName='Name', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPServiceContextPipeBind]
    ${ServiceContext},

    [Parameter(ParameterSetName='Name', Mandatory=$true)]
    [ValidateNotNull()]
    [ValidateLength(0, 246)]
    [string]
    ${Name},

    [ValidateNotNull()]
    [uri]
    ${ServiceAddressURL},

    [ValidateNotNull()]
    [System.Nullable[Microsoft.SharePoint.BusinessData.SystemSpecific.OData.ODataAuthenticationMode]]
    ${AuthenticationMode},

    [ValidateNotNull()]
    [ValidateLength(0, 1024)]
    [string]
    ${SecureStoreTargetApplicationId},

    [string]
    ${ExtensionProvider},

    [Parameter(ParameterSetName='Identity', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.BusinessData.SystemSpecific.OData.ODataConnectionSettings]
    ${Identity},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPODataConnectionSetting', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPODataConnectionSetting
.ForwardHelpCategory Cmdlet

#>
}

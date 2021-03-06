function Set-SPBusinessDataCatalogServiceApplication() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Microsoft.SharePoint.PowerShell.SPServiceApplicationPipeBind]
    ${Identity},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Name},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${Sharing},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DatabaseServer},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    ${DatabaseName},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    ${FailoverDatabaseServer},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Microsoft.SharePoint.Administration.SPIisWebServiceApplicationPool]
    ${ApplicationPool},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [pscredential]
    ${DatabaseCredentials},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]
    ${DatabaseUsername},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [securestring]
    ${DatabasePassword},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPBusinessDataCatalogServiceApplication', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPBusinessDataCatalogServiceApplication
.ForwardHelpCategory Cmdlet

#>
}

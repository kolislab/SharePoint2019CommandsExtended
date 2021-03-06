function New-SPUserLicenseMapping() {
[CmdletBinding(DefaultParameterSetName='WindowsAuth', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='WindowsAuth', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SecurityGroup},

    [Parameter(ParameterSetName='FormsAuth', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Role},

    [Parameter(ParameterSetName='FormsAuth', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${RoleProviderName},

    [Parameter(ParameterSetName='ClaimsValues', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${OriginalIssuer},

    [Parameter(ParameterSetName='ClaimsValues', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Value},

    [Parameter(ParameterSetName='ClaimsValues', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ClaimType},

    [Parameter(ParameterSetName='ClaimsValues')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ValueType},

    [Parameter(ParameterSetName='TrustIdentity', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.Administration.Claims.SPClaim]
    ${Claim},

    [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${License},

    [ValidateNotNull()]
    [Microsoft.SharePoint.PowerShell.SPWebApplicationPipeBind]
    ${WebApplication},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPUserLicenseMapping', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPUserLicenseMapping
.ForwardHelpCategory Cmdlet

#>
}

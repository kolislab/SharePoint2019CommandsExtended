function New-SPClaimsPrincipal() {
[CmdletBinding(DefaultParameterSetName='IdentityType')]
param(
    [Parameter(ParameterSetName='TrustIdentity', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='IdentityType', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Identity},

    [Parameter(ParameterSetName='TrustIdentity', Mandatory=$true, Position=1)]
    [Parameter(ParameterSetName='STSIdentity', Mandatory=$true, Position=2)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.SharePoint.PowerShell.SPTrustedIdentityTokenIssuerPipeBind]
    ${TrustedIdentityTokenIssuer},

    [Parameter(ParameterSetName='IdentityType', Mandatory=$true, Position=1)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.Administration.Claims.SPIdentifierTypes]
    ${IdentityType},

    [Parameter(ParameterSetName='BasicClaim', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${EncodedClaim},

    [Parameter(ParameterSetName='STSIdentity', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='ClaimProvider', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ClaimValue},

    [Parameter(ParameterSetName='ClaimProvider', Mandatory=$true, Position=1)]
    [Parameter(ParameterSetName='STSIdentity', Position=1)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ClaimType},

    [Parameter(ParameterSetName='ClaimProvider', Mandatory=$true, Position=2)]
    [ValidateNotNull()]
    [Microsoft.SharePoint.Administration.Claims.SPClaimProvider]
    ${ClaimProvider},

    [Parameter(ParameterSetName='STSIdentity', Position=3)]
    [ValidateNotNull()]
    [switch]
    ${IdentifierClaim},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPClaimsPrincipal', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPClaimsPrincipal
.ForwardHelpCategory Cmdlet

#>
}

function New-SPEnterpriseSearchQueryKeyword() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    ${Term},

    [Parameter(Mandatory=$true)]
    [Microsoft.SharePoint.PowerShell.SPSitePipeBind]
    ${Site},

    [Alias('d')]
    [string]
    ${Definition},

    [Alias('c')]
    [string]
    ${Contact},

    [Alias('s')]
    [System.Nullable[datetime]]
    ${StartDate},

    [Alias('e')]
    [System.Nullable[datetime]]
    ${EndDate},

    [Alias('r')]
    [System.Nullable[datetime]]
    ${ReviewDate},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchQueryKeyword', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchQueryKeyword
.ForwardHelpCategory Cmdlet

#>
}

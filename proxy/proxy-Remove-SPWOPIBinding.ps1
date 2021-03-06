function Remove-SPWOPIBinding() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(ParameterSetName='Identity', Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPWopiBindingPipeBind]
    ${Identity},

    [Parameter(ParameterSetName='Filter')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Action},

    [Parameter(ParameterSetName='Filter')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Extension},

    [Parameter(ParameterSetName='Filter')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ProgId},

    [Parameter(ParameterSetName='Filter')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Application},

    [Parameter(ParameterSetName='Filter')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Server},

    [Parameter(ParameterSetName='Filter')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${WOPIZone},

    [Parameter(ParameterSetName='RemoveAll')]
    [switch]
    ${All},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Remove-SPWOPIBinding', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Remove-SPWOPIBinding
.ForwardHelpCategory Cmdlet

#>
}

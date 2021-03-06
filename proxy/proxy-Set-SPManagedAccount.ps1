function Set-SPManagedAccount() {
[CmdletBinding(DefaultParameterSetName='Default', SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.SharePoint.PowerShell.SPManagedAccountPipeBind]
    ${Identity},

    [string]
    ${Schedule},

    [int]
    ${PreExpireDays},

    [int]
    ${EmailNotification},

    [Parameter(ParameterSetName='AutoGeneratePassword')]
    [switch]
    ${AutoGeneratePassword},

    [Parameter(ParameterSetName='NewPasswordAsParameter', Mandatory=$true)]
    [securestring]
    ${Password},

    [Parameter(ParameterSetName='NewPassword')]
    [switch]
    ${SetNewPassword},

    [Parameter(ParameterSetName='NewPassword', Mandatory=$true)]
    [securestring]
    ${NewPassword},

    [Parameter(ParameterSetName='NewPassword', Mandatory=$true)]
    [securestring]
    ${ConfirmPassword},

    [Parameter(ParameterSetName='ExistingPassword')]
    [switch]
    ${UseExistingPassword},

    [Parameter(ParameterSetName='ExistingPassword', Mandatory=$true)]
    [securestring]
    ${ExistingPassword},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Set-SPManagedAccount', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Set-SPManagedAccount
.ForwardHelpCategory Cmdlet

#>
}

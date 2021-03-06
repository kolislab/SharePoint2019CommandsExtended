function New-SPEnterpriseSearchMetadataManagedProperty() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    ${Name},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(Mandatory=$true)]
    [Alias('t')]
    [int]
    ${Type},

    [Alias('d')]
    [string]
    ${Description},

    [Alias('f')]
    [System.Nullable[bool]]
    ${FullTextQueriable},

    [Alias('r')]
    [System.Nullable[bool]]
    ${Retrievable},

    [Alias('q')]
    [System.Nullable[bool]]
    ${Queryable},

    [Alias('e')]
    [System.Nullable[bool]]
    ${EnabledForScoping},

    [Alias('nn')]
    [System.Nullable[bool]]
    ${NameNormalized},

    [Alias('rp')]
    [System.Nullable[bool]]
    ${RespectPriority},

    [Alias('rd')]
    [System.Nullable[bool]]
    ${RemoveDuplicates},

    [Alias('im5')]
    [Obsolete('This property is replaced by IncludeInAlertSignature.')]
    [System.Nullable[bool]]
    ${IncludeInMd5},

    [Alias('sfa')]
    [System.Nullable[bool]]
    ${SafeForAnonymous},

    [Alias('eps')]
    [System.Nullable[bool]]
    ${ExpandSegments},

    [Alias('lnw')]
    [System.Nullable[bool]]
    ${LanguageNeutralWordBreaker},

    [Alias('ia')]
    [System.Nullable[bool]]
    ${IncludeInAlertSignature},

    [Alias('nw')]
    [System.Nullable[bool]]
    ${NoWordBreaker},

    [Alias('u')]
    [System.Nullable[int16]]
    ${UserFlags},

    [Alias('qir')]
    [System.Nullable[bool]]
    ${EnabledForQueryIndependentRank},

    [Alias('def')]
    [System.Nullable[uint32]]
    ${DefaultForQueryIndependentRank},

    [guid]
    ${Tenant},

    [guid]
    ${SiteCollection},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchMetadataManagedProperty', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\New-SPEnterpriseSearchMetadataManagedProperty
.ForwardHelpCategory Cmdlet

#>
}

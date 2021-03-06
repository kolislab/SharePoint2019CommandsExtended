function Import-SPEnterpriseSearchCustomExtractionDictionary() {
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory=$true)]
    [Microsoft.Office.Server.Search.Cmdlet.SearchServiceApplicationPipeBind]
    ${SearchApplication},

    [Parameter(Mandatory=$true, HelpMessage='Specify the UNC path to the CSV file.')]
    [string]
    ${FileName},

    [Parameter(Mandatory=$true, HelpMessage='Specify the fully qualified name of the target dictionary to be deployed.')]
    [ValidateSet('Microsoft.UserDictionaries.EntityExtraction.Custom.Word.1','Microsoft.UserDictionaries.EntityExtraction.Custom.Word.2','Microsoft.UserDictionaries.EntityExtraction.Custom.Word.3','Microsoft.UserDictionaries.EntityExtraction.Custom.Word.4','Microsoft.UserDictionaries.EntityExtraction.Custom.Word.5','Microsoft.UserDictionaries.EntityExtraction.Custom.ExactWord.1','Microsoft.UserDictionaries.EntityExtraction.Custom.WordPart.1','Microsoft.UserDictionaries.EntityExtraction.Custom.WordPart.2','Microsoft.UserDictionaries.EntityExtraction.Custom.WordPart.3','Microsoft.UserDictionaries.EntityExtraction.Custom.WordPart.4','Microsoft.UserDictionaries.EntityExtraction.Custom.WordPart.5','Microsoft.UserDictionaries.EntityExtraction.Custom.ExactWordPart.1')]
    [string]
    ${DictionaryName},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.SharePoint.PowerShell\Import-SPEnterpriseSearchCustomExtractionDictionary', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.SharePoint.PowerShell\Import-SPEnterpriseSearchCustomExtractionDictionary
.ForwardHelpCategory Cmdlet

#>
}

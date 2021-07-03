try {
    $script:ModuleRoot = $PSScriptRoot
    [Reflection.Assembly]::LoadFile("$ModuleRoot\lib\Microsoft.ApplicationInsights.dll") | Out-Null
    $script:TelemetryClient = New-Object "Microsoft.ApplicationInsights.TelemetryClient"
    if ( -not $script:TelemetryClient ) { throw "Failed to load dll"}
    $script:TelemetryClient.InstrumentationKey = "df6c509a-eda8-41d6-b7b4-d29969ce15b7"
    
    # This is where the magic happens
    $startTime = [DateTime]::Now
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
    $elapsedTime = New-TimeSpan $startTime ([DateTime]::Now)
    . "$script:ModuleRoot\internal\function-Get-StringHash.ps1"

    function Import-ModuleFile {
        [CmdletBinding()]
        Param (
            [string]$Path
        )

        if ($doDotSource) { . $Path }
        else {
            $ExecutionContext.InvokeCommand.InvokeScript($false, ([scriptblock]::Create([io.file]::ReadAllText($Path))), $null, $null)
        }
    }

    function Send-SharePointTelemetry {
        [CmdletBinding()]
        param (
            # Message to log
            [Parameter(Mandatory)]
            [Alias("Message")]
            [System.String]
            $Inputobject
            ,
            [Hashtable]
            $Properties
            ,
            [Hashtable]
            $Metrics
        )
        
        begin {
            $dictProperties = New-Object 'system.collections.generic.dictionary[[string],[string]]'
            $dictMetrics = New-Object 'system.collections.generic.dictionary[[string],[double]]'

            $dictProperties.Add("TelemetrySessionID", $TelemetrySessionID)
            $dictProperties.Add("FarmHash", $FarmID)
            $dictProperties.Add("ServerHash", $ServerID)
        }
        
        process {
            if ($Properties) { 
                foreach ($h in $Properties.GetEnumerator() ) {
                    $dictProperties.Add($h.Name, $h.Value)
                }
            }
            if ($Metrics) { 
                foreach ($h in $Metrics.GetEnumerator()) {
                    $dictMetrics.Add($h.Name, $h.Value)
                }
            }
        }
        
        end {
            $TelemetryClient.TrackEvent($Inputobject, $dictProperties , $dictMetrics)
            $TelemetryClient.Flush()
        }
    }
    # ID assigned to this PowerShell Session
    $script:TelemetrySessionID = [system.Guid]::NewGuid().Guid
    # ID of the Farm
    $script:FarmID = Get-StringHash -String (Microsoft.SharePoint.PowerShell\Get-SPfarm).ID.Guid
    # ID of the Server
    $script:ServerID = Get-StringHash -String (Microsoft.SharePoint.PowerShell\Get-SPServer -Identity $env:COMPUTERNAME).ID.Guid
    # Send telemetry
    Send-SharePointTelemetry -Inputobject "Add-PSSnapin" -Properties @{"elapsedTime" = $elapsedTime }
    $startTime = [DateTime]::Now
    foreach ($function in (Get-ChildItem "$ModuleRoot\proxy" -Filter "*.ps1" -Recurse -ErrorAction Ignore)) {
        . Import-ModuleFile -Path $function.FullName
    }
    $elapsedTime = New-TimeSpan $startTime ([DateTime]::Now)
    Send-SharePointTelemetry -Inputobject "Import-ModuleFile" -Properties @{"elapsedTime" = $elapsedTime }
}
catch {
    write-host $_ -ForegroundColor Red
}
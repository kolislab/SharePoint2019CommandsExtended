function Get-StringHash {

    [cmdletbinding()]
    param (
        [parameter(mandatory = $false, parametersetname = "String")]
        $String,
        [parameter(mandatory = $false, parametersetname = "String")]
        [validateset("MD5")]
        [string]$HashType = "MD5"
    )
    switch ($PsCmdlet.ParameterSetName) { 
        "String" {
            $StringBuilder = New-Object System.Text.StringBuilder 
            [System.Security.Cryptography.HashAlgorithm]::Create($HashType).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($String)) | ForEach-Object {
                [Void]$StringBuilder.Append($_.ToString("x2")) 
            }
            $StringBuilder.ToString()
            
        } 
        
    }
    
    
}
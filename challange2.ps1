$metadataEndpoint = "http://169.254.169.254/metadata/instance?api-version=2021-09-01"
$headers = @{"Metadata"="true"}

function Get-AzureInstanceMetadata {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Key
    )

    $metadataUrl = "$metadataEndpoint&format=json"
    $metadata = Invoke-RestMethod -Uri $metadataUrl -Headers $headers -Method GET
    $value = Get-ValueFromMetadata -Metadata $metadata -Key $Key

    return $value
}

function Get-ValueFromMetadata {
    param (
        [Parameter(Mandatory=$true)]
        [System.Collections.Hashtable]$Metadata,
        
        [Parameter(Mandatory=$true)]
        [string]$Key
    )

    if ($Key -contains '/') {
        $parentKey, $childKey = $Key -split '/', 2
        $parentValue = $Metadata.$parentKey
        if ($parentValue -is [System.Collections.Hashtable]) {
            return Get-ValueFromMetadata -Metadata $parentValue -Key $childKey
        }
    }
    else {
        return $Metadata.$Key
    }
}

# Example usage
$key = "network/interface/0/macAddress"
$value = Get-AzureInstanceMetadata -Key $key
Write-Host "Value for key '$key': $value"

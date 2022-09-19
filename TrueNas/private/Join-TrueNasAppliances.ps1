Function Join-TrueNasAppliance
{
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $true)]
        [String]$sourceDir
    )
    # Regenerate the file All.json list for all appliances
    Remove-Item -Path $sourceDir\All.json  -Force -ErrorAction SilentlyContinue | Out-Null

    # check if the source directory is present
    if (!(Test-Path $sourceDir))
    {
        Write-Host -Message "ERROR: Path not found.Check the path and try again!" -ForegroundColor Red
    }
    else
    {
        $allFiles = @()

        # get the list of files in the source directory
        ForEach ($i in Get-ChildItem $sourceDir -Filter *.json)
        {
            $fileName = $i.Name
            $data = Get-Content -Path $sourceDir\$fileName -Raw | ConvertFrom-Json
            $allFiles += $data
        }
        # write the output to a file
        $allFiles | ConvertTo-Json -Depth 2  | Out-File -FilePath $sourceDir\All.json
    }
}
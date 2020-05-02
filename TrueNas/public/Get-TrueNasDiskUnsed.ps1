function Get-TrueNasDiskUnsed
{
    [CmdletBinding()]
    Param( )

    begin
    {
        $uri = "api/v2.0/disk/get_unused"
    }
    process
    {
        $results = Invoke-TrueNasRestMethod -Uri $Uri -Method POST

        foreach ($disk in $results)
        {
            $Name = ($disk.name)
            $Size_GB = ([Math]::Round($disk.size / 1024 / 1024 / 1024, 2))
            Write-Verbose -Message " Find the disk $name with the size $Size_GB"
            [PSCustomObject]@{
                Name    = ($disk.name)
                Number  = ($disk.number)
                Size_GB = ([Math]::Round($disk.size / 1024 / 1024 / 1024, 2))
                Type    = ($disk.type)
                Model   = ($disk.model)
            }
        }
    }
    end { }
}

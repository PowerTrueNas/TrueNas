function Get-TrueNasDnsServer
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/dns/query"
    }
    Process
    {
        Write-Verbose $uri
        $result = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
    }
    End
    {
        return $result
    }
}

function Get-TrueNasCertificateProfiles
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/certificate/profiles"
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

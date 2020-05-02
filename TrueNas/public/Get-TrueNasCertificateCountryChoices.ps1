function Get-TrueNasCertificateCountryChoices
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()

    Begin
    {
        $uri = "api/v2.0/certificate/country_choices"
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

function Get-TrueNasSystemUpdate
{
    Param( )

    $Uri = "api/v2.0/update/get_trains"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get
    return $results.trains
}

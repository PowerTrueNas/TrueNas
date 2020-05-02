function Get-TrueNasSystemAlert
{
    Param( )

    $Uri = "api/v2.0/alertservice"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    foreach ($Alert in $results)
    {
        [PSCustomObject]@{
            Id           = ($Alert.id)
            Name         = ($Alert.name)
            Type         = ($Alert.type)
            Attributes   = ($Alert.attributes)
            Level        = ($Alert.level)
            Enabled      = ($Alert.enabled)
            'Type title' = ($Alert.type__title)
        }
    }
}

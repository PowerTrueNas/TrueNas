function Get-TrueNasSystemVersion
{
    Param( )

    $Uri = "api/v2.0/system/info"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get


    [PSCustomObject]@{
        Version               = ($results.version)
        'Build time'          = ($results.buildtime)
        'Physical Memory'     = ($results.physmem)
        Model                 = ($results.model)
        Cores                 = ($results.cores)
        'Load Average'        = ($results.loadavg)
        Uptime                = ($results.uptime)
        'Uptime seconds'      = ($results.uptime_seconds)
        'System serial'       = ($results.system_serial)
        'System product'      = ($results.system_product)
        license               = ($results.license)
        'boot time'           = ($results.boottime)
        'Date time'           = ($results.datetime)
        Timezone              = ($results.timezone)
        'System manufacturer' = ($results.system_manufacturer)

    }

}

function Get-TrueNasSystemAdvanced
{
    Param( )

    $Uri = "api/v2.0/system/advanced"

    $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

    foreach ($Info in $results)
    {
        [PSCustomObject]@{
            Id               = ($Info.id)
            'Legacy UI'      = ($Info.legacy_ui)
            Consolemenu      = ($Info.consolemenu)
            'Serial console' = ($Info.serialconsole)
            'Serial port'    = ($Info.serialport)
            'Serial speed'   = ($Info.serialspeed)
            'Power daemon'   = ($Info.powerdaemon)
            'Swap on drive'  = ($Info.swapondrive)
            'Console msg'    = ($Info.consolemsg)
            'Trace back'     = ($Info.traceback)
            'Advanced mode'  = ($Info.advancedmode)
            'Autotune'       = ($Info.autotune)
            'Debug kernel'   = ($Info.debugkernel)
            'Upload crash'   = ($Info.uploadcrash)
            'MOTD'           = ($Info.motd)
            'Anonstats'      = ($Info.anonstats)
            'Boot scrub'     = ($Info.boot_scrub)
            'FQDN syslog'    = ($Info.fqdn_syslog)
            'Sed user'       = ($Info.sed_user)
            'Sed password'   = ($Info.sed_passwd)

        }
    }
}

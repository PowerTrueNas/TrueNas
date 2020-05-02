function Get-TrueNasSystemNTP
{
    [Alias()]
    Param
    ()

    Begin
    {

    }
    Process
    {
        $Uri = "api/v2.0/system/ntpserver"

        $results = Invoke-TrueNasRestMethod -Uri $Uri -Method Get

        foreach ($NTP in $results)
        {
            [PSCustomObject]@{
                Id      = ($NTP.id)
                Address = ($NTP.address)
                Burst   = ($NTP.burst)
                iburst  = ($NTP.iburst)
                prefer  = ($NTP.prefer)
                Minpoll = ($NTP.minpoll)
                Maxpoll = ($NTP.maxpoll)
            }
        }

    }
    End { }
}

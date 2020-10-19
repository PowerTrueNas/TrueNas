class TrueNascore :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNascore([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcorebulk([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("core/bulk" , "POST", $Body)
                                return $reponse
                    }
    [object]postcoredebug([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("core/debug" , "POST", $Body)
                                return $reponse
                    }
    [object]postcoredownload([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("core/download" , "POST", $Body)
                                return $reponse
                    }
    [object]getcoreget_events()
                    {
                                $reponse = .TrueNasRestMethod("core/get_events" , "GET")
                                return $reponse
                    }
    [object]getcoreget_jobs()
                    {
                                $reponse = .TrueNasRestMethod("core/get_jobs" , "GET")
                                return $reponse
                    }
    [object]postcoreget_methods([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("core/get_methods" , "POST", $Body)
                                return $reponse
                    }
    [object]getcoreget_services()
                    {
                                $reponse = .TrueNasRestMethod("core/get_services" , "GET")
                                return $reponse
                    }
    [object]postcorejob_abort([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("core/job_abort" , "POST", $Body)
                                return $reponse
                    }
    [object]postcorejob_update([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("core/job_update" , "POST", $Body)
                                return $reponse
                    }
    [object]postcorejob_wait([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("core/job_wait" , "POST", $Body)
                                return $reponse
                    }
    [object]getcoreping()
                    {
                                $reponse = .TrueNasRestMethod("core/ping" , "GET")
                                return $reponse
                    }
    [object]postcoreresize_shell([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("core/resize_shell" , "POST", $Body)
                                return $reponse
                    }
    [object]getcoresessions()
                    {
                                $reponse = .TrueNasRestMethod("core/sessions" , "GET")
                                return $reponse
                    }
}

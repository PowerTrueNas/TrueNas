class TrueNasservice :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasservice([TrueNasConfiguration]$param):base()
    {
    }
    [object]getservice()
                    {
                                $reponse = .TrueNasRestMethod("service" , "GET")
                                return $reponse
                    }
    [object]getserviceget_instance()
                    {
                                $reponse = .TrueNasRestMethod("service/get_instance" , "GET")
                                return $reponse
                    }
    [object]postservicereload([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("service/reload" , "POST", $Body)
                                return $reponse
                    }
    [object]postservicerestart([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("service/restart" , "POST", $Body)
                                return $reponse
                    }
    [object]postservicestart([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("service/start" , "POST", $Body)
                                return $reponse
                    }
    [object]getservicestarted()
                    {
                                $reponse = .TrueNasRestMethod("service/started" , "GET")
                                return $reponse
                    }
    [object]postservicestop([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("service/stop" , "POST", $Body)
                                return $reponse
                    }
    [object]postserviceterminate_process([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("service/terminate_process" , "POST", $Body)
                                return $reponse
                    }
}

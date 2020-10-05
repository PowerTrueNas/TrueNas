class TrueNascronjob :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNascronjob([TrueNasConfiguration]$param):base()
    {
    }
    [object]postcronjob([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cronjob" , "POST", $Body)
                                return $reponse
                    }
    [object]getcronjob()
                    {
                                $reponse = .TrueNasRestMethod("cronjob" , "GET")
                                return $reponse
                    }
    [object]getcronjobget_instance()
                    {
                                $reponse = .TrueNasRestMethod("cronjob/get_instance" , "GET")
                                return $reponse
                    }
    [object]postcronjobrun([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("cronjob/run" , "POST", $Body)
                                return $reponse
                    }
}

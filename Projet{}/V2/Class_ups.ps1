class TrueNasups :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasups([TrueNasConfiguration]$param):base()
    {
    }
    [object]putups([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("ups" , "PUT", $Body)
                                return $reponse
                    }
    [object]getups()
                    {
                                $reponse = .TrueNasRestMethod("ups" , "GET")
                                return $reponse
                    }
    [object]getupsdriver_choices()
                    {
                                $reponse = .TrueNasRestMethod("ups/driver_choices" , "GET")
                                return $reponse
                    }
    [object]getupsport_choices()
                    {
                                $reponse = .TrueNasRestMethod("ups/port_choices" , "GET")
                                return $reponse
                    }
}

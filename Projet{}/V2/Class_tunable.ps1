class TrueNastunable :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNastunable([TrueNasConfiguration]$param):base()
    {
    }
    [object]posttunable([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("tunable" , "POST", $Body)
                                return $reponse
                    }
    [object]gettunable()
                    {
                                $reponse = .TrueNasRestMethod("tunable" , "GET")
                                return $reponse
                    }
    [object]gettunableget_instance()
                    {
                                $reponse = .TrueNasRestMethod("tunable/get_instance" , "GET")
                                return $reponse
                    }
}

class TrueNasdyndns :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasdyndns([TrueNasConfiguration]$param):base()
    {
    }
    [object]putdyndns([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("dyndns" , "PUT", $Body)
                                return $reponse
                    }
    [object]getdyndns()
                    {
                                $reponse = .TrueNasRestMethod("dyndns" , "GET")
                                return $reponse
                    }
    [object]getdyndnsprovider_choices()
                    {
                                $reponse = .TrueNasRestMethod("dyndns/provider_choices" , "GET")
                                return $reponse
                    }
}

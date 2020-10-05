class TrueNasnetwork :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasnetwork([TrueNasConfiguration]$param):base()
    {
    }
    [object]putnetworkconfiguration([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("network/configuration" , "PUT", $Body)
                                return $reponse
                    }
    [object]getnetworkconfiguration()
                    {
                                $reponse = .TrueNasRestMethod("network/configuration" , "GET")
                                return $reponse
                    }
    [object]getnetworkgeneralsummary()
                    {
                                $reponse = .TrueNasRestMethod("network/general/summary" , "GET")
                                return $reponse
                    }
}

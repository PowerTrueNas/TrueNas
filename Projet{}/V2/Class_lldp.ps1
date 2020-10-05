class TrueNaslldp :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNaslldp([TrueNasConfiguration]$param):base()
    {
    }
    [object]putlldp([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("lldp" , "PUT", $Body)
                                return $reponse
                    }
    [object]getlldp()
                    {
                                $reponse = .TrueNasRestMethod("lldp" , "GET")
                                return $reponse
                    }
    [object]getlldpcountry_choices()
                    {
                                $reponse = .TrueNasRestMethod("lldp/country_choices" , "GET")
                                return $reponse
                    }
}

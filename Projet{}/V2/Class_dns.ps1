class TrueNasdns :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasdns([TrueNasConfiguration]$param):base()
    {
    }
    [object]getdnsquery()
                    {
                                $reponse = .TrueNasRestMethod("dns/query" , "GET")
                                return $reponse
                    }
}

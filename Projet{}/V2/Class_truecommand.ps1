class TrueNastruecommand :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNastruecommand([TrueNasConfiguration]$param):base()
    {
    }
    [object]puttruecommand([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("truecommand" , "PUT", $Body)
                                return $reponse
                    }
    [object]gettruecommand()
                    {
                                $reponse = .TrueNasRestMethod("truecommand" , "GET")
                                return $reponse
                    }
}

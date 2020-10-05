class TrueNasnfs :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasnfs([TrueNasConfiguration]$param):base()
    {
    }
    [object]putnfs([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("nfs" , "PUT", $Body)
                                return $reponse
                    }
    [object]getnfs()
                    {
                                $reponse = .TrueNasRestMethod("nfs" , "GET")
                                return $reponse
                    }
    [object]getnfsbindip_choices()
                    {
                                $reponse = .TrueNasRestMethod("nfs/bindip_choices" , "GET")
                                return $reponse
                    }
}

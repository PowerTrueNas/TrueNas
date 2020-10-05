class TrueNasrsyncd :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasrsyncd([TrueNasConfiguration]$param):base()
    {
    }
    [object]putrsyncd([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("rsyncd" , "PUT", $Body)
                                return $reponse
                    }
    [object]getrsyncd()
                    {
                                $reponse = .TrueNasRestMethod("rsyncd" , "GET")
                                return $reponse
                    }
}

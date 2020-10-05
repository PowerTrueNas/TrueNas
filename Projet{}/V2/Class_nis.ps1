class TrueNasnis :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasnis([TrueNasConfiguration]$param):base()
    {
    }
    [object]putnis([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("nis" , "PUT", $Body)
                                return $reponse
                    }
    [object]getnis()
                    {
                                $reponse = .TrueNasRestMethod("nis" , "GET")
                                return $reponse
                    }
    [object]getnisget_state()
                    {
                                $reponse = .TrueNasRestMethod("nis/get_state" , "GET")
                                return $reponse
                    }
}

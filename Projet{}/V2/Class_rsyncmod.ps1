class TrueNasrsyncmod :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasrsyncmod([TrueNasConfiguration]$param):base()
    {
    }
    [object]postrsyncmod([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("rsyncmod" , "POST", $Body)
                                return $reponse
                    }
    [object]getrsyncmod()
                    {
                                $reponse = .TrueNasRestMethod("rsyncmod" , "GET")
                                return $reponse
                    }
    [object]getrsyncmodget_instance()
                    {
                                $reponse = .TrueNasRestMethod("rsyncmod/get_instance" , "GET")
                                return $reponse
                    }
}

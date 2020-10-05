class TrueNasftp :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNasftp([TrueNasConfiguration]$param):base()
    {
    }
    [object]putftp([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("ftp" , "PUT", $Body)
                                return $reponse
                    }
    [object]getftp()
                    {
                                $reponse = .TrueNasRestMethod("ftp" , "GET")
                                return $reponse
                    }
}

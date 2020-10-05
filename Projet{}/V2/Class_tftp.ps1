class TrueNastftp :TrueNasConfiguration
    {
        [String]$CommonName
        [String]$Uri
        [PSobject]$Params

        TrueNastftp([TrueNasConfiguration]$param):base()
    {
    }
    [object]puttftp([psobject]$Body)
                    {
                                $reponse = .TrueNasRestMethod("tftp" , "PUT", $Body)
                                return $reponse
                    }
    [object]gettftp()
                    {
                                $reponse = .TrueNasRestMethod("tftp" , "GET")
                                return $reponse
                    }
}
